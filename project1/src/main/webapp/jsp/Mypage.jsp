<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><spring:message code="mypage.title" /></title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/template/css/Mypage.css">
  <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Expires" content="0" />
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
    .mypage-container {
      width: 100%;
      max-width: 1200px;
      margin: 0 auto;
      padding: 20px;
    }
    .mypage-container h1 {
      margin-bottom: 20px;
      text-align: center;
    }
    .form-group {
      margin-bottom: 15px;
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
    .button-group {
      margin-top: 20px;
      display: flex;
      justify-content: space-between;
    }
    .button-group button {
      padding: 10px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-weight: bold;
    }
    .btn-update {
      background-color: #19ce60;
      color: white;
    }
    .btn-delete {
      background-color: #f44336;
      color: white;
    }
    .btn-back {
      background-color: #555;
      color: white;
    }
    .alert {
      padding: 10px;
      margin-bottom: 15px;
      border-radius: 5px;
    }
    .alert-success {
      background-color: #dff0d8;
      color: #3c763d;
    }
    .alert-danger {
      background-color: #f2dede;
      color: #a94442;
    }
  </style>
</head>
<body>
  <div class="mypage-container">
    <h1><spring:message code="mypage.title" /></h1>

    <c:if test="${not empty successMessage}">
      <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
      <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/update" method="post">
      <div class="form-group">
        <label><spring:message code="label.id" /></label>
        <input type="text" name="id" value="${user.id}" readonly>
      </div>
      <div class="form-group">
        <label><spring:message code="label.name" /></label>
        <input type="text" name="userName" value="${user.userName}" required>
      </div>
      <div class="form-group">
        <label><spring:message code="label.postcode" /></label>
        <input type="text" name="postcode" value="${user.postcode}" required>
      </div>
      <div class="form-group">
        <label><spring:message code="label.address" /></label>
        <input type="text" name="address" value="${user.address}" required>
      </div>
      <div class="form-group">
        <label><spring:message code="label.detailAddress" /></label>
        <input type="text" name="detailAddress" value="${user.detailAddress}" required>
      </div>
      <div class="form-group">
        <label><spring:message code="label.mobile" /></label>
        <input type="tel" name="mobile" value="${user.mobile}" required>
      </div>

      <div class="button-group">
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/MyPageUpdate'" class="btn-update">
          <spring:message code="button.update" />
        </button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/MyPageUpdate'" class="btn-delete">
          <spring:message code="button.delete" />
        </button>
        <button type="button" onclick="location.href='${pageContext.request.contextPath}/template'" class="btn-back">
          <spring:message code="button.back" />
        </button>
      </div>
    </form>
  </div>

  <script>
    function confirmDelete() {
      if(confirm('<spring:message code="confirm.delete" />')) {
        window.location.href = '${pageContext.request.contextPath}/delete';
      }
    }
  </script>
</body>
</html>
