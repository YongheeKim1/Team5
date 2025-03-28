package com.example.jsonExam.news;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class NewsService {

    @Value("${naver.client.id}")
    private String clientId;

    @Value("${naver.client.secret}")
    private String clientSecret;

    private final String NAVER_NEWS_API_URL = "https://openapi.naver.com/v1/search/news.json";

    public List<NewsDTO> getNaverNews(String query, int display) {
        String url = UriComponentsBuilder.fromHttpUrl(NAVER_NEWS_API_URL)
                .queryParam("query", query)
                .queryParam("display", display)
                .queryParam("sort", "sim")
                .toUriString();

        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", clientId);
        headers.set("X-Naver-Client-Secret", clientSecret);
        headers.set("User-Agent", "Mozilla/5.0");

        HttpEntity<String> entity = new HttpEntity<>(headers);
        RestTemplate restTemplate = new RestTemplate();

        ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);

        List<NewsDTO> newsList = new ArrayList<>();
        if (response.getStatusCode() == HttpStatus.OK && response.getBody() != null) {
            Object itemsObj = response.getBody().get("items");
            if (itemsObj instanceof List) {
                List<Map<String, String>> items = (List<Map<String, String>>) itemsObj;
                for (Map<String, String> item : items) {
                    String title = item.get("title").replaceAll("<.*?>", "");  // HTML 태그 제거
                    String link = item.get("link");
                    String description = item.get("description").replaceAll("<.*?>", "");  // HTML 태그 제거
                    newsList.add(new NewsDTO(title, link, description));
                }
            }
        }
        return newsList;
    }
}
