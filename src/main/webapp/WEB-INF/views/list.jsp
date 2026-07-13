<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>사원 관리</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/employee-list.css">
</head>

<body>

<div class="layout">

    <!-- 사이드바 -->
    <aside class="sidebar">

        <h1 class="sidebar-title">ERP Dashboard</h1>

        <nav>
            <ul class="sidebar-menu">

                <li>
                    <a href="${pageContext.request.contextPath}/main">
                        ▦ 대시보드
                    </a>
                </li>

                <li class="active">
                    <a href="${pageContext.request.contextPath}/employees">
                        ♙ 인사 관리
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/attendance">
                        ◷ 근태 관리
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/materials">
                        ▣ 자재 관리
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/approvals">
                        ✓ 전자결재
                    </a>
                </li>

            </ul>
        </nav>

        <div class="sidebar-user">

            <p>
                <strong>${dashboard.empName}</strong>님
            </p>

            <form action="${pageContext.request.contextPath}/logout"
                  method="post">

                <c:if test="${not empty _csrf}">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}">
                </c:if>

                <button type="submit" class="logout-button">
                    로그아웃
                </button>
            </form>

        </div>

    </aside>

    <!-- 메인 영역 -->
    <main class="main-content">

        <header class="top-header">

            <div>
                <h2>인사 관리</h2>
                <p>사원 정보를 조회하고 관리합니다.</p>
            </div>

            <div class="header-user">
                👤 ${dashboard.empName}님
            </div>

        </header>

        <!-- 검색 및 등록 영역 -->
        <section class="toolbar">

            <form class="search-form"
                  method="get"
                  action="${pageContext.request.contextPath}/employees">

                <label for="deptname">부서</label>

                <select id="deptname" name="deptname">

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

                <button type="submit" class="search-button">
                    조회
                </button>

                <a href="${pageContext.request.contextPath}/employees"
                   class="reset-button">
                    초기화
                </a>

            </form>

            <!-- 관리자에게만 사원 등록 버튼 표시 -->
            <sec:authorize access="hasRole('ADMIN')">
                <a href="${pageContext.request.contextPath}/employees/new"
                   class="register-button">
                    신규 사원 등록
                </a>
            </sec:authorize>

        </section>

        <!-- 처리 결과 메시지 -->
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

                    <!-- 조회 결과가 없는 경우 -->
                    <c:if test="${empty employees}">
                        <tr>
                            <td colspan="6" class="empty-message">
                                조회된 사원이 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <!-- 사원 목록 반복 출력 -->
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
                                        <span class="role admin">관리자</span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="role user">일반 사원</span>
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

                    </tbody>
                </table>

            </div>
        </section>

    </main>

</div>

</body>
</html>