package com.example.demo.Rt;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class RtController { // 서비스에 있는 기능 가져다 쓰기
    @Autowired
    private RtService service;

    @RequestMapping("rt/entryform")
    public String entryform(Model model, @RequestParam(value = "currentPage", required = false) String cp) {
        service.entryform(cp, model);

        return "rt/entryform";
    }

    @RequestMapping("rt/exportform")
    public String exportform(Model model, @RequestParam(value = "currentPage", required = false) String cp) {
        service.exportform(cp, model);

        return "rt/exportform";
    }

    @RequestMapping("rt/exportwrite")
    public String exportwrite(Model model, @RequestParam(value = "currentPage", required = false) String cp) {
        service.exportwrite(cp, model);

        return "rt/exportwrite";
    }

    @RequestMapping("rt/processingstform")
    public String processingstform(Model model, @RequestParam(value = "currentPage", required = false) String cp) {
        service.processingstform(cp, model);

        return "rt/processingstform";
    }

    @RequestMapping("rt/instructionwrite")
    public String instructionwrite(Model model, @RequestParam(value = "currentPage", required = false) String cp) {
        service.instructionwrite(cp, model);

        return "rt/instructionwrite";
    }

}
