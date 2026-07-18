<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@ taglib prefix="c"
           uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="form"
           uri="http://www.springframework.org/tags/form" %>

<section class="register-section">

    <div class="section-header">
        <div>
            <h2>신규 사원 등록</h2>
            <p>신규 사원의 기본 정보를 입력해주세요.</p>
        </div>

        <a href="${pageContext.request.contextPath}/employees"
           class="list-button">
            목록으로
        </a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert error">
            <c:out value="${error}"/>
        </div>
    </c:if>

    <form:form
        modelAttribute="employeeRegisterDTO"
        action="${pageContext.request.contextPath}/employeesRegister"
        method="post"
        cssClass="employee-form">

    <form:errors
            path="*"
            element="div"
            cssClass="alert error"/>

        <div class="form-row">
            <form:label path="empId">사번</form:label>

            <form:input
                path="empId"
                placeholder="예: EMP001"/>

            <form:errors
                path="empId"
                cssClass="field-error"/>
        </div>

        <div class="form-row">
            <form:label path="empName">이름</form:label>

            <form:input
                path="empName"
                placeholder="사원 이름"/>

            <form:errors
                path="empName"
                cssClass="field-error"/>
        </div>

        <div class="form-row">
            <form:label path="deptName">부서</form:label>

            <form:select path="deptName">
                <form:option value="">부서 선택</form:option>
                <form:option value="인사팀">인사팀</form:option>
                <form:option value="개발팀">개발팀</form:option>
                <form:option value="자재팀">자재팀</form:option>
            </form:select>

            <form:errors
                path="deptName"
                cssClass="field-error"/>
        </div>

        <div class="form-row">
            <form:label path="positionName">직급</form:label>

            <form:select path="positionName">
                <form:option value="">직급 선택</form:option>
                <form:option value="사원">사원</form:option>
                <form:option value="대리">대리</form:option>
                <form:option value="과장">과장</form:option>
                <form:option value="부장">부장</form:option>
            </form:select>

            <form:errors
                path="positionName"
                cssClass="field-error"/>
        </div>

        <div class="form-row">
            <form:label path="role">권한</form:label>

            <form:select path="role">
                <form:option value="USER">일반 사원</form:option>
                <form:option value="ADMIN">관리자</form:option>
            </form:select>

            <form:errors
                path="role"
                cssClass="field-error"/>
        </div>

 <div class="password-guide">
    <span class="guide-icon">ⓘ</span>
    초기 비밀번호는 <strong>1234</strong>로 지정됩니다.
    최초 로그인 후 비밀번호를 변경해야 합니다.
</div>
 

        <div class="form-actions">
            <a href="${pageContext.request.contextPath}/employees"
               class="cancel-button">
                취소
            </a>

            <button type="submit" class="submit-button">
                사원 등록
            </button>
        </div>

    </form:form>

</section>