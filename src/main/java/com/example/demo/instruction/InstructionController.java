package com.example.demo.instruction;

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

import com.example.demo.orderStock.OrderStockService;
import com.example.demo.prod.BrandDTO;
import com.example.demo.prod.CateDTO;
import com.example.demo.prod.ColorDTO;
import com.example.demo.prod.ProdDTO;
import com.example.demo.prod.ProdService;

import jakarta.servlet.http.HttpSession;

@Controller
public class InstructionController {
    @Autowired
    private InstructionService service;
    @Autowired
    private ProdService prodService;
    @Autowired
    private OrderStockService orderStockService;
    @Autowired
    private HttpSession session;

    @GetMapping("/instruction/instructionform")
    public String instructionform(Model model, String regDate) {

        return "/instruction/instructionform";
    }

    @GetMapping("/instruction/instructionformSelect")
    public String instructionformSelect(RedirectAttributes ra, String regDate) {

        System.out.println(regDate);

        // regDate가 null이 아니면서 빈 문자열이 아닌 경우에만 instructionlist를 조회
        if (regDate != "" && !regDate.isEmpty()) {
            // instructionlist 조회하는 서비스 메서드를 호출하고 결과를 모델에 추가
            List<InstructionDTO> instructionlist = service.instructionlist(regDate);
            System.out.println(instructionlist);
            for (InstructionDTO dto : instructionlist) {
                System.out.println(dto.getNo());
                System.out.println(dto.getBrandCode());
                System.out.println(dto.getProdNo());
            }
            ra.addFlashAttribute("prods", instructionlist);
        }

        return "redirect:/instruction/instructionform";
    }

    @RequestMapping("/instruction/instructionwrite")
    public String instructionWrite(Model model) {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null) {
            return "redirect:/";
        }
        orderStockService.storeList(model);
        List<InstructionDTO> instructionDTOLists = service.getAllInstructionData();
        List<CateDTO> cateGroups = prodService.cateGroupList();
        List<CateDTO> cateCodes = prodService.cateCodeList();
        List<BrandDTO> brandCodes = prodService.brandCodeList();
        List<ColorDTO> colorCodes = prodService.colorCodeList();

        model.addAttribute("instructionDTOLists", instructionDTOLists);
        model.addAttribute("cateGroups", cateGroups);
        model.addAttribute("cateCodes", cateCodes);
        model.addAttribute("brandCodes", brandCodes);
        model.addAttribute("colorCodes", colorCodes);
        return "instruction/instructionwrite";
    }

    @PostMapping("/instruction/instructionwriteProc")
    public String instructionwriteProc(@RequestParam("selectedProducts") List<String> selectedProducts,
            @RequestParam("respQuan") List<Integer> respQuanList,
            @RequestParam("storeName") List<String> storeNameList, Model model) {

        for (int i = 0; i < selectedProducts.size(); i++) {
            if (respQuanList.get(i) != null && storeNameList.get(i) != null) { // 요청수량 또는 매장명이 있을 때만 실행
                String prodNo = selectedProducts.get(i);
                int respQuan = respQuanList.get(i);
                String storeName = storeNameList.get(i);
                System.out.println("뭐야? : " + prodNo + "\n" + respQuan + "\n" +
                        storeName + " /");

                String confirm = service.instructionwriteProc(prodNo, respQuan, storeName);

                if (!confirm.equals("success")) {
                    model.addAttribute("msg", confirm);
                    return "instruction/instructionwrite";
                }
            }
        }
        return "instruction/instructionwrite";
    }

    @PostMapping("/searchInst")
    public String unprodList(@ModelAttribute("prod") ProdDTO prod,
            RedirectAttributes ra) {

        if (prod.getCateCode().trim().isEmpty()
                && prod.getCateGroup().trim().isEmpty()
                && prod.getColorCode().trim().isEmpty()
                && prod.getSize().trim().isEmpty()
                && prod.getProdNo().trim().isEmpty()) {
            System.out.println(prod.getCateCode());
            System.out.println(prod.getColorCode());
            return "redirect:/unstoring";
        }

        List<ProdDTO> plist = prodService.prodList(prod);
        ra.addFlashAttribute("prods", plist);
        System.out.println("확인" + plist);
        return "redirect:/instruction/instructionwrite";

    }

}
