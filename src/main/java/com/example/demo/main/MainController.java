package com.example.demo.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.demo.instruction.InstructionService;
import com.example.demo.notice.NoticeService;
import com.example.demo.prod.ProdService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

	@Autowired
	private HttpSession session;
	@Autowired
	private NoticeService noticeservice;
	

	@RequestMapping("main/mainform")
	public String mainform(Model model, @RequestParam(value = "currentPage", required = false) String cp) {
		String sessionId = (String) session.getAttribute("id");
        if (sessionId == null)
            return "/join/login";

		noticeservice.noticeform(cp, model, cp);


		return "main/mainform";
	}

}