package com.example.demo.prod;

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

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("prod")
public class ProdController {

    @Autowired
    ProdService service;
    @Autowired
    private HttpSession session;

    // 브랜드코드 추가
    @PostMapping("brandInsert") // modal action에는 "/" <-- 추가 x
    public String addBrand(BrandDTO brand, RedirectAttributes ra) {
        System.out.println(brand.getBrandCode()); // 값 출력
        if (brand.getBrandCode() != null || !brand.getBrandCode().trim().isEmpty()) {
            service.addBrand(brand);
            System.out.println("brandCode:" + brand.getBrandCode());
            ra.addFlashAttribute("msg", "brandCode 추가 성공");

            return "redirect:/prod/prodInsert";
        }
        return "/prod/prodInsert";
    }

    // 카테고리 추가
    @GetMapping("/cateInsert")
    public String cateInsert() {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null) {
            return "redirect:/";
        }
        return "prod/cateInsert";
    }

    @PostMapping("cateInsert")
    public String addCategory(CateDTO cate, RedirectAttributes ra) {

        if (cate.getCateGroup() != null || !cate.getCateGroup().trim().isEmpty()) {
            service.addCategory(cate);
            System.out.println("cateCode:" + cate.getCateCode());
            ra.addFlashAttribute("msg", "cateCode 추가 성공");

            return "redirect:/prod/prodInsert";
        }
        return "/prod/prodInsert";
    }

    @PostMapping("colorInsert")
    public String addColor(ColorDTO color, RedirectAttributes ra) {

        if (color.getColorCode() != null || !color.getColorCode().trim().isEmpty()) {
            service.addColor(color);
            System.out.println("ColorCode:" + color.getColorCode());
            System.out.println("ColorName:" + color.getColorName());
            ra.addFlashAttribute("msg", "ColorCode 추가 성공");

            return "redirect:/prod/prodInsert";
        }
        return "/prod/prodInsert";
    }

    // 상품등록
    @RequestMapping("/prodInsert")
    public String prodInsert(Model model) {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null)
            return "/join/login";
            
        List<CateDTO> cateGroups = service.cateGroupList();
        List<CateDTO> cateCodes = service.cateCodeList();
        List<BrandDTO> brandCodes = service.brandCodeList();
        List<ColorDTO> colorCodes = service.colorCodeList();

        model.addAttribute("cateGroups", cateGroups);
        model.addAttribute("cateCodes", cateCodes);
        model.addAttribute("brandCodes", brandCodes);
        model.addAttribute("colorCodes", colorCodes);
        System.out.println("test: " + brandCodes);
        return "prod/prodInsert";

    }

    @PostMapping("prodInsertProc")
    public String prodInsertProc(ProdDTO prods, RedirectAttributes ra) {

        String msg = service.prodInsertProc(prods);
        ra.addFlashAttribute("msg", msg);

        return "redirect:/prod/prodManage";
    }

    // 상품조회, 관리
    @RequestMapping("/prodManage")
    public String prodManage(Model model) {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null)
            return "/join/login";

        List<CateDTO> cateGroups = service.cateGroupList();
        List<CateDTO> cateCodes = service.cateCodeList();
        List<BrandDTO> brandCodes = service.brandCodeList();
        List<ColorDTO> colorCodes = service.colorCodeList();

        model.addAttribute("cateGroups", cateGroups);
        model.addAttribute("cateCodes", cateCodes);
        model.addAttribute("brandCodes", brandCodes);
        model.addAttribute("colorCodes", colorCodes);
        return "/prod/prodManage";
    }

    // 등록상품 조회
    @PostMapping("prodList")
    public String prodList(@ModelAttribute("prod") ProdDTO prod, RedirectAttributes ra) {

        if (prod.getCateCode().trim().isEmpty()
                && prod.getCateGroup().trim().isEmpty()
                && prod.getColorCode().trim().isEmpty()
                && prod.getSize().trim().isEmpty()
                && prod.getProdNo().trim().isEmpty()) {
            System.out.println(prod.getCateCode());
            System.out.println(prod.getColorCode());
            return "redirect:/prod/prodManage";
        }
        System.out.println("cateGroup" + prod.getCateGroup());
        System.out.println("cateCode" + prod.getCateCode());
        System.out.println("colorCode" + prod.getColorCode());
        System.out.println("size" + prod.getSize());
        System.out.println("prodNo" + prod.getProdNo());

        // String cateC = cateGroup + "(" + prod.getCateCode() + ")";
        // prod.setCateCode(cateC);
        List<ProdDTO> plist = service.prodList(prod);
        ra.addFlashAttribute("prods", plist);
        System.out.println("확인" + plist);
        return "redirect:/prod/prodManage";

    }

    @RequestMapping("stockStatus")
    public String stockManage(Model model) {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null)
            return "/join/login";

        List<CateDTO> cateGroups = service.cateGroupList();
        List<CateDTO> cateCodes = service.cateCodeList();
        List<BrandDTO> brandCodes = service.brandCodeList();
        List<ColorDTO> colorCodes = service.colorCodeList();
        List<String> storeNames = service.storeNameList();

        model.addAttribute("cateGroups", cateGroups);
        model.addAttribute("cateCodes", cateCodes);
        model.addAttribute("brandCodes", brandCodes);
        model.addAttribute("colorCodes", colorCodes);
        model.addAttribute("storeNames", storeNames);

        return "/prod/stockStatus";
    }

    @PostMapping("prod/stockList")
    public String stockList(StockStatusDTO ss, RedirectAttributes ra) {

        List<StockStatusDTO> stockLists = service.stockStatusList(ss);

        System.out.println("체크 : " + stockLists);

        ra.addFlashAttribute("dataList", stockLists);
        return "redirect:/prod/stockStatus";
    }

    @GetMapping("/getProdInfo")
    public String prodInfo(@RequestParam(name = "prodNo") String prodNo) {
        return "prodNo";
    }

}