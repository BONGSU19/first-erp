<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>로그인</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/login.css">

<style>
    .error-message {
        margin: 0 0 18px;
        padding: 11px 13px;
        border: 1px solid #fecaca;
        border-radius: 8px;
        color: #dc2626;
        font-size: 13px;
        text-align: center;
        background-color: #fef2f2;
    }
</style>
</head>

<body>

<div class="login-container">

    <h1>로그인</h1>

    <!-- 로그인 실패 시에만 표시 -->
    <c:if test="${not empty error}">
        <div class="error-message" role="alert">
            <c:out value="${error}"/>
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login-proc"
          method="post">

        <!-- CSRF가 활성화된 경우 토큰 전송 -->
        <c:if test="${not empty _csrf}">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}">
        </c:if>

        <div class="input-group">
            <label for="empId">사번</label>

            <input type="text"
                   id="empId"
                   name="empId"
                   autocomplete="username"
                   required>
        </div>

        <div class="input-group">
            <label for="password">비밀번호</label>

            <input type="password"
                   id="password"
                   name="password"
                   autocomplete="current-password"
                   required>
        </div>

        <button type="submit">
            로그인
        </button>

    </form>

</div>

</body>
</html>