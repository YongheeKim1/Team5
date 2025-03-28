<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TEAM5 날씨 게시판</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Noto Sans KR', 'Malgun Gothic', sans-serif;
        }
        
        body {
            background-color: #f5f6f7;
            color: #222;
        }
        
        .container {
            width: 100%;
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }
        
        header {
            background-color: #03c75a;
            padding: 12px 0;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: relative;
        }
        
        .logo {
            font-size: 22px;
            font-weight: bold;
            text-align: center;
            color: white;
        }

        .back-btn {
            position: absolute;
            left: 20px;
            top: 50%;
            transform: translateY(-50%);
            background-color: white;
            color: #03c75a;
            border: 1px solid #03c75a;
            padding: 8px 16px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
        }

        .back-btn:hover {
            background-color: #f5f5f5;
        }
        
        .nav {
            background-color: white;
            border-bottom: 1px solid #e5e5e5;
        }
        
        .nav .container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 0;
        }
        
        .nav-links {
            display: flex;
            list-style: none;
        }
        
        .nav-links li {
            margin: 0;
        }
        
        .nav-links a {
            display: block;
            text-decoration: none;
            color: #333;
            font-size: 15px;
            padding: 14px 20px;
            position: relative;
        }
        
        .nav-links a:hover {
            color: #03c75a;
        }
        
        .nav-links a.active {
            color: #03c75a;
            font-weight: bold;
        }
        
        .nav-links a.active:after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background-color: #03c75a;
        }
        
        .weather-container {
            margin: 30px 0;
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }
        
        .weather-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 20px;
            text-align: center;
            width: 48%;
        }
        
        @media (max-width: 768px) {
            .weather-card {
                width: 100%;
            }
        }
        
        .weather-card h2 {
            color: #333;
            margin-bottom: 15px;
            font-size: 18px;
            padding-bottom: 10px;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .weather-icon {
            font-size: 60px;
            margin: 10px 0;
        }
        
        .temp {
            font-size: 36px;
            font-weight: bold;
            margin: 10px 0;
        }
        
        .details {
            color: #666;
            line-height: 1.6;
        }
        
        .board {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .board-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        
        .board-title {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }
        
        .write-btn {
            background-color: #03c75a;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
            font-size: 14px;
        }
        
        .search-container {
            margin: 20px 0;
        }
        
        .search-input {
            width: 300px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .search-btn {
            background-color: #03c75a;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            margin-left: 5px;
            cursor: pointer;
            font-weight: bold;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        
        thead th {
            background-color: #f9f9f9;
            padding: 12px;
            border-top: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            color: #333;
            font-size: 14px;
        }
        
        tbody td {
            padding: 14px 12px;
            border-bottom: 1px solid #eee;
            color: #555;
            font-size: 14px;
        }
        
        tbody tr:hover {
            background-color: #f9f9f9;
        }
        
        .pagination {
            margin: 30px 0 10px;
        }
        
        .pagination a {
            display: inline-block;
            padding: 6px 12px;
            margin: 0 2px;
            color: #555;
            text-decoration: none;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        
        .pagination a.active {
            background-color: #03c75a;
            color: white;
            border-color: #03c75a;
        }
        
        .pagination a:hover:not(.active) {
            background-color: #f5f5f5;
        }
        
        .back-btn {
            background-color: white;
            color: #03c75a;
            border: 1px solid #03c75a;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .back-btn:hover {
            background-color: #f5f5f5;
        }
        
        /* 주간 날씨 테이블 스타일 */
        .weekly-forecast {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        
        .weekly-forecast tr {
            border-bottom: 1px solid #f0f0f0;
        }
        
        .weekly-forecast tr:last-child {
            border-bottom: none;
        }
        
        .weekly-forecast td {
            padding: 12px 8px;
            text-align: center;
            font-size: 14px;
        }
        
        .weekly-forecast td:first-child {
            font-weight: bold;
            color: #333;
        }
        
        .weather-emoji {
            font-size: 24px;
            margin: 5px 0;
        }
        
        /* 알림 배너 */
        .alert-banner {
            background-color: #f8f8f8;
            border: 1px solid #eaeaea;
            border-radius: 8px;
            padding: 12px 20px;
            margin: 20px 0;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .alert-banner p {
            color: #666;
            font-size: 14px;
        }
        
        .alert-banner button {
            background: none;
            border: none;
            color: #03c75a;
            font-weight: bold;
            cursor: pointer;
        }
    </style>
</head>
<body>
<header>
    <div class="container">
        <button class="back-btn" onclick="location.href='http://www.team5.click/project1/template'">◀ 돌아가기</button>
        <h1 class="logo">TEAM5 날씨 게시판</h1>
    </div>
</header>

<nav class="nav">
    <div class="container">
        <ul class="nav-links">
            <li><a href="#" class="active"><spring:message code="menu.weather.info" /></a></li>
            <li><a href="#"><spring:message code="menu.forecast" /></a></li>
            <li><a href="#"><spring:message code="menu.dust" /></a></li>
            <li><a href="#"><spring:message code="menu.typhoon" /></a></li>
            <li><a href="#"><spring:message code="menu.community" /></a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <!-- 알림 배너 -->
    <div class="alert-banner">
        <p>📢 <spring:message code="alert.banner" /></p>
        <button><spring:message code="button.detail" /></button>
    </div>

    <div class="weather-container">
        <div class="weather-card">
            <h2><spring:message code="section.current.weather" /></h2>
            <div class="weather-icon">
                ⛅
            </div>
            <div class="temp">${weatherData.temp}°C</div>
            <div class="details">
                <p><spring:message code="label.humidity" />: ${weatherData.moisture}% | <spring:message code="label.wind.speed" />: ${weatherData.windSpeed}m/s</p>
                <p><strong><spring:message code="label.location.seoul" /></strong></p>
                <p>${weatherData.date}</p>
            </div>
        </div>

        <div class="weather-card">
            <h2><spring:message code="section.weekly.forecast" /></h2>
            <table class="weekly-forecast">
                <tr>
                    <td><spring:message code="day.today" /></td>
                    <td><div class="weather-emoji">☀️</div></td>
                    <td>${weeklyForecast[0].highTemp}°C / ${weeklyForecast[0].lowTemp}°C</td>
                </tr>
                <tr>
                    <td><spring:message code="day.tomorrow" /></td>
                    <td><div class="weather-emoji">⛅</div></td>
                    <td>${weeklyForecast[1].highTemp}°C / ${weeklyForecast[1].lowTemp}°C</td>
                </tr>
                <tr>
                    <td><spring:message code="day.thursday" /></td>
                    <td><div class="weather-emoji">🌧️</div></td>
                    <td>${weeklyForecast[2].highTemp}°C / ${weeklyForecast[2].lowTemp}°C</td>
                </tr>
                <tr>
                    <td><spring:message code="day.friday" /></td>
                    <td><div class="weather-emoji">⛅</div></td>
                    <td>${weeklyForecast[3].highTemp}°C / ${weeklyForecast[3].lowTemp}°C</td>
                </tr>
                <tr>
                    <td><spring:message code="day.saturday" /></td>
                    <td><div class="weather-emoji">☀️</div></td>
                    <td>${weeklyForecast[4].highTemp}°C / ${weeklyForecast[4].lowTemp}°C</td>
                </tr>
            </table>
        </div>
    </div>

    <div class="board">
        <div class="board-header">
            <div class="board-title"><spring:message code="board.title" /></div>
            <button class="write-btn"><spring:message code="button.write" /></button>
        </div>
        
        <div class="search-container" style="text-align: center;">
            <form action="search.jsp" method="get">
                <input type="text" name="keyword" class="search-input" placeholder="<spring:message code='placeholder.search' />">
                <button type="submit" class="search-btn"><spring:message code="button.search" /></button>
            </form>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th width="8%"><spring:message code="table.header.no" /></th>
                    <th width="52%"><spring:message code="table.header.title" /></th>
                    <th width="15%"><spring:message code="table.header.writer" /></th>
                    <th width="15%"><spring:message code="table.header.date" /></th>
                    <th width="10%"><spring:message code="table.header.views" /></th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>5</td>
                    <td style="text-align: left;"><a href="#">내일 강남 지역 우산 챙기세요! 오후부터 비 예상</a> <span style="color: #03c75a; font-size: 12px;">[3]</span></td>
                    <td>기상알리미</td>
                    <td>2025.03.18</td>
                    <td>42</td>
                </tr>
                <!-- 반복 생략 -->
            </tbody>
        </table>
        
        <div class="pagination" style="text-align: center;">
            <a href="#">&laquo;</a>
            <a href="#" class="active">1</a>
            <a href="#">2</a>
            <a href="#">3</a>
            <a href="#">4</a>
            <a href="#">5</a>
            <a href="#">&raquo;</a>
        </div>
    </div>
</div>

</body>
</html>
