package com.example.demo.store;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class StoreController {

    @GetMapping("/store/storeRegist")
    public void storeRegist() {
    }

    @PostMapping("/store/registProc")
    public String storeRegistProc() {
        return null;
    }
}
