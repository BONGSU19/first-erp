<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<section class="dashboard-content">

    <h2>${dashboard.empName}님, 반가워요!</h2>

    <!-- 요약 카드 -->
    <div class="cards">

        <div class="card">
            <p>오늘 출근</p>
            <h2>${dashboard.attendanceStatus}</h2>
        </div>

        <div class="card">
            <p>결재 대기</p>
            <h2>${dashboard.pendingApprovalCount}건</h2>
        </div>

        <div class="card warning">
            <p>재고 부족</p>
            <h2>${dashboard.lowStockCount}건</h2>
        </div>

        <div class="card">
            <p>새 알림</p>
            <h2>${dashboard.unreadNotificationCount}건</h2>
        </div>

    </div>

    <div class="content">

        <!-- 최근 결재 목록 -->
        <div class="box">

            <h3>최근 결재 목록</h3>

            <table>
                <thead>
                <tr>
                    <th>제목</th>
                    <th>작성자</th>
                    <th>구분</th>
                    <th>상태</th>
                    <th>작성일</th>
                </tr>
                </thead>

                <tbody>

                <c:choose>

                    <c:when test="${empty dashboard.recentApprovals}">
                        <tr>
                            <td colspan="5">
                                최근 결재 내역이 없습니다.
                            </td>
                        </tr>
                    </c:when>

                    <c:otherwise>

                        <c:forEach var="approval"
                                   items="${dashboard.recentApprovals}">

                            <tr>
                                <td>${approval.title}</td>
                                <td>${approval.writerName}</td>
                                <td>${approval.type}</td>
                                <td>
                                    <span class="status ${approval.status}">
                                        ${approval.statusName}
                                    </span>
                                </td>
                                <td>${approval.createdAt}</td>
                            </tr>

                        </c:forEach>

                    </c:otherwise>

                </c:choose>

                </tbody>
            </table>

        </div>

        <!-- 근무 통계 -->
        <div class="box chart">

            <h3>부서별 누적 근무시간</h3>

            <div class="graph">
                <!-- 나중에 Chart.js 그래프 삽입 -->
            </div>

        </div>

    </div>

    <!-- 사원 정보 -->
    <div class="box employee">

        <h3>로그인 사원 정보</h3>

        <table>
            <thead>
            <tr>
                <th>사원명</th>
                <th>부서</th>
                <th>출근 상태</th>
            </tr>
            </thead>

            <tbody>
            <tr>
                <td>⚪ ${dashboard.empName}</td>
                <td>${dashboard.deptName}</td>
                <td>${dashboard.attendanceStatus}</td>
            </tr>
            </tbody>
        </table>

    </div>

</section>