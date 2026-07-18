<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form"
    uri="http://www.springframework.org/tags/form"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="material-register-container">

    <div class="register-card">

        <div class="register-title">
            <h1>신규 자재 등록</h1>
            <p>새로운 자재의 기본 정보를 입력해 주세요.</p>
        </div>

        <c:if test="${not empty error}">
            <div class="alert error">
                ${error}
            </div>
        </c:if>

        <form:form
            modelAttribute="materialRegisterDTO"
            method="post"
            action="${pageContext.request.contextPath}/materials/register">

            <div class="form-group">
                <label for="matCode">자재 코드</label>

                <form:input
                    id="matCode"
                    path="matCode"
                    maxlength="20"
                    placeholder="예: MAT-003"/>

                <form:errors
                    path="matCode"
                    cssClass="field-error"/>
            </div>

            <div class="form-group">
                <label for="matName">자재명</label>

                <form:input
                    id="matName"
                    path="matName"
                    maxlength="100"
                    placeholder="자재명을 입력하세요."/>

                <form:errors
                    path="matName"
                    cssClass="field-error"/>
            </div>

            <div class="form-group">
                <label for="currentStock">현재 재고</label>

                <form:input
                    id="currentStock"
                    path="currentStock"
                    type="number"
                    min="0"/>

                <form:errors
                    path="currentStock"
                    cssClass="field-error"/>
            </div>

            <div class="form-group">
                <label for="safetyStock">안전 재고</label>

                <form:input
                    id="safetyStock"
                    path="safetyStock"
                    type="number"
                    min="0"/>

                <form:errors
                    path="safetyStock"
                    cssClass="field-error"/>
            </div>

            <div class="form-actions">
                <button type="submit"
                        class="btn primary">
                    등록
                </button>

                <a class="btn secondary"
                   href="${pageContext.request.contextPath}/materials">
                    취소
                </a>
            </div>
        </form:form>
    </div>
</div>