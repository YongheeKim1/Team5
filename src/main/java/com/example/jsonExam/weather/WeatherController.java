package com.example.jsonExam.weather;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.net.URISyntaxException;

@Controller
public class WeatherController {

    @Autowired
    private WeatherService weatherService;

    @GetMapping("/weather")
    public String getWeather(Model model) throws URISyntaxException {
        WeatherModel.WeatherResponse weather = weatherService.getUltraSrtNcst();

        model.addAttribute("weatherData", weather); // 날씨 데이터를 JSP로 전달
        return "weather"; // "weather.jsp" 파일로 데이터를 넘김
    }
    
    @GetMapping("/template")
    public String gettemplate(Model model) throws URISyntaxException {
        WeatherModel.WeatherResponse weather = weatherService.getUltraSrtNcst();

        model.addAttribute("weatherData", weather); // 날씨 데이터를 JSP로 전달
        return "template"; // "weather.jsp" 파일로 데이터를 넘김
    }
}
