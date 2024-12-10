package com.example.demo.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.DbConfig;
import com.example.demo.join.JoinDTO;
import com.example.demo.mail.MailContents;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private HttpSession session;
    @Autowired
    private AdminService service;
    @Autowired
    private AdminMapper mapper;
    @Autowired
    private MailContents mailContents;
    @Autowired
    private DbConfig dbConfig;

    // admin 회원가입 페이지(1회성)
    @RequestMapping("/admin/adminRegist")
    public String adminRegist(Model model) {
        List<AdminDTO> admin = mapper.findAll(); // admin 테이블의 모든 정보를 가져옴
        if (!admin.isEmpty()) { // 어드민에 값이 1개라도 존재한다면 접속 불가.(관리자 계정은 1개만 존재하기 때문에)
            model.addAttribute("msg", "permission denied");
            return "/admin/adminLogin";
        }

        return "/admin/adminRegist";
    }

    // admin 회원가입 기능
    @PostMapping("/adminRegistProc")
    public String registProc(AdminDTO admins, Model model) {
        String confirm = service.adminRegistProc(admins, model);

        if (confirm.equals("success"))
            return "redirect:/suadonghyeonyeonjidongwoonsangwon@SC";

        model.addAttribute("msg", confirm);
        return "/admin/adminRegist";
    }

    // admin login 페이지
    @RequestMapping("/suadonghyeonyeonjidongwoonsangwon@SC")
    public String adminLogin() {
        dbConfig.setLogoutDatabase(); // demoDB에 admin 테이블에만 관리자 계정이 있기 때문에 demoDB로 오도록

        return "/admin/adminLogin";
    }

    // admin login 기능
    @PostMapping("/adminLoginProc")
    public String adminLoginProc(HttpServletRequest request, String aId, String aPw, Model model) {
        String confirm = service.adminLoginProc(request, aId, aPw);

        if (confirm.equals("success"))
            return "redirect:/adminInfo";

        model.addAttribute("msg", confirm);
        return "/admin/adminLogin";
    }

    // 고객사 정보 페이지
    @RequestMapping("/adminInfo")
    public String adminInfo(Model model, JoinDTO join) {
        String sessionId = (String) session.getAttribute("aId");
        if (sessionId == null)
            return "redirect:/";

        dbConfig.setLogoutDatabase(); // demo DB로 돌아와야 모든 회사의 정보가 보임
        service.adminInfo(model, join); // user테이블 list로 받아와서 보여줌
        return "/admin/adminInfo";
    }

    // 관리자 이메일 승인 로직
    @GetMapping("/verifyProc")
    public String verifyProc(@RequestParam(name = "email") String email, Model model) throws Exception {
        JoinDTO checkAccount = service.checkAccount(email); // 회원가입 요청을 한 회사의 이메일을 가져옴
        String confirm = service.verifyProc(checkAccount); // 이메일 값을 가져와서 로그인이 가능하게 registStatus를 approve로 변경

        if (confirm.equals("success")) {
            mailContents.sendSimpleMessage(email, checkAccount); // 이메일을 보내는 기능
            return "redirect:/adminInfo";
        }

        model.addAttribute("msg", confirm);
        return "/admin/adminInfo";
    }

    // 활성화(active)
    @RequestMapping("/adminStatusActiveModify")
    public String adminStatusActiveModify(@RequestParam("dbName") String selectDbName, JoinDTO join, Model model) {
        join.setDbName(selectDbName); // 선택한 사용자 dbName의 해당하는 registStatus를 모두 변경
        String confirm = service.adminStatusActiveModify(join);
        if (confirm.equals("success")) {
            return "redirect:/adminInfo";
        }

        model.addAttribute("msg", confirm);
        return "/admin/adminInfo";
    }

    // 비활성화(inactive)
    @RequestMapping("/adminStatusInactiveModify")
    public String adminStatusInactiveModify(@RequestParam("dbName") String selectDbName, JoinDTO join, Model model) {
        join.setDbName(selectDbName); // 선택한 사용자 dbName의 해당하는 registStatus를 모두 변경
        String confirm = service.adminStatusInactiveModify(join);
        if (confirm.equals("success")) {
            return "redirect:/adminInfo";
        }

        model.addAttribute("msg", confirm);
        return "/admin/adminInfo";
    }

    // 고객사 삭제 페이지
    @RequestMapping("/adminRootDelete")
    public String adminRootDelete(@RequestParam("dbName") String selectDbName, JoinDTO join) {
        String sessionId = (String) session.getAttribute("aId");
        if (sessionId == null)
            return "redirect:/";

        join.setDbName(selectDbName); // 선택한 사용자의 dbName을 Proc으로

        return "/admin/adminRootDelete";
    }

    // 고객사 삭제 기능
    @PostMapping("/adminRootDeleteProc")
    public String adminRootDeleteProc(@RequestParam("dbName") String selectDbName, JoinDTO join, Model model) {
        join.setDbName(selectDbName); // 선택한 사용자의 ID를 삭제
        String confirm = service.adminRootDeleteProc(join);
        if (confirm.equals("success")) {
            return "redirect:/adminInfo";
        }

        model.addAttribute("msg", confirm);
        return "/admin/adminRootDelete";
    }

    // 서브 계정 '추가' 생성 기능
    @PostMapping("/createSubAccounts")
    public String createSubAccounts(HttpServletRequest request) throws Exception {
        String mainId = request.getParameter("mainId"); // @RequestParam("mainId") String mainId 매개변수와 같은 기능(이하 동일)
        String mainEmail = request.getParameter("mainEmail");
        int adCount = Integer.parseInt(request.getParameter("adCount"));
        int count = Integer.parseInt(request.getParameter("editAccount"));
        String dbName = request.getParameter("dbName");

        JoinDTO joins = mapper.checkMainId(mainId); // user 테이블의 아이디가 같은 모든 값을 검색
        joins.setId(mainId);
        joins.setEmail(mainEmail);
        joins.setRegistStatus("active"); // mailContents 클래스에 if문 조건을 만족하기 위해
        joins.setAdCount(Integer.toString(adCount)); // 요청 받은 계정 수
        joins.setCount(Integer.toString(count)); // 추가 요청 수량
        joins.setDbName(dbName);

        mailContents.sendSimpleMessage(mainEmail, joins);

        return "redirect:/adminInfo";
    }

}
