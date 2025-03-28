<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>글쓰기 - 날씨 게시판</title>
    <style>
        body {
            font-family: 'Malgun Gothic', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
        }
        header {
            background-color: #4a90e2;
            color: white;
            padding: 20px 0;
            text-align: center;
            margin-bottom: 20px;
        }
        .board-form {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        textarea {
            height: 300px;
            resize: vertical;
        }
        .button-group {
            margin-top: 20px;
            text-align: center;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin: 0 5px;
        }
        .btn-primary {
            background-color: #4a90e2;
            color: white;
        }
        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
    </style>
</head>
<body>
    <header>
        <h1>날씨 게시판</h1>
    </header>
    
    <div class="container">
        <div class="board-form">
            <h2>글쓰기</h2>
            <form action="writeProcess.jsp" method="post">
                <div class="form-group">
                    <label for="title">제목</label>
                    <input type="text" id="title" name="title" required>
                </div>
                <div class="form-group">
                    <label for="writer">작성자</label>
                    <input type="text" id="writer" name="writer" required>
                </div>
                <div class="form-group">
                    <label for="content">내용</label>
                    <textarea id="content" name="content" required></textarea>
                </div>
                <div class="button-group">
                    <button type="submit" class="btn btn-primary">등록</button>
                    <button type="button" class="btn btn-secondary" onclick="location.href='http://www.team5.click/project1/template'">취소</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>