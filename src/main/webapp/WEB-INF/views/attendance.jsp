<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="attendance-container">

    <!-- 페이지 제목 -->
    <div class="attendance-page-header">

        <div>
            <h1>근태 관리</h1>
            <p>
                출근 및 퇴근 시간을 기록하고
                최근 근태 내역을 확인합니다.
            </p>
        </div>

        <a class="attendance-link-button"
           href="${pageContext.request.contextPath}/main">
            대시보드
        </a>

    </div>

    <!-- 성공 메시지 -->
    <c:if test="${not empty message}">
        <div class="attendance-alert success">
            ${message}
        </div>
    </c:if>

    <!-- 오류 메시지 -->
    <c:if test="${not empty error}">
        <div class="attendance-alert error">
            ${error}
        </div>
    </c:if>

    <!-- 오늘 근태 현황 -->
    <div class="attendance-summary">

        <!-- 로그인 사원 -->
        <div class="attendance-profile-card">

            <div class="attendance-profile-icon">
                👤
            </div>

            <div class="attendance-profile-information">

                <h2>${dashboard.empName}</h2>

                <p>
                    ${dashboard.deptName}

                    <c:if test="${not empty dashboard.positionName}">
                        · ${dashboard.positionName}
                    </c:if>
                </p>

                <span>
                    사원번호 ${dashboard.empId}
                </span>

            </div>
        </div>

        <!-- 오늘 상태 -->
        <div class="attendance-status-card">

            <p class="status-label">
                오늘 근무 상태
            </p>

            <c:choose>

                <c:when test="${empty todayAttendance}">
                    <span class="work-status before">
                        출근 전
                    </span>
                </c:when>

                <c:when test="${not empty todayAttendance.clockIn
                                and empty todayAttendance.clockOut}">
                    <span class="work-status working">
                        근무 중
                    </span>
                </c:when>

                <c:otherwise>
                    <span class="work-status completed">
                        퇴근 완료
                    </span>
                </c:otherwise>

            </c:choose>

        </div>

        <!-- 접속 IP -->
        <div class="attendance-ip-card">

            <p>현재 접속 IP</p>

            <strong>${clientIp}</strong>

            <span>
                사내 네트워크 여부를 확인합니다.
            </span>

        </div>
    </div>

    <!-- 오늘 출퇴근 -->
    <div class="attendance-box">

        <div class="attendance-box-header">
            <h2>오늘 출퇴근</h2>

            <span>
                <c:choose>
                    <c:when test="${not empty todayAttendance}">
                        ${todayAttendance.workDate}
                    </c:when>

                    <c:otherwise>
                        오늘
                    </c:otherwise>
                </c:choose>
            </span>
        </div>

        <div class="today-time-grid">

            <!-- 출근 시간 -->
            <div class="time-card">

                <div class="time-icon">
                    🌅
                </div>

                <p>출근 시간</p>

                <c:choose>
                    <c:when test="${not empty todayAttendance.clockIn}">
                        <strong>
                            ${todayAttendance.clockIn}
                        </strong>
                    </c:when>

                    <c:otherwise>
                        <strong>-</strong>
                    </c:otherwise>
                </c:choose>

            </div>

            <!-- 퇴근 시간 -->
            <div class="time-card">

                <div class="time-icon">
                    🌙
                </div>

                <p>퇴근 시간</p>

                <c:choose>
                    <c:when test="${not empty todayAttendance.clockOut}">
                        <strong>
                            ${todayAttendance.clockOut}
                        </strong>
                    </c:when>

                    <c:otherwise>
                        <strong>-</strong>
                    </c:otherwise>
                </c:choose>

            </div>

        </div>

        <!-- 출퇴근 버튼 -->
        <div class="attendance-actions">

            <c:choose>

                <c:when test="${empty todayAttendance}">

                    <form method="post"
                          action="${pageContext.request.contextPath}/attendance/clock-in"
                          onsubmit="return confirm('출근 처리하시겠습니까?');">

                        <c:if test="${not empty _csrf}">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}">
                        </c:if>

                        <button type="submit"
                                class="attendance-button clock-in">
                            출근하기
                        </button>

                    </form>

                </c:when>

                <c:when test="${empty todayAttendance.clockOut}">

                    <form method="post"
                          action="${pageContext.request.contextPath}/attendance/clock-out"
                          onsubmit="return confirm('퇴근 처리하시겠습니까?');">

                        <c:if test="${not empty _csrf}">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}">
                        </c:if>

                        <button type="submit"
                                class="attendance-button clock-out">
                            퇴근하기
                        </button>

                    </form>

                </c:when>

                <c:otherwise>

                    <button type="button"
                            class="attendance-button finished"
                            disabled>
                        오늘 근무 완료
                    </button>

                </c:otherwise>

            </c:choose>

        </div>
    </div>

    <!-- 최근 근태 기록 -->
    <div class="attendance-box history-box">

        <div class="attendance-box-header">
            <h2>최근 근태 기록</h2>

            <span>
                최근 10건
            </span>
        </div>

        <div class="attendance-table-wrapper">

            <table class="attendance-table">

                <thead>
                    <tr>
                        <th>근무일</th>
                        <th>사원명</th>
                        <th>출근 시간</th>
                        <th>퇴근 시간</th>
                        <th>근무 상태</th>
                        <th>접속 IP</th>
                    </tr>
                </thead>

                <tbody>

                    <c:forEach var="attendance"
                               items="${attendanceList}">

                        <tr>
                            <td>
                                ${attendance.workDate}
                            </td>

                            <td>
                                ${attendance.employee.empName}
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${not empty attendance.clockIn}">
                                        ${attendance.clockIn}
                                    </c:when>

                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${not empty attendance.clockOut}">
                                        ${attendance.clockOut}
                                    </c:when>

                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${empty attendance.clockIn}">
                                        <span class="record-status before">
                                            출근 전
                                        </span>
                                    </c:when>

                                    <c:when test="${empty attendance.clockOut}">
                                        <span class="record-status working">
                                            근무 중
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="record-status completed">
                                            퇴근 완료
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                ${attendance.ipAddress}
                            </td>
                        </tr>

                    </c:forEach>

                    <c:if test="${empty attendanceList}">
                        <tr>
                            <td colspan="6"
                                class="empty-attendance">
                                근태 기록이 없습니다.
                            </td>
                        </tr>
                    </c:if>

                </tbody>
            </table>
        </div>
    </div>
</div>