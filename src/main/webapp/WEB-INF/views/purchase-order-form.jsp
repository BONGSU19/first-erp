<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="order-form-container">

    <div class="order-document">

        <div class="order-document-header">
            <h1>자재 발주서</h1>

            <p>
                발주 내용을 확인한 후 발주를 확정해 주세요.
            </p>
        </div>

        <table class="order-detail-table">

            <tr>
                <th>발주 번호</th>
                <td>${purchaseOrder.orderId}</td>
            </tr>

            <tr>
                <th>자재 코드</th>
                <td>
                    ${purchaseOrder.material.matCode}
                </td>
            </tr>

            <tr>
                <th>자재명</th>
                <td>
                    ${purchaseOrder.material.matName}
                </td>
            </tr>

            <tr>
                <th>현재 재고</th>
                <td>
                    ${purchaseOrder.material.currentStock}
                </td>
            </tr>

            <tr>
                <th>안전 재고</th>
                <td>
                    ${purchaseOrder.material.safetyStock}
                </td>
            </tr>

            <tr>
                <th>발주 수량</th>
                <td class="order-quantity">
                    ${purchaseOrder.orderQuantity}
                </td>
            </tr>

            <tr>
                <th>현재 상태</th>
                <td>
                    <c:choose>

                        <c:when test="${purchaseOrder.status == 'CREATED'}">
                            발주 대기
                        </c:when>

                        <c:when test="${purchaseOrder.status == 'APPROVED'}">
                            승인
                        </c:when>

                        <c:when test="${purchaseOrder.status == 'ORDERED'}">
                            발주 완료
                        </c:when>

                        <c:when test="${purchaseOrder.status == 'COMPLETED'}">
                            입고 완료
                        </c:when>

                        <c:otherwise>
                            ${purchaseOrder.status}
                        </c:otherwise>

                    </c:choose>
                </td>
            </tr>

            <tr>
                <th>작성 사원</th>
                <td>
                    ${purchaseOrder.createdBy.empName}
                    (${purchaseOrder.createdBy.empId})
                </td>
            </tr>

            <tr>
                <th>작성 일자</th>
                <td>
                    ${purchaseOrder.createdAt}
                </td>
            </tr>

            <tr>
                <th>발주 사유</th>
                <td>
                    안전 재고 미만으로 자동 생성되었거나
                    담당자가 직접 작성한 발주서입니다.
                </td>
            </tr>

        </table>

        <div class="order-form-buttons">

            <c:if test="${purchaseOrder.status == 'CREATED'
                         or purchaseOrder.status == 'APPROVED'}">

                <form method="post"
                      action="${pageContext.request.contextPath}/purchase-orders/${purchaseOrder.orderId}/order"
                      onsubmit="return confirm('이 발주서를 실제 발주 처리하시겠습니까?');">

                    <button type="submit"
                            class="btn order-confirm-button">
                        발주 확정
                    </button>

                </form>

            </c:if>

            <a class="btn secondary"
               href="${pageContext.request.contextPath}/purchase-orders">
                목록으로
            </a>

        </div>
    </div>
</div>