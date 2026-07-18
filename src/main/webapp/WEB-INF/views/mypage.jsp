<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="mypage-container">

    <div class="mypage-card">

        <div class="mypage-header">

            <div class="profile-icon">
                👤
            </div>

            <div>
                <h1>${myInfo.empName}</h1>
                <p>사원 개인정보</p>
            </div>

        </div>

        <div class="mypage-information">

            <div class="information-row">
                <span class="information-label">
                    사원번호
                </span>

                <span class="information-value">
                    ${myInfo.empId}
                </span>
            </div>

            <div class="information-row">
                <span class="information-label">
                    이름
                </span>

                <span class="information-value">
                    ${myInfo.empName}
                </span>
            </div>

            <div class="information-row">
                <span class="information-label">
                    부서
                </span>

                <span class="information-value">
                    ${myInfo.deptName}
                </span>
            </div>

            <div class="information-row">
                <span class="information-label">
                    직급
                </span>

                <span class="information-value">
                    <c:choose>
                        <c:when test="${not empty myInfo.positionName}">
                            ${myInfo.positionName}
                        </c:when>

                        <c:otherwise>
                            등록되지 않음
                        </c:otherwise>
                    </c:choose>
                </span>
            </div>

            <div class="information-row">
                <span class="information-label">
                    권한
                </span>

                <span class="information-value">

                    <c:choose>
                        <c:when test="${myInfo.role == 'ROLE_ADMIN'
                                        or myInfo.role == 'ADMIN'}">
                            관리자
                        </c:when>

                        <c:otherwise>
                            일반 사용자
                        </c:otherwise>
                    </c:choose>

                </span>
            </div>

        </div>

        <div class="mypage-notice">
            개인정보 변경이 필요한 경우 관리자에게 문의해 주세요.
        </div>

        <div class="mypage-buttons">

            <a class="mypage-button primary"
               href="${pageContext.request.contextPath}/change-password">
                비밀번호 변경
            </a>

            <a class="mypage-button secondary"
               href="${pageContext.request.contextPath}/main">
                메인으로
            </a>

        </div>
    </div>
</div>