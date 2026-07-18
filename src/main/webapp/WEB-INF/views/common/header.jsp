<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<header>

    <input type="text"
           placeholder="Search">

<a class="header-user"
   href="${pageContext.request.contextPath}/mypage">

    <span class="user-icon">👤</span>

    <span class="user-name">
        ${dashboard.empName}
    </span>

</a>

</header>