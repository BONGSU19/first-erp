<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="form"
    uri="http://www.springframework.org/tags/form"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="approval-form-container">

    <div class="approval-form-card">

        <h1>기안서 작성</h1>

        <c:if test="${not empty error}">
            <div class="approval-alert error">
                ${error}
            </div>
        </c:if>

        <form:form
            modelAttribute="approvalCreateDTO"
            method="post"
            action="${pageContext.request.contextPath}/approvals">

            <div class="approval-form-group">
                <label>문서 구분</label>

                <form:select path="docType">
                    <form:option value=""
                                 label="구분을 선택하세요."/>

                    <form:option value="GENERAL"
                                 label="일반"/>

                    <form:option value="VACATION"
                                 label="휴가"/>

                    <form:option value="PURCHASE"
                                 label="구매"/>
                </form:select>

                <form:errors path="docType"
                             cssClass="field-error"/>
            </div>

            <div class="approval-form-group">
                <label>제목</label>

                <form:input path="title"
                            maxlength="200"/>

                <form:errors path="title"
                             cssClass="field-error"/>
            </div>

            <div class="approval-form-group">
                <label>결재자</label>

                <form:select path="approverId">

                    <form:option value=""
                                 label="결재자를 선택하세요."/>

                    <c:forEach var="employee"
                               items="${employees}">

                        <option value="${employee.empId}">
                            ${employee.empName}
                            · ${employee.deptName}
                            · ${employee.positionName}
                        </option>

                    </c:forEach>
                </form:select>

                <form:errors path="approverId"
                             cssClass="field-error"/>
            </div>

            <div class="approval-form-group">
                <label>내용</label>

                <form:textarea path="content"
                               rows="12"/>

                <form:errors path="content"
                             cssClass="field-error"/>
            </div>

            <div class="approval-form-actions">

                <button type="submit"
                        class="approval-button primary"
                        onclick="return confirm('결재 문서를 상신하시겠습니까?');">
                    결재 요청
                </button>

                <a class="approval-button secondary"
                   href="${pageContext.request.contextPath}/approvals">
                    취소
                </a>

            </div>
        </form:form>
    </div>
</div>