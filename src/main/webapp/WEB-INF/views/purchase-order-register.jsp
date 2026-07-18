<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form"
    uri="http://www.springframework.org/tags/form"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="order-register-container">

    <div class="order-register-card">

        <div class="register-title">
            <h1>발주서 작성</h1>
            <p>
                발주할 자재와 수량을 입력해 주세요.
            </p>
        </div>

        <!-- 전체 오류 메시지 -->
        <c:if test="${not empty error}">
            <div class="alert error">
                ${error}
            </div>
        </c:if>

        <form:form
            modelAttribute="purchaseOrderRegisterDTO"
            method="post"
            action="${pageContext.request.contextPath}/purchase-orders/register">

            <!-- 자재 선택 -->
            <div class="form-group">
                <label for="matCode">
                    발주 자재
                </label>

                <form:select
                    id="matCode"
                    path="matCode">

                    <form:option
                        value=""
                        label="자재를 선택해 주세요."/>

                    <c:forEach var="material"
                               items="${materials}">

                        <form:option
                            value="${material.matCode}"
                            label="${material.matCode} - ${material.matName}"/>

                    </c:forEach>
                </form:select>

                <form:errors
                    path="matCode"
                    cssClass="field-error"/>
            </div>

            <!-- 선택 자재 정보 -->
            <div class="material-guide">
                <p>
                    자재의 현재 재고와 안전 재고는
                    자재관리 화면에서 확인할 수 있습니다.
                </p>
            </div>

            <!-- 발주 수량 -->
            <div class="form-group">
                <label for="orderQuantity">
                    발주 수량
                </label>

                <form:input
                    id="orderQuantity"
                    path="orderQuantity"
                    type="number"
                    min="1"
                    placeholder="발주 수량을 입력하세요."/>

                <form:errors
                    path="orderQuantity"
                    cssClass="field-error"/>
            </div>

            <!-- 작성자 -->
            <div class="form-group">
                <label>작성자</label>

                <input type="text"
                       value="${dashboard.empName} (${dashboard.empId})"
                       readonly>
            </div>

            <!-- 상태 -->
            <div class="form-group">
                <label>초기 상태</label>

                <input type="text"
                       value="발주 대기"
                       readonly>
            </div>

            <div class="form-actions">

                <button type="submit"
                        class="btn primary"
                        onclick="return confirm('발주서를 작성하시겠습니까?');">
                    발주서 저장
                </button>

                <a class="btn secondary"
                   href="${pageContext.request.contextPath}/purchase-orders">
                    취소
                </a>
            </div>
        </form:form>
    </div>
</div>