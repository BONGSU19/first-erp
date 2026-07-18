<style>
.approval-container,
.approval-form-container,
.approval-detail-container {
    padding: 30px;
}

.approval-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

.approval-header h1 {
    margin: 0 0 7px;
    color: #173f57;
}

.approval-header p {
    margin: 0;
    color: #74858f;
}

.approval-button {
    display: inline-block;
    padding: 10px 16px;
    border: 0;
    border-radius: 5px;
    color: white;
    text-decoration: none;
    cursor: pointer;
}

.approval-button.primary,
.approval-button.approve {
    background: #0874a8;
}

.approval-button.secondary {
    background: #627985;
}

.approval-button.reject {
    background: #c04438;
}

.approval-alert {
    margin-bottom: 18px;
    padding: 13px;
    border-radius: 5px;
}

.approval-alert.success {
    background: #e1f4e8;
    color: #176b37;
}

.approval-alert.error {
    background: #fce3df;
    color: #ad3025;
}

.approval-tabs {
    display: flex;
    gap: 6px;
    margin-bottom: 18px;
}

.approval-tabs a {
    padding: 9px 15px;
    border-radius: 5px;
    background: #e7eef2;
    color: #405d6d;
    text-decoration: none;
}

.approval-tabs a.active {
    background: #0874a8;
    color: white;
}

.approval-table-wrapper {
    overflow-x: auto;
    background: white;
}

.approval-table,
.approval-detail-table {
    width: 100%;
    border-collapse: collapse;
}

.approval-table th,
.approval-table td,
.approval-detail-table th,
.approval-detail-table td {
    padding: 13px;
    border: 1px solid #dde6ea;
    text-align: center;
}

.approval-table th,
.approval-detail-table th {
    background: #e8f2f6;
    color: #284f64;
}

.approval-status {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 14px;
    font-size: 12px;
    font-weight: bold;
}

.approval-status.PENDING {
    background: #fff0c7;
    color: #806000;
}

.approval-status.APPROVED {
    background: #def3e6;
    color: #176b37;
}

.approval-status.REJECTED {
    background: #fce3df;
    color: #ad3025;
}

.approval-form-card,
.approval-document {
    max-width: 850px;
    margin: 0 auto;
    padding: 32px;
    border-radius: 9px;
    background: white;
    box-shadow: 0 3px 14px rgba(0, 50, 80, 0.11);
}

.approval-form-group {
    margin-top: 18px;
}

.approval-form-group label {
    display: block;
    margin-bottom: 7px;
    font-weight: bold;
}

.approval-form-group input,
.approval-form-group select,
.approval-form-group textarea {
    width: 100%;
    padding: 11px;
    box-sizing: border-box;
    border: 1px solid #c7d4da;
    border-radius: 5px;
}

.approval-form-actions,
.approval-detail-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 24px;
}

.approval-content {
    min-height: 200px;
    text-align: left !important;
    white-space: pre-wrap;
}

.reject-reason {
    color: #ad3025;
    text-align: left !important;
}

.approval-process-area {
    display: flex;
    gap: 15px;
    margin-top: 25px;
}

.approval-process-area textarea {
    width: 350px;
    min-height: 70px;
}

.empty-approval {
    padding: 30px !important;
    color: #80909a;
}

/* 결재 처리 전체 카드 */
.decision-panel {
    width: 100%;
    margin-top: 28px;
    padding: 26px;
    border: 1px solid #dbe4ea;
    border-radius: 14px;
    background: #ffffff;
    box-shadow: 0 6px 20px rgba(30, 55, 75, 0.07);
    box-sizing: border-box;
    overflow: hidden;
}

.decision-panel-header {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    gap: 20px;
    padding-bottom: 20px;
    border-bottom: 1px solid #e5ebef;
}

.decision-panel-header h3 {
    margin: 0 0 7px;
    color: #183247;
    font-size: 20px;
    font-weight: 700;
}

.decision-panel-header p {
    margin: 0;
    color: #71808c;
    font-size: 13px;
}

.decision-status {
    flex-shrink: 0;
    padding: 7px 14px;
    border-radius: 999px;
    background: #fff0c2;
    color: #936600;
    font-size: 12px;
    font-weight: 700;
}

/* 승인·반려 2열 */
.decision-body {
    display: grid;
    grid-template-columns: minmax(0, 1fr) minmax(0, 1fr);
    gap: 20px;
    margin-top: 22px;
}

/* 기존 공통 form CSS 초기화 */
.decision-body form {
    width: auto;
    min-width: 0;
    margin: 0;
    padding: 22px;
    border-radius: 12px;
    box-sizing: border-box;
}

.approve-form {
    display: flex;
    flex-direction: column;
    border: 1px solid #bce6ca;
    background: #f5fcf7;
}

.reject-form {
    display: flex;
    flex-direction: column;
    border: 1px solid #f1c7c3;
    background: #fff8f7;
}

.decision-information {
    display: flex;
    align-items: flex-start;
    gap: 12px;
    margin-bottom: 20px;
}

.decision-information strong {
    display: block;
    margin-bottom: 5px;
    color: #243746;
    font-size: 16px;
}

.decision-information p {
    margin: 0;
    color: #72808b;
    font-size: 13px;
    line-height: 1.5;
}

.decision-icon {
    display: flex;
    align-items: center;
    justify-content: center;
    flex: 0 0 36px;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    font-size: 17px;
    font-weight: 800;
}

.approve-icon {
    background: #d8f4e1;
    color: #168443;
}

.reject-icon {
    background: #fde1de;
    color: #c93f34;
}

/* 반려 사유 입력 */
.reject-label {
    margin-bottom: 8px;
    color: #364b5b;
    font-size: 13px;
    font-weight: 700;
}

.reject-form textarea {
    display: block;
    width: 100%;
    min-width: 0;
    height: 110px;
    min-height: 110px;
    padding: 12px 13px;
    border: 1px solid #cbd5dc;
    border-radius: 8px;
    background: #ffffff;
    color: #263946;
    font-family: inherit;
    font-size: 13px;
    line-height: 1.6;
    resize: vertical;
    outline: none;
    box-sizing: border-box;
}

.reject-form textarea:focus {
    border-color: #d65349;
    box-shadow: 0 0 0 3px rgba(214, 83, 73, 0.12);
}

.reject-footer {
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 15px;
    margin-top: 12px;
}

.reject-footer > span {
    color: #87949d;
    font-size: 12px;
}

/* 버튼 */
.decision-button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    height: 42px;
    padding: 0 20px;
    border: 0;
    border-radius: 8px;
    color: #ffffff;
    font-family: inherit;
    font-size: 14px;
    font-weight: 700;
    cursor: pointer;
    box-sizing: border-box;
}

.approve-button {
    width: 100%;
    margin-top: auto;
    background: #14804a;
}

.approve-button:hover {
    background: #0f683b;
}

.reject-button {
    min-width: 105px;
    background: #c7463c;
}

.reject-button:hover {
    background: #a9362e;
}

/* 태블릿과 모바일 */
@media (max-width: 850px) {
    .decision-body {
        grid-template-columns: 1fr;
    }
}

@media (max-width: 550px) {
    .decision-panel {
        padding: 18px 14px;
    }

    .decision-panel-header {
        flex-direction: column;
        gap: 12px;
    }

    .decision-body form {
        padding: 18px 14px;
    }

    .reject-footer {
        flex-direction: column;
        align-items: stretch;
    }

    .reject-footer > span {
        text-align: right;
    }

    .reject-button {
        width: 100%;
    }
}
</style>

