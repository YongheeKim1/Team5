<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<nav class="nav">
    <div class="container">
        <ul class="nav-links">
            <li><a href="index.jsp">홈</a></li>
            <li><a href="/project1/community">커뮤니티</a></li>
            <li><a href="weather.jsp">날씨</a></li>
            <li><a href="news.jsp">뉴스</a></li>
        </ul>

        <!-- 로그인 여부 체크 -->
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="logout.jsp" class="login-link">로그아웃</a>
            </c:when>
            <c:otherwise>
                <a href="login.jsp" class="login-link">로그인</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
</body>
</html>