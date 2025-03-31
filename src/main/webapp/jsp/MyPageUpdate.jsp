<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title><spring:message code="update.title"/></title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/template/css/mypage.css">
  <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="Expires" content="0" />
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #f4f4f4;
      margin: 0;
      padding: 20px;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
    }
    .container {
      background-color: white;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 4px 6px rgba(0,0,0,0.1);
      width: 100%;
      max-width: 500px;
    }
    .container h2 {
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
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 4px;
    }
    .btn-group {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
    }
    .btn-group button {
      padding: 10px 15px;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-weight: bold;
    }
    .btn-update {
      background-color: #4CAF50;
      color: white;
    }
    .btn-delete {
      background-color: #f44336;
      color: white;
    }
    .alert {
      padding: 10px;
      margin-bottom: 15px;
      border-radius: 4px;
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
  <div class="container">
    <h2><spring:message code="update.title"/></h2>
    
    <c:if test="${not empty successMessage}">
      <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
      <div class="alert alert-danger">${errorMessage}</div>
    </c:if>
    
    <form id="userForm" action="${pageContext.request.contextPath}/update" method="post">
      <div class="form-group">
        <label><spring:message code="label.id"/></label>
        <input type="text" name="id" value="${user.id}" readonly>
      </div>
      <div class="form-group">
        <label><spring:message code="label.password.new"/></label>
        <input type="password" name="pw" placeholder="<spring:message code='placeholder.password.new'/>">
      </div>
      <div class="form-group">
        <label><spring:message code="label.password.confirm"/></label>
        <input type="password" name="confirm" placeholder="<spring:message code='placeholder.password.confirm'/>">
      </div>
      <div class="form-group">
        <label><spring:message code="label.name"/></label>
        <input type="text" name="userName" value="${user.userName}" required>
      </div>
      <div class="form-group">
        <label><spring:message code="label.postcode"/></label>
        <input type="text" name="postcode" value="${user.postcode}" required>
      </div>
      <div class="form-group">
        <label><spring:message code="label.address"/></label>
        <input type="text" name="address" value="${user.address}" required>
      </div>
      <div class="form-group">
        <label><spring:message code="label.detailAddress"/></label>
        <input type="text" name="detailAddress" value="${user.detailAddress}" required>
      </div>
      <div class="form-group">
        <label><spring:message code="label.mobile"/></label>
        <input type="tel" name="mobile" value="${user.mobile}" required>
      </div>
      <div class="btn-group">
        <button type="submit" class="btn-update">
          <spring:message code="button.update"/>
        </button>
        <button type="button" onclick="confirmDelete()" class="btn-delete">
          <spring:message code="button.delete"/>
        </button>
      </div>
    </form>
  </div>
  
  <script>
    function confirmDelete() {
      if(confirm('<spring:message code="confirm.delete"/>')) {
        var form = document.getElementById('userForm');
        form.action = '${pageContext.request.contextPath}/delete';
        form.submit();
      }
    }
  </script>
</body>
</html>
