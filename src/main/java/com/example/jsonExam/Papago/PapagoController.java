package com.example.jsonExam.Papago;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/translate")
public class PapagoController {

    @Autowired
    private PapagoService papagoService;

    /**
     * 게시글 제목 + 내용 번역 (form-data or JS 요청 대응)
     * ex) POST /api/translate/post
     */
    @ResponseBody
    @PostMapping("/post")
    public Map<String, String> translatePost(@RequestParam String title,
                                             @RequestParam String content,
                                             @RequestParam(defaultValue = "ko2ja") String direction) {

        String source = direction.equals("ko2ja") ? "ko" : "ja";
        String target = direction.equals("ko2ja") ? "ja" : "ko";

        String translatedTitle = papagoService.translate(title, source, target);
        String translatedContent = papagoService.translate(content, source, target);
        
        System.out.println("🈶 번역된 제목: " + translatedTitle);
        System.out.println("🈶 번역된 내용: " + translatedContent);


        Map<String, String> result = new HashMap<>();
        result.put("title", translatedTitle);
        result.put("content", translatedContent);
        return result;
    }
}
