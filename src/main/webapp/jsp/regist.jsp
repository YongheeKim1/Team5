<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><spring:message code="signup.title"/></title>
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
        .form-input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
    </style>
</head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = '';
                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>
<body>
<div align="center">
	<h1><spring:message code="signup.title"/></h1>
	<table>
	<tr><td>
		<font color="red">${msg}</font>
	</td></tr>
	<tr><td>
	<form action="/project1/member/regist" method="post" id="f">
    <input type="text" name="id" placeholder="<spring:message code='signup.id'/>" id="id" class="form-input"> (*<spring:message code='required'/>) <br>

    <input type="password" name="pw" placeholder="<spring:message code='signup.password'/>" id="pw" class="form-input"><br>
    <input type="password" name="confirm" placeholder="<spring:message code='signup.confirm'/>" id="confirm" class="form-input" onchange="pwCheck()">
    <label id="label"></label><br>

    <input type="text" name="userName" id="userName" placeholder="<spring:message code='signup.name'/>" class="form-input"><br>

    <input type="text" name="postcode" id="sample6_postcode" placeholder="<spring:message code='signup.zipcode'/>" class="form-input">
    <input type="button" onclick="sample6_execDaumPostcode()" value="<spring:message code='signup.findzipcode'/>"><br>

    <input type="text" name="address" id="sample6_address" placeholder="<spring:message code='signup.address'/>" class="form-input"><br>
    <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="<spring:message code='signup.address.detail'/>" class="form-input"><br>

    <input type="text" name="mobile" id="mobile" placeholder="<spring:message code='signup.mobile'/>" class="form-input"><br>

    <input type="button" value="<spring:message code='signup.submit'/>" onclick="allCheck()">
    <input type="button" value="<spring:message code='signup.cancel'/>" onclick="location.href='http://www.team5.click/project1/template'"><br>
</form>

	</td></tr></table>
</div>

<script>
    const messages = {
        idRequired: "<spring:message code='alert.id.required'/>",
        pwRequired: "<spring:message code='alert.pw.required'/>",
        pwMismatch: "<spring:message code='alert.pw.mismatch'/>",
        nameRequired: "<spring:message code='alert.name.required'/>",
        zipcodeRequired: "<spring:message code='alert.zipcode.required'/>",
        mobileRequired: "<spring:message code='alert.mobile.required'/>"
    };

    function allCheck() {
        var id = document.getElementById("id").value;
        var pw = document.getElementById("pw").value;
        var confirm = document.getElementById("confirm").value;
        var userName = document.getElementById("userName").value;
        var postcode = document.getElementById("sample6_postcode").value;
        var address = document.getElementById("sample6_address").value;
        var detailAddress = document.getElementById("sample6_detailAddress").value;
        var mobile = document.getElementById("mobile").value;

        if (!id) {
            alert(messages.idRequired);
            document.getElementById("id").focus();
            return;
        }
        if (!pw) {
            alert(messages.pwRequired);
            document.getElementById("pw").focus();
            return;
        }
        if (pw !== confirm) {
            alert(messages.pwMismatch);
            document.getElementById("confirm").focus();
            return;
        }
        if (!userName) {
            alert(messages.nameRequired);
            document.getElementById("userName").focus();
            return;
        }
        if (!postcode || !address) {
            alert(messages.zipcodeRequired);
            return;
        }
        if (!mobile) {
            alert(messages.mobileRequired);
            document.getElementById("mobile").focus();
            return;
        }
        document.getElementById("f").submit();
    }
</script>
</body>
</html>
