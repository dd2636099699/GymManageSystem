package com.luguzhi.gymxmjpa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class TestController {

    @GetMapping("/test")
    public String showTestPage() {
        return "test"; // 返回视图名称，不包括.jsp后缀
    }
}
