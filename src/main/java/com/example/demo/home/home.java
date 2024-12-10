package com.example.demo.home;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.http.HttpSession;

@Controller
public class home {

    @Autowired
    private HttpSession session;

    @RequestMapping("/")
    public String homePage() {
        String sessionId = (String) session.getAttribute("id");
        if (sessionId != null)
            return "/main/mainform";

        return "/join/login";
    }

    @RequestMapping("/index")
    public String index() {
        return "/test/index";
    }

    @RequestMapping("/header")
    public String header() {
        return "/default/header";
    }

    @RequestMapping("/sider")
    public String sider() {
        return "/default/sider";
    }

}
