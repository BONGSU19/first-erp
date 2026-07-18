<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar">

    <h2>ERP Dashboard</h2>

    <ul>
        <li>
            <a href="${pageContext.request.contextPath}/main">
                ▦ 대시보드
            </a>
        </li>

        <li>
            <a href="${pageContext.request.contextPath}/employees">
                ♙ 인사관리
            </a>
        </li>

   <li>
    <a href="${pageContext.request.contextPath}/materials">
        ▣ 자재관리
    </a>
</li>

  <li>
    <a href="${pageContext.request.contextPath}/approvals">
        ✓ 전자결재
    </a>
</li>
      <li>
    <a href="${pageContext.request.contextPath}/attendance">
        ◷ 근태관리
    </a>
</li>
    </ul>

    <div class="logout">

        <span>${dashboard.empName}님</span>

        <form action="${pageContext.request.contextPath}/logout"
              method="post">

            <c:if test="${not empty _csrf}">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">
            </c:if>

            <button type="submit">
                로그아웃
            </button>

        </form>

    </div>

</div>