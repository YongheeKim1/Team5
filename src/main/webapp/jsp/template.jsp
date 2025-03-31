<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>team5</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Malgun Gothic', sans-serif;
        }
        
        body {
            background-color: #f5f6f7;
        }
        
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        header {
            background-color: #19ce60;
            padding: 15px 0;
        }
        
        .logo {
            color: white;
            font-size: 24px;
            font-weight: bold;
            text-align: center;
        }
        
        .nav {
            background-color: white;
            padding: 10px 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .nav .container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .nav-links {
            display: flex;
            list-style: none;
            margin: 0 auto;
        }
        
        .nav-links li {
            margin: 0 20px;
        }
        
        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
        }
        
        .login-link {
            text-decoration: none;
            color: #19ce60;
            font-weight: bold;
        }
        
        main {
            display: flex;
            padding: 20px;
        }
        
        .content {
            flex: 3;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .sidebar {
            flex: 1;
            display: flex;
            flex-direction: column;
            margin-left: 20px; /* Add margin to separate from content */
        }
        
        .login-form, .weather-widget {
            width: 100%;
            max-width: 300px;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: center;
            margin-bottom: 20px; /* Space between login and weather */
        }
        
        .login-form h3, .weather-widget h3 {
            font-size: 18px;
            margin-bottom: 15px;
        }
        
        .form-group {
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .form-group button {
            width: 100%;
            padding: 10px;
            background-color: #19ce60;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        
        .signup-link {
            font-size: 12px; 
            color: black; 
            text-decoration: none; 
            margin-top: 10px;
        }
        
        .signup-link:hover, 
        .signup-link:active, 
        .signup-link:visited {
            color: black; 
            text-decoration: none; 
        }
        
        /* Rest of the existing styles remain the same */
        
        /* Additional styles for specific sections */
        .news-section, .news-item, .news-content {
            /* Existing news-related styles */
        }
        
        footer {
            background-color: #333;
            color: white;
            padding: 15px 0;
            text-align: center;
            margin-top: 20px;
        }
        
        .hidden {
            display: none;
        }
    </style>
</head>
<body>


<header>
    <div class="container">
        <div class="logo">TEAM5</div>
    </div>
</header>

<nav class="nav">
    <div class="container">
        <div class="empty-space"></div>
        <ul class="nav-links">
            <li><a href="template" onclick="showSection('home')"><spring:message code="nav.home"/></a></li>
            <li><a href="community" onclick="showSection('community')"><spring:message code="nav.community"/></a></li>
            <li><a href="weather" onclick="showSection('weather')"><spring:message code="nav.weather"/></a></li>
            <li><a href="news" onclick="showSection('news')"><spring:message code="nav.news"/></a></li>
        </ul>
        <a href="login" class="login-link" onclick="return login()"><spring:message code="login"/></a>
        <button onclick="location.href='http://www.team5.click/project1/Mypage'"><spring:message code="nav.mypage"/></button>
    </div>
</nav>

<div class="container">
    <main>
        <div class="content">
            <div id="home-section">
                <h2><spring:message code="home.title"/></h2>
                <p><spring:message code="welcome.message"/></p>
                <div class="news-section">
                    <h3><spring:message code="latest.news"/></h3>
                    <div class="news-item">
                        <a href="/project1/news" style="text-decoration: none; color: inherit;">
                            <div class="news-block" style="cursor: pointer;">
                                <h4><spring:message code="breaking.economy"/></h4>
                                <p><spring:message code="economy.description"/></p>
                                <div class="news-meta"><spring:message code="source.economy"/> · 2025-03-18</div>
                            </div>
                        </a>
                        <div class="news-item">
                            <h4><spring:message code="it.news"/></h4>
                            <p><spring:message code="ai.description"/></p>
                            <div class="news-meta"><spring:message code="source.it"/> · 2025-03-18</div>
                        </div>
                    </div>
                    <div class="news-content hidden" id="news-detail">
                        <a href="/project/news" class="back-to-news" onclick="showNewsList()">
                            <spring:message code="nav.news"/> · 목록으로 돌아가기
                        </a>
                        <div class="news-detail-header">
                            <h3 id="news-detail-title"></h3>
                            <p id="news-detail-source"></p>
                        </div>
                        <div id="news-detail-content"></div>
                    </div>
                </div>
            </div>
        </div>

        <div class="sidebar">
            <!-- 🔓 로그인하지 않은 사용자 -->
  <div class="login-form">
  <c:choose>
  
    <!-- 🔓 로그인 안 된 경우 -->
    <c:when test="${empty sessionScope.id}">
      <h3><spring:message code="login.title"/></h3>
      <div class="form-group">
        <a href="http://www.team5.click/project1/login" class="login-link"><spring:message code="login"/></a>
      </div>
      <a href="http://www.team5.click/project1/regist" class="signup-link"><spring:message code="signup"/></a>
    </c:when>

    <!-- 🔐 로그인 된 경우 -->
    <c:otherwise>
      <h3>안녕하세요, <strong>${sessionScope.id}</strong>님!</h3>
      <div class="form-group">
        <button onclick="location.href='http://www.team5.click/project1/member/logout'"><spring:message code="logout"/></button>
      </div>
    </c:otherwise>

  </c:choose>
</div>
            <div class="weather-widget">
                <h3><spring:message code="weather.today"/></h3>
                <p>${weatherData.date}</p>
                <div id="weather-info">
                    <p><strong><spring:message code="location.seoul"/></strong></p>
                    <div class="weather-icon">
                        ⛅ ${weatherData.temp}°C
                    </div>
                    <p><spring:message code="humidity"/>: ${weatherData.moisture}% | 
                       <spring:message code="wind"/>: ${weatherData.windSpeed}m/s</p>
                </div>
            </div>
        </div>
    </main>
</div>

<footer>
    <div class="container">
        <p>&copy; TEAM5 웹사이트. All rights reserved.</p>
    </div>
</footer>

</body>
</html>

    <script>
        // Existing JavaScript remains the same as in the original document
        function showSection(sectionId) {
            console.log("Show section: " + sectionId);
        }
        
        function showLoginForm() {
            console.log("Show login form");
        }
        
        function showSignupForm() {
            console.log("regist");
        }
        
        function login() {
            const username = document.getElementById("id").value;
            const password = document.getElementById("pw").value;
            
            alert("로그인 창입니다. 여기에 진짜 로그인 폼 띄우셔도 됩니다.");

            if (username === "admin" && password === "1234") {
                alert("로그인 성공!");
                window.open("http://www.team5.click/project1/login", "LoginWindow", "width=500,height=600");
            } else {
                alert("로그인 실패! 아이디 또는 비밀번호를 확인해주세요.");
            }

            return false;
        }

        function logout() {
            localStorage.removeItem("loggedIn");
            localStorage.removeItem("userName");

            document.getElementById("login-form").style.display = "block";
            document.getElementById("user-info").style.display = "none";

            alert("로그아웃 되었습니다.");
        }

        window.onload = function() {
            fetch("member/session")
            .then(response => response.json())
            .then(data => {
                if (data.loggedIn) {
                    document.getElementById("login-form").style.display = "none";
                    document.getElementById("user-info").style.display = "block";
                    document.getElementById("user-name").textContent = data.userName;
                }
            });

            displayCurrentDate();
        };

       
    </script>
</body>
</html>