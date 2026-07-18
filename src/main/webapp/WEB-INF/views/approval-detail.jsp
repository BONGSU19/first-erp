<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c"
    uri="http://java.sun.com/jsp/jstl/core"%>

<div class="approval-detail-container">

    <div class="approval-document">

        <div class="approval-document-header">
            <h1>전자결재 문서</h1>

            <span>
                문서번호 ${approval.appId}
            </span>
        </div>

        <table class="approval-detail-table">
            <tr>
                <th>문서 구분</th>
                <td>${approval.docType}</td>

                <th>상태</th>
                <td>
                    <span class="approval-status ${approval.status}">
                        ${approval.status}
                    </span>
                </td>
            </tr>

            <tr>
                <th>기안자</th>
                <td>
                    ${approval.drafter.empName}
                    (${approval.drafter.empId})
                </td>

                <th>결재자</th>
                <td>
                    ${approval.approver.empName}
                    (${approval.approver.empId})
                </td>
            </tr>

            <tr>
                <th>작성일</th>
                <td colspan="3">
                    ${approval.createdAt}
                </td>
            </tr>

            <tr>
                <th>제목</th>
                <td colspan="3">
                    ${approval.title}
                </td>
            </tr>

            <tr>
                <th>내용</th>
                <td colspan="3"
                    class="approval-content">
                    ${approval.content}
                </td>
            </tr>

            <c:if test="${approval.status == 'REJECTED'}">
                <tr>
                    <th>반려 사유</th>
                    <td colspan="3"
                        class="reject-reason">
                        ${approval.rejectReason}
                    </td>
                </tr>
            </c:if>
        </table>

     <c:if test="${canProcess and approval.status == 'PENDING'}">

    <div class="decision-panel">

        <div class="decision-panel-header">
            <div>
                <h3>결재 처리</h3>
                <p>문서 내용을 확인하고 승인 또는 반려해 주세요.</p>
            </div>

            <span class="decision-status">
                결재 대기
            </span>
        </div>

        <div class="decision-body">

            <form method="post"
                  class="approve-form"
                  action="${pageContext.request.contextPath}/approvals/${approval.appId}/approve"
                  onsubmit="return confirm('이 문서를 승인하시겠습니까?');">

                <c:if test="${not empty _csrf}">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}">
                </c:if>

                <div class="decision-information">
                    <span class="decision-icon approve-icon">✓</span>

                    <div>
                        <strong>문서 승인</strong>
                        <p>검토한 문서를 승인 처리합니다.</p>
                    </div>
                </div>

                <button type="submit"
                        class="decision-button approve-button">
                    승인하기
                </button>
            </form>

            <form method="post"
                  class="reject-form"
                  action="${pageContext.request.contextPath}/approvals/${approval.appId}/reject"
                  onsubmit="return validateRejectForm(this);">

                <c:if test="${not empty _csrf}">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}">
                </c:if>

                <div class="decision-information">
                    <span class="decision-icon reject-icon">!</span>

                    <div>
                        <strong>문서 반려</strong>
                        <p>반려 사유를 작성한 뒤 반려 처리합니다.</p>
                    </div>
                </div>

                <label for="rejectReason"
                       class="reject-label">
                    반려 사유
                </label>

                <textarea id="rejectReason"
                          name="rejectReason"
                          maxlength="500"
                          placeholder="반려 사유를 구체적으로 입력해 주세요."
                          required></textarea>

                <div class="reject-footer">
                    <span>
                        <strong id="reasonLength">0</strong>/500
                    </span>

                    <button type="submit"
                            class="decision-button reject-button">
                        반려하기
                    </button>
                </div>

            </form>

        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const textarea =
                document.getElementById('rejectReason');

            const length =
                document.getElementById('reasonLength');

            if (textarea && length) {
                textarea.addEventListener('input', function () {
                    length.textContent = this.value.length;
                });
            }
        });

        function validateRejectForm(form) {
            const reason =
                form.rejectReason.value.trim();

            if (reason.length === 0) {
                alert('반려 사유를 입력해 주세요.');
                form.rejectReason.focus();

                return false;
            }

            return confirm('이 문서를 반려하시겠습니까?');
        }
    </script>

</c:if>
        <div class="approval-detail-buttons">

            <a class="approval-button secondary"
               href="${pageContext.request.contextPath}/approvals">
                목록
            </a>

        </div>
    </div>
</div>