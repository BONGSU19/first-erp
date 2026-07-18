<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>
<td>
    <sec:authorize access="hasRole('ADMIN')">

        <form action="${pageContext.request.contextPath}/employees/${employee.empId}/role"
              method="post"
              class="role-form">

            <select name="role">

                <option value="USER"
                        ${employee.role eq 'USER' ? 'selected' : ''}>
                    일반 사원
                </option>

                <option value="ADMIN"
                        ${employee.role eq 'ADMIN' ? 'selected' : ''}>
                    관리자
                </option>

            </select>

            <c:if test="${not empty _csrf}">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}">
            </c:if>

            <button type="submit"
                    class="role-change-button">
                변경
            </button>

        </form>

    </sec:authorize>

    <sec:authorize access="!hasRole('ADMIN')">

        <c:choose>

            <c:when test="${employee.role eq 'ADMIN'}">
                <span class="role admin">관리자</span>
            </c:when>

            <c:otherwise>
                <span class="role user">일반 사원</span>
            </c:otherwise>

        </c:choose>

    </sec:authorize>
</td>