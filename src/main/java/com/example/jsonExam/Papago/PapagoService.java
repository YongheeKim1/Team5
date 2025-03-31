package com.example.jsonExam.Papago;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

@Service
public class PapagoService {

    private final String CLIENT_ID = "aio4fegw0z";
    private final String CLIENT_SECRET = "7s5IuBKhjtQVk4auHXUxUWv4V1n4L9SnPK0Vnfqy";

    public String translate(String text, String sourceLang, String targetLang) {
        String url = "https://naveropenapi.apigw.ntruss.com/nmt/v1/translation";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        headers.set("X-NCP-APIGW-API-KEY-ID", CLIENT_ID);
        headers.set("X-NCP-APIGW-API-KEY", CLIENT_SECRET);

        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("source", sourceLang);   // 예: "ko"
        params.add("target", targetLang);   // 예: "ja"
        params.add("text", text);

        HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(params, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.postForEntity(url, request, String.class);

        return extractTranslatedText(response.getBody());
    }

    private String extractTranslatedText(String json) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode root = objectMapper.readTree(json);
            return root.path("message").path("result").path("translatedText").asText();
        } catch (Exception e) {
            e.printStackTrace();
            return "(번역 실패)";
        }
       }
    }

    
    
