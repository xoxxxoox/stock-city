package com.example.demo.join;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.DbConfig;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class JoinController {

    @Autowired
    private HttpSession session;
    @Autowired
    private JoinService service;
    @Autowired
    private DbConfig dbConfig;

    @RequestMapping("/join/regist")
    public String regist() {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId != null)
            return "/main/mainform";

        return "/join/regist";
    }

    @PostMapping("/registProc")
    public String registProc(JoinDTO joins, Model model) {
        String confirm = service.registProc(joins, model);

        if (confirm.equals("success"))
            return "redirect:/";

        model.addAttribute("msg", confirm);
        return "/join/regist";
    }

    @RequestMapping("/join/login")
    public String login() {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId != null)
            return "/main/mainform";
            
        return "/join/login";
    }

    @PostMapping("/loginProc")
    public String loginProc(HttpServletRequest request, String id, String pw, Model model) {
        String confirm = service.loginProc(request, id, pw);
        JoinDTO checkStatus = service.checkStatus(id);

        if (confirm.equals("success")) {
            if ("approve".equals(checkStatus.getRegistStatus()) || "active".equals(checkStatus.getRegistStatus()))
                return "redirect:/main/mainform"; // registStatus가 approve or active일 때만 로그인 가능

            model.addAttribute("msg", "미승인 회원입니다.");
            session.invalidate(); // session에 값이 남아있을 수 있기 때문에(남을 확률 낮음) session값 제거
            return "/join/login";
        }
        model.addAttribute("msg", confirm);
        return "/join/login";
    }

    @RequestMapping("/logout")
    public String logout() {
        session.invalidate();
        dbConfig.setLogoutDatabase(); // demoDB로 복귀

        return "redirect:/";
    }

    // 매장 정보
    @RequestMapping("/userInfo")
    public String userInfo() {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId != null)
            return "/join/userInfo";

        return "/join/login";
    }

    @RequestMapping("/update")
    public String update() {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId == null)
            return "redirect:/";

        return "/join/update";
    }

    @PostMapping("/updateProc")
    public String updateProc(JoinDTO joins, StoreDTO stores, Model model) {
        String sessionId = (String) session.getAttribute("id");

        joins.setId(sessionId);
        String confirm = service.updateProc(joins, stores);
        if (confirm.equals("success")) {
            session.invalidate();
            return "redirect:/";
        }

        model.addAttribute("msg", confirm);
        return "/join/update";
    }

    // 고객사 본사의 매장들 관리(userInfo와 다름)
    @RequestMapping("/manageInfo")
    public String manageInfo(Model model, JoinDTO join) {
        String accountId = (String) session.getAttribute("accountId");
        if (!"root".equals(accountId))
            return "redirect:/";

        service.manageInfo(model, join);
        return "/join/manageInfo";
    }

    // 본사가 매장들의 계정 상태를 변경
    @RequestMapping("/statusModify")
    public String statusModify(@RequestParam("id") String selectId, JoinDTO join, Model model) {
        join.setId(selectId); // 선택한 사용자의 ID의 registStatus를 변경
        String confirm = service.statusModify(join);
        if (confirm.equals("success")) {
            return "redirect:/manageInfo";
        }

        model.addAttribute("msg", confirm);
        return "/join/manageInfo";
    }

    @RequestMapping("/storeDelete")
    public String storeDelete(@RequestParam("id") String selectId, @RequestParam("adCount") String selectAdCount, @RequestParam("dbName") String selectDbName, JoinDTO join) {
        String accountId = (String) session.getAttribute("accountId");
        if (!"root".equals(accountId))
            return "redirect:/";

        join.setId(selectId); // 선택한 사용자의 ID를 Proc으로
        join.setAdCount(selectAdCount);
        join.setDbName(selectDbName);

        return "/join/storeDelete";
    }

    @PostMapping("/storeDeleteProc")
    public String storeDeleteProc(@RequestParam("id") String selectId, @RequestParam("adCount") String selectAdCount, @RequestParam("dbName") String selectDbName, JoinDTO join, Model model) {
        join.setId(selectId); // 선택한 사용자의 ID를 삭제
        join.setAdCount(selectAdCount);
        join.setDbName(selectDbName);
        String confirm = service.storeDeleteProc(join);
        if (confirm.equals("success")) {
            return "redirect:/manageInfo";
        }

        model.addAttribute("msg", confirm);
        return "/join/storeDelete";
    }
}