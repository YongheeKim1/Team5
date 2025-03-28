package com.example.jsonExam.news;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/news") 
@CrossOrigin(origins = "*")
public class NewsController {

    @Autowired
    private NewsService newsService;

    @GetMapping("/search")
    public List<NewsDTO> searchNews(@RequestParam(required = false) String query, @RequestParam(defaultValue = "5") int display) {
        System.out.println("🔎 검색 요청: " + query);

        if (query == null || query.trim().isEmpty()) {
            System.out.println("🚨 오류: 검색어가 비어 있음");
            return List.of(); // ✅ 빈 리스트 반환 (404 방지)
        }

        List<NewsDTO> newsList = newsService.getNaverNews(query, display);
        System.out.println("📢 가져온 뉴스 개수: " + newsList.size());

        return newsList;
    }
}
