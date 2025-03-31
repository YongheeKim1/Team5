package com.example.jsonExam.weather;

import java.util.List;

public class WeatherModel {

  public static class WeatherResponse {
    private String temp;
    private String moisture;
    private String windSpeed;
    private String date;

    public WeatherResponse(String temp, String moisture, String windSpeed, String date) {
      this.temp = temp;
      this.moisture = moisture;
      this.windSpeed = windSpeed;
      this.date = date;
    }

    public String getTemp() {
      return temp;
    }

    public String getMoisture() {
      return moisture;
    }

    public String getWindSpeed() {
      return windSpeed;
    }

    public String getDate() {
      return date;
    }
  }

  public static class WeatherSearchData {
    private Weather response;

    public List<WeatherItem> getWeatherItems() {
      return this.response.body.items.item;
    }

    public WeatherSearchData() {}

    public Weather getResponse() {
      return response;
    }
  }

  public static class Weather {
    private WeatherData body;

    public Weather() {}
    public WeatherData getBody() {
      return body;
    }
  }

  public static class WeatherArr {
    public List<WeatherItem> getItem() {
      return item;
    }

    List<WeatherItem> item;
  }

  public static class WeatherData {
    private String dataType;
    private WeatherArr items;

    public String getDataType() {
      return dataType;
    }

    public WeatherArr getItems() {
      return items;
    }

    public WeatherData() {};
  }

  public static class WeatherItem {
    private String category;
    private String fcstValue;

    public WeatherItem() {}

    public String getCategory() {
      return category;
    }

    public String getFcstValue() {
      return fcstValue;
    }
  }
}
