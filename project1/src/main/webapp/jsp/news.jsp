<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="news.title"/></title>
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
            padding: 20px;
        }
        header {
            background-color: #19ce60;
            padding: 15px 0;
            text-align: center;
            color: white;
            font-size: 24px;
            font-weight: bold;
        }
        .search-box {
            margin-top: 20px;
            text-align: center;
        }
        .search-box input {
            width: 60%;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        .search-box button {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            background-color: #03c75a;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .news-section {
            margin-top: 20px;
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .news-item {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
            cursor: pointer;
        }
        .news-item:hover {
            background-color: #f9f9f9;
        }
        .news-item h4 {
            margin-bottom: 10px;
            color: #03c75a;
        }
        .news-item p {
            color: #666;
        }
        .news-meta {
            font-size: 12px;
            color: #999;
            margin-top: 10px;
        }
        .back-btn {
            position: fixed;
            top: 15px;
            left: 20px;
            padding: 10px 20px;
            background-color: #19ce60;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
            cursor: pointer;
        }
        .back-btn:hover {
            background-color: #17a551;
        }
    </style>
    <script>
        function searchNews() {
            var queryInput = document.getElementById("searchQuery"); 
            var query = queryInput.value.trim();

            if (!query || query.length === 0) {
                alert("<spring:message code='news.input.placeholder'/>");
                return;
            }

            var encodedQuery = encodeURIComponent(query);
            var requestUrl = window.location.origin + "/project1/news/search?query=" + encodedQuery + "&display=5";

            document.getElementById("news-list").innerHTML = "<p>🔄 검색 중...</p>"

            fetch(requestUrl)
                .then(response => {
                    if (!response.ok) {
                        throw new Error(`HTTP 오류: ${response.status}`);
                    }
                    return response.json();
                })
                .then(data => {
                    if (!Array.isArray(data)) {
                        document.getElementById("news-list").innerHTML = "<p>서버 오류 발생</p>";
                        return;
                    }

                    let newsListHtml = "";
                    if (data.length === 0) {
                        newsListHtml = "<p>검색 결과가 없습니다.</p>";
                    } else {
                        data.forEach(news => {
                            newsListHtml += `
                                <div class="news-item">
                                    <h4>` + news.title + `</h4>
                                    <p>` + news.description + `</p>
                                    <div class="news-meta">
                                        <a href="` + news.link + `" target="_blank">원문 보기</a>
                                    </div>
                                </div>`;
                        });
                    }
                    document.getElementById("news-list").innerHTML = newsListHtml;
                })
                .catch(error => {
                    document.getElementById("news-list").innerHTML = "<p>뉴스를 불러오는 중 오류 발생</p>";
                });
        }
    </script>
</head>
<body>
    <header>
        <spring:message code="news.title"/>
    </header>

    <div class="container">
        <div class="search-box">
            <input type="text" id="searchQuery" placeholder="<spring:message code='news.input.placeholder'/>">
            <button onclick="searchNews()"><spring:message code="news.search.button"/></button>
        </div>
        <div class="news-section">
            <h3><spring:message code="news.result.title"/></h3>
            <div class="news-list" id="news-list"></div>
        </div>
    </div>

    <a href="http://www.team5.click/project1/template" class="back-btn">
        <spring:message code="news.back"/>
    </a>
</body>
</html>