<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="material-container">

    <!-- 페이지 제목 -->
    <div class="page-title-area">

        <div>
            <h1>발주서 관리</h1>
            <p>
                안전 재고 부족으로 자동 생성되거나
                직접 작성한 발주서를 관리합니다.
            </p>
        </div>

        <div class="title-buttons">

            <a class="btn primary"
               href="${pageContext.request.contextPath}/purchase-orders/register">
                발주서 작성
            </a>

            <a class="btn secondary"
               href="${pageContext.request.contextPath}/materials">
                자재 목록
            </a>

        </div>
    </div>

    <!-- 성공 메시지 -->
    <c:if test="${not empty message}">
        <div class="alert success">
            ${message}
        </div>
    </c:if>

    <!-- 오류 메시지 -->
    <c:if test="${not empty error}">
        <div class="alert error">
            ${error}
        </div>
    </c:if>

    <!-- 발주서 목록 -->
    <div class="section-header">
        <h2>발주서 현황</h2>
    </div>

    <div class="table-wrapper">

        <table class="material-table">

            <thead>
                <tr>
                    <th>발주 번호</th>
                    <th>자재 코드</th>
                    <th>자재명</th>
                    <th>발주 수량</th>
                    <th>상태</th>
                    <th>생성 사원</th>
                    <th>생성 일자</th>
                    <th>완료 일자</th>
                    <th>관리</th>
                </tr>
            </thead>

            <tbody>

                <c:forEach var="order"
                           items="${purchaseOrders}">

                    <tr>

                        <!-- 발주 번호 -->
                        <td>
                            ${order.orderId}
                        </td>

                        <!-- 자재 코드 -->
                        <td>
                            ${order.material.matCode}
                        </td>

                        <!-- 자재명 -->
                        <td>
                            ${order.material.matName}
                        </td>

                        <!-- 발주 수량 -->
                        <td>
                            ${order.orderQuantity}
                        </td>

                        <!-- 발주 상태 -->
                        <td>
                            <c:choose>

                                <c:when test="${order.status == 'CREATED'}">
                                    <span class="order-status created">
                                        발주 대기
                                    </span>
                                </c:when>

                                <c:when test="${order.status == 'APPROVED'}">
                                    <span class="order-status approved">
                                        승인
                                    </span>
                                </c:when>

                                <c:when test="${order.status == 'ORDERED'}">
                                    <span class="order-status ordered">
                                        발주 완료
                                    </span>
                                </c:when>

                                <c:when test="${order.status == 'COMPLETED'}">
                                    <span class="order-status completed">
                                        입고 완료
                                    </span>
                                </c:when>

                                <c:when test="${order.status == 'CANCELLED'}">
                                    <span class="order-status cancelled">
                                        취소
                                    </span>
                                </c:when>

                                <c:otherwise>
                                    <span class="order-status cancelled">
                                        ${order.status}
                                    </span>
                                </c:otherwise>

                            </c:choose>
                        </td>

                        <!-- 생성 사원 -->
                        <td>
                            ${order.createdBy.empName}
                            <br>
                            <span class="sub-information">
                                (${order.createdBy.empId})
                            </span>
                        </td>

                        <!-- 생성 일자 -->
                        <td>
                            ${order.createdAt}
                        </td>

                        <!-- 완료 일자 -->
                        <td>
                            <c:choose>

                                <c:when test="${not empty order.completedAt}">
                                    ${order.completedAt}
                                </c:when>

                                <c:otherwise>
                                    -
                                </c:otherwise>

                            </c:choose>
                        </td>

                        <!-- 관리 버튼 -->
                      <td>
    <c:choose>

        <c:when test="${order.status == 'CREATED'}">

            <a class="btn order-button"
               href="${pageContext.request.contextPath}/purchase-orders/${order.orderId}/order">
                발주하기
            </a>

        </c:when>

        <c:when test="${order.status == 'APPROVED'}">

            <a class="btn order-button"
               href="${pageContext.request.contextPath}/purchase-orders/${order.orderId}/order">
                발주하기
            </a>

        </c:when>

        <c:when test="${order.status == 'ORDERED'}">

            <form method="post"
                  action="${pageContext.request.contextPath}/purchase-orders/${order.orderId}/complete"
                  onsubmit="return confirm('발주한 자재가 실제 도착했습니까? 입고 완료 처리하시겠습니까?');">

                <button type="submit"
                        class="btn complete-button">
                    입고 완료
                </button>

            </form>

        </c:when>

        <c:when test="${order.status == 'COMPLETED'}">

            <span class="completed-text">
                처리 완료
            </span>

        </c:when>

        <c:when test="${order.status == 'CANCELLED'}">

            <span class="cancelled-text">
                취소됨
            </span>

        </c:when>

        <c:otherwise>
            -
        </c:otherwise>

    </c:choose>
</td>

                    </tr>
                </c:forEach>

                <!-- 발주서가 없는 경우 -->
                <c:if test="${empty purchaseOrders}">
                    <tr>
                        <td colspan="9"
                            class="empty-data">
                            생성된 발주서가 없습니다.
                        </td>
                    </tr>
                </c:if>

            </tbody>
        </table>
    </div>
</div>