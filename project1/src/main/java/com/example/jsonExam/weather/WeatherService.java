package com.example.jsonExam.weather;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.URI;
import java.net.URISyntaxException;
import java.time.LocalDate;
import java.util.*;

@Service
public class WeatherService {

    private final RestTemplate restTemplate = new RestTemplate();

    private static final String API_URL = "http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"; // 기상청 API URL
    private static final String API_KEY = "83J%2BZlSbumSCc2rBcCipXddnGvjm7eTJIpu6ZFEJFY3BV2SqHP3VsxxsXK3m5jQhb8D%2FoXKVulq5Gv4xzLu72Q%3D%3D"; // API 키
    private static final String PAGE_NO = "1";
    private static final String PAGE_SIZE = "30";

    public WeatherModel.WeatherResponse getUltraSrtNcst() throws URISyntaxException {
        String date = LocalDate.now().toString();
        URI uri = new URI(API_URL
                + "?serviceKey=" + API_KEY
                + "&numOfRows=" + PAGE_SIZE
                + "&pageNo=" + PAGE_NO
                + "&base_date=" + date.replace("-", "")
                + "&base_time=0830&nx=37&ny=126&dataType=JSON");

        WeatherModel.WeatherSearchData weather =
                restTemplate.getForObject(uri, WeatherModel.WeatherSearchData.class);

        if(weather == null){
            throw new IllegalStateException("날씨 데이터 조회 실패");
        }

        List<WeatherModel.WeatherItem> weatherItems = weather.getWeatherItems();

        String temp = getWeatherInfo(weatherItems, "TMP");
        String moisture = getWeatherInfo(weatherItems, "REH");
        String windSpeed = getWeatherInfo(weatherItems, "WSD");

      return new WeatherModel.WeatherResponse(temp, moisture, windSpeed, date);
    }

    // 날씨 카테고리에 해당하는 정보 조회
    private String getWeatherInfo(List<WeatherModel.WeatherItem> weatherItems, String category) {
        Optional<WeatherModel.WeatherItem> weatherItem = weatherItems.stream().filter(it -> it.getCategory().equals(category)).findFirst();

        if(weatherItem.isPresent()) {
            return weatherItem.get().getFcstValue();
        }
        return "N/A";
    }
}
