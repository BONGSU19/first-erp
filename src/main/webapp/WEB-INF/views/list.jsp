<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>

<!-- 검색 및 등록 -->
<section class="toolbar">

    <form class="search-form"
          method="get"
          action="${pageContext.request.contextPath}/employees">

        <label for="deptname">부서</label>

        <select id="deptName" name="deptName">

            <option value=""
                    ${empty selectedDept ? 'selected' : ''}>
                전체 부서
            </option>

            <option value="인사팀"
                    ${selectedDept eq '인사팀' ? 'selected' : ''}>
                인사팀
            </option>

            <option value="개발팀"
                    ${selectedDept eq '개발팀' ? 'selected' : ''}>
                개발팀
            </option>

            <option value="자재팀"
                    ${selectedDept eq '자재팀' ? 'selected' : ''}>
                자재팀
            </option>

        </select>
			    <label for="empId">이름</label>

    <input type="text"
           id="empId"
      
           name="empName"
           value="<c:out value='${selectedEmpId}'/>"
           placeholder="예: 서민수">
        <button type="submit" class="search-button">
            조회
        </button>

        <a href="${pageContext.request.contextPath}/employees"
           class="reset-button">
            초기화
        </a>

    </form>

    <sec:authorize access="hasRole('ADMIN')">
        <a href="${pageContext.request.contextPath}/employeesRegister"
           class="register-button">
            신규 사원 등록
        </a>
    </sec:authorize>

</section>

<!-- 처리 결과 -->
<c:if test="${not empty message}">
    <div class="alert success">
        <c:out value="${message}"/>
    </div>
</c:if>

<c:if test="${not empty error}">
    <div class="alert error">
        <c:out value="${error}"/>
    </div>
</c:if>

<!-- 사원 목록 -->
<section class="employee-section">

    <div class="section-header">
        <h3>사원 목록</h3>
        <span>총 ${employees.size()}명</span>
    </div>

    <div class="table-wrapper">

        <table class="employee-table">

            <thead>
            <tr>
                <th>번호</th>
                <th>사번</th>
                <th>이름</th>
                <th>부서</th>
                <th>권한</th>
                <th>관리</th>
            </tr>
            </thead>

            <tbody>

            <c:choose>

                <c:when test="${empty employees}">
                    <tr>
                        <td colspan="6" class="empty-message">
                            조회된 사원이 없습니다.
                        </td>
                    </tr>
                </c:when>

                <c:otherwise>

                    <c:forEach var="employee"
                               items="${employees}"
                               varStatus="status">

                        <tr>
                            <td>${status.count}</td>

                            <td>
                                <c:out value="${employee.empId}"/>
                            </td>

                            <td>
                                <c:out value="${employee.empName}"/>
                            </td>

                            <td>
                                <c:out value="${employee.deptName}"/>
                            </td>

                            <td>
                                <c:choose>

                                    <c:when test="${employee.role eq 'ROLE_ADMIN'
                                                   or employee.role eq 'ADMIN'}">
                                        <span class="role admin">
                                            관리자
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="role user">
                                            일반 사원
                                        </span>
                                    </c:otherwise>

                                </c:choose>
                            </td>

                            <td>
                                <sec:authorize access="hasRole('ADMIN')">
                                    <a href="${pageContext.request.contextPath}/employees/${employee.empId}/edit"
                                       class="edit-button">
                                        수정
                                    </a>
                                </sec:authorize>

                                <sec:authorize access="!hasRole('ADMIN')">
                                    <span class="no-permission">-</span>
                                </sec:authorize>
                            </td>
                        </tr>

                    </c:forEach>

                </c:otherwise>

            </c:choose>

            </tbody>

        </table>

    </div>

</section>