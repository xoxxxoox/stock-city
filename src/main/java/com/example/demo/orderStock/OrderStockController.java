package com.example.demo.orderStock;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.prod.BrandDTO;
import com.example.demo.prod.CateDTO;
import com.example.demo.prod.ColorDTO;
import com.example.demo.prod.ProdDTO;
import com.example.demo.prod.ProdService;
import com.opencsv.CSVWriter;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderStockController {

    @Autowired
    private HttpSession session;
    @Autowired
    private OrderStockService service;
    @Autowired
    private ProdService prodService;

    // 입고
    @RequestMapping("/storing")
    public String storing(Model model) {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null)
            return "/join/login";

        List<CateDTO> cateGroups = prodService.cateGroupList();
        List<CateDTO> cateCodes = prodService.cateCodeList();
        List<BrandDTO> brandCodes = prodService.brandCodeList();
        List<ColorDTO> colorCodes = prodService.colorCodeList();

        model.addAttribute("cateGroups", cateGroups);
        model.addAttribute("cateCodes", cateCodes);
        model.addAttribute("brandCodes", brandCodes);
        model.addAttribute("colorCodes", colorCodes);

        return "/orderStock/storing";
    }

    // 입고 신청 버튼 클릭 시 기능
    @PostMapping("/storingProc")
    public String storingProc(@RequestParam("selectedProducts") List<String> selectedProducts,
            @RequestParam("reqQuan") List<Integer> reqQuanList, Model model) {

        for (int i = 0; i < selectedProducts.size(); i++) { // 선택 체크박스 수량만큼 반복
            if (reqQuanList.get(i) != null) { // 요청수량이 있을 때만 실행
                String prodNo = selectedProducts.get(i);
                int reqQuan = reqQuanList.get(i);

                String confirm = service.storingProc(prodNo, reqQuan);

                if (!confirm.equals("success")) {
                    model.addAttribute("msg", confirm);
                    return "/orderStock/storing";
                }
            }
        }
        return "redirect:/storing"; // 성공 시
    }

    // 재고 검색 버튼 클릭 시
    @PostMapping("/searchStoring")
    public String prodList(@ModelAttribute("prod") ProdDTO prod, RedirectAttributes ra) {

        if (prod.getCateCode().trim().isEmpty()
                && prod.getCateGroup().trim().isEmpty()
                && prod.getColorCode().trim().isEmpty()
                && prod.getSize().trim().isEmpty()
                && prod.getProdNo().trim().isEmpty()) {
            System.out.println(prod.getCateCode());
            System.out.println(prod.getColorCode());
            return "redirect:/storing";
        }

        List<ProdDTO> plist = service.prodList(prod);
        ra.addFlashAttribute("prods", plist);
        System.out.println("확인" + plist);
        return "redirect:/storing";

    }

    // 입출고 조회(io == in/out)
    @GetMapping("/ioCheck")
    public String ioCheck(@RequestParam(name = "radioButton", required = false) String radioButton, Model model) {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null)
            return "/join/login";

        service.stockList(model);

        model.addAttribute("radioButton", radioButton); // 라디오 버튼의 값을 모델에 추가

        return "/orderStock/ioCheck";
    }

    // 본사가 입고 요청 승인을 눌렀을 때 동작
    @RequestMapping("/storingApprove")
    public String storingApprove(OrderStockDTO store, Model model) {
        String confirm = service.storingApprove(store, model);

        if (confirm.equals("success"))
            return "redirect:/ioCheck";

        model.addAttribute("msg", confirm);
        return "/orderStock/ioCheck";
    }

    // 요청 거절 눌렀을 때
    @RequestMapping("/storingDenied")
    public String storingDenied(OrderStockDTO store) {
        String confirm = service.storingDenied(store); // 해당 데이터의 orderStatus를 '요청 거절'로 업데이트

        if (confirm.equals("success"))
            return "redirect:/ioCheck";

        return "/orderStock/ioCheck";
    }

    // 출고 페이지
    @RequestMapping("/unstoring")
    public String unstoring(Model model) {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null)
            return "/join/login";

        List<CateDTO> cateGroups = prodService.cateGroupList();
        List<CateDTO> cateCodes = prodService.cateCodeList();
        List<BrandDTO> brandCodes = prodService.brandCodeList();
        List<ColorDTO> colorCodes = prodService.colorCodeList();
        service.storeList(model); // 매장들 이름을 받아옴

        model.addAttribute("cateGroups", cateGroups);
        model.addAttribute("cateCodes", cateCodes);
        model.addAttribute("brandCodes", brandCodes);
        model.addAttribute("colorCodes", colorCodes);

        return "/orderStock/unstoring";
    }

    // 본사가 출고 버튼 클릭 시
    @PostMapping("/unstoringProc")
    public String unstoringProc(@RequestParam("selectedProducts") List<String> selectedProducts,
            @RequestParam("respQuan") List<Integer> respQuanList,
            @RequestParam("storeName") List<String> storeNameList, Model model) {

        for (int i = 0; i < selectedProducts.size(); i++) {
            if (respQuanList.get(i) != null && storeNameList.get(i) != null) { // 요청수량 또는 매장명이 있을 때만 실행
                String prodNo = selectedProducts.get(i);
                int respQuan = respQuanList.get(i);
                String storeName = storeNameList.get(i);

                String confirm = service.unstoringProc(prodNo, respQuan, storeName);

                if (!confirm.equals("success")) {
                    model.addAttribute("msg", confirm);
                    return "/orderStock/unstoring";
                }
            }
        }
        return "redirect:/unstoring"; // 성공 시
    }

    // 출고 가능한 상품 조회
    @PostMapping("/searchUnstoring")
    public String unprodList(@ModelAttribute("prod") ProdDTO prod, RedirectAttributes ra) {

        if (prod.getCateCode().trim().isEmpty()
                && prod.getCateGroup().trim().isEmpty()
                && prod.getColorCode().trim().isEmpty()
                && prod.getSize().trim().isEmpty()
                && prod.getProdNo().trim().isEmpty()) {
            System.out.println(prod.getCateCode());
            System.out.println(prod.getColorCode());
            return "redirect:/unstoring";
        }

        List<ProdDTO> plist = service.prodList(prod);
        ra.addFlashAttribute("prods", plist);
        System.out.println("확인" + plist);
        return "redirect:/unstoring";

    }

    // csv 파일 다운로드 - 의존성 추가 필요
    // 참고 자료 : https://suyou.tistory.com/311 [수유산장:티스토리]
    @GetMapping("/csv/down")
    public void csvDown(HttpServletResponse response) throws IOException {
        response.setContentType("text/csv; charset=UTF-8"); // csv 파일 + UTF-8 명시
        String fileName = URLEncoder.encode("입출고_내역.csv", "UTF-8"); // 파일명도 UTF-8 명시
        response.setHeader("Content-Disposition",
                "attachment; filename=\"" + fileName + "\"");

        OutputStreamWriter writer = new OutputStreamWriter(response.getOutputStream(),
                StandardCharsets.UTF_8);
        writer.write("\uFEFF"); // UTF-8-BOM임을 표시 -> 이거 없으면 엑셀에서 전세계 언어 다 깨짐
        CSVWriter csvWriter = new CSVWriter(writer);

        csvWriter.writeAll(service.listCsvString());

        csvWriter.close();
        writer.close();
    }

}
