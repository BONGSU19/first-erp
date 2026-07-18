<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="approval-container">

    <div class="approval-header">
        <div>
            <h1>전자결재</h1>
            <p>기안서의 승인 및 반려 상태를 관리합니다.</p>
        </div>

        <a class="approval-button primary"
           href="${pageContext.request.contextPath}/approvals/write">
            기안서 작성
        </a>
    </div>

    <c:if test="${not empty message}">
        <div class="approval-alert success">
            ${message}
        </div>
    </c:if>

    <c:if test="${not empty error}">
        <div class="approval-alert error">
            ${error}
        </div>
    </c:if>

    <div class="approval-tabs">

        <a class="${selectedView == 'received' ? 'active' : ''}"
           href="${pageContext.request.contextPath}/approvals?view=received">
            받은 결재
        </a>

        <a class="${selectedView == 'sent' ? 'active' : ''}"
           href="${pageContext.request.contextPath}/approvals?view=sent">
            보낸 결재
        </a>

    </div>

    <div class="approval-table-wrapper">

        <table class="approval-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>구분</th>
                    <th>제목</th>
                    <th>기안자</th>
                    <th>결재자</th>
                    <th>상태</th>
                    <th>작성일</th>
                </tr>
            </thead>

            <tbody>
                <c:forEach var="approval"
                           items="${approvals}">

                    <tr>
                        <td>${approval.appId}</td>

                        <td>
                            <c:choose>
                                <c:when test="${approval.docType == 'VACATION'}">
                                    휴가
                                </c:when>

                                <c:when test="${approval.docType == 'PURCHASE'}">
                                    구매
                                </c:when>

                                <c:otherwise>
                                    일반
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <a href="${pageContext.request.contextPath}/approvals/${approval.appId}">
                                ${approval.title}
                            </a>
                        </td>

                        <td>${approval.drafter.empName}</td>
                        <td>${approval.approver.empName}</td>

                        <td>
                            <span class="approval-status ${approval.status}">
                                ${approval.status}
                            </span>
                        </td>

                        <td>${approval.createdAt}</td>
                    </tr>
                </c:forEach>

                <c:if test="${empty approvals}">
                    <tr>
                        <td colspan="7"
                            class="empty-approval">
                            결재 문서가 없습니다.
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</div>