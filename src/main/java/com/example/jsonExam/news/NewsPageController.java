package com.example.jsonExam.news;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/news/page")
public class NewsPageController {

    @GetMapping("")
    public String showNewsPage(Model model) {
        return "news"; // ✅ `/jsp/news.jsp`를 반환
    }
}
