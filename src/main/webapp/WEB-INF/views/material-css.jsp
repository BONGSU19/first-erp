<style>
.material-container,
.material-register-container {
    padding: 25px 30px;
}

.page-title-area {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

.page-title-area h1,
.register-title h1 {
    margin: 0 0 8px;
    color: #123f5d;
}

.page-title-area p,
.register-title p {
    margin: 0;
    color: #748692;
}

.title-buttons,
.form-actions {
    display: flex;
    gap: 9px;
}

.btn {
    display: inline-block;
    border: 0;
    border-radius: 5px;
    padding: 10px 16px;
    color: white;
    text-decoration: none;
    cursor: pointer;
}

.btn.primary {
    background: #006a9f;
}

.btn.secondary {
    background: #536d7d;
}

.btn.reset {
    background: #8b999f;
}

.btn.process {
    padding: 7px 12px;
    background: #0877aa;
}

.search-form {
    display: flex;
    gap: 8px;
    margin-bottom: 28px;
}

.search-form input {
    width: 320px;
    padding: 10px;
    border: 1px solid #c6d3da;
    border-radius: 5px;
}

.section-header {
    margin-bottom: 12px;
    color: #244c63;
}

.history-header {
    margin-top: 35px;
}

.table-wrapper {
    overflow-x: auto;
    border-radius: 8px;
    background: white;
    box-shadow: 0 2px 9px rgba(0, 50, 80, 0.09);
}

.material-table {
    width: 100%;
    border-collapse: collapse;
}

.material-table th,
.material-table td {
    padding: 13px 11px;
    border-bottom: 1px solid #e1ebf0;
    text-align: center;
    white-space: nowrap;
}

.material-table th {
    background: #e5f1f6;
    color: #224c63;
}

.low-stock-row {
    background: #fff5f3;
}

.stock-status,
.history-type,
.order-status {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 14px;
    font-size: 13px;
    font-weight: bold;
}

.stock-status.normal {
    background: #def3e6;
    color: #186c38;
}

.stock-status.low {
    background: #fce1dd;
    color: #b32d23;
}

.history-type.in {
    background: #dceffc;
    color: #176f9e;
}

.history-type.out {
    background: #fce3df;
    color: #b2392d;
}

.order-status.created {
    background: #fff0ca;
    color: #8a6300;
}

.order-status.approved {
    background: #dceffc;
    color: #176f9e;
}

.order-status.ordered {
    background: #e6e0fc;
    color: #5743a2;
}

.order-status.completed {
    background: #def3e6;
    color: #186c38;
}

.order-status.cancelled {
    background: #eeeeee;
    color: #666666;
}

.stock-form {
    display: flex;
    justify-content: center;
    gap: 5px;
}

.stock-form select,
.stock-form input {
    padding: 7px;
    border: 1px solid #c7d3da;
    border-radius: 4px;
}

.stock-form input {
    width: 80px;
}

.alert {
    margin-bottom: 18px;
    padding: 12px 15px;
    border-radius: 5px;
}

.alert.success {
    background: #e1f4e8;
    color: #176b37;
}

.alert.error {
    background: #fce3df;
    color: #ad3025;
}

.alert.warning {
    background: #fff2c7;
    color: #765800;
}

.empty-data {
    padding: 30px !important;
    color: #80909a;
}

.register-card {
    max-width: 600px;
    margin: 20px auto;
    padding: 30px;
    border-radius: 9px;
    background: white;
    box-shadow: 0 3px 13px rgba(0, 50, 80, 0.1);
}

.form-group {
    margin-top: 19px;
}

.form-group label {
    display: block;
    margin-bottom: 7px;
    color: #264c62;
    font-weight: bold;
}

.form-group input {
    width: 100%;
    padding: 11px;
    box-sizing: border-box;
    border: 1px solid #c6d3da;
    border-radius: 5px;
}

.field-error {
    display: block;
    margin-top: 5px;
    color: #b93227;
    font-size: 13px;
}

.form-actions {
    margin-top: 25px;
}

.section-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.result-count {
    color: #70838e;
    font-size: 14px;
}

.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 6px;
    margin-top: 18px;
}

.pagination a {
    min-width: 34px;
    padding: 8px 10px;
    box-sizing: border-box;
    border: 1px solid #cbd7de;
    border-radius: 5px;
    background: white;
    color: #31566b;
    text-align: center;
    text-decoration: none;
}

.pagination a:hover {
    border-color: #0874a8;
    background: #edf7fb;
}

.pagination a.active {
    border-color: #0874a8;
    background: #0874a8;
    color: white;
    font-weight: bold;
}


.order-register-container {
    padding: 30px;
}

.order-register-card {
    max-width: 650px;
    margin: 20px auto;
    padding: 32px;
    border-radius: 9px;
    background: white;
    box-shadow: 0 3px 14px rgba(0, 50, 80, 0.12);
}

.order-register-card .register-title {
    padding-bottom: 18px;
    border-bottom: 2px solid #1a5877;
}

.order-register-card .register-title h1 {
    margin: 0 0 8px;
    color: #173f57;
}

.order-register-card .register-title p {
    margin: 0;
    color: #74858f;
}

.order-register-card .form-group {
    margin-top: 20px;
}

.order-register-card .form-group label {
    display: block;
    margin-bottom: 7px;
    color: #264c62;
    font-weight: bold;
}

.order-register-card .form-group input,
.order-register-card .form-group select {
    width: 100%;
    padding: 11px;
    box-sizing: border-box;
    border: 1px solid #c5d3da;
    border-radius: 5px;
    background: white;
}

.order-register-card .form-group input[readonly] {
    background: #eef3f5;
    color: #657780;
}

.material-guide {
    margin-top: 10px;
    padding: 10px 13px;
    border-radius: 5px;
    background: #eef7fb;
    color: #486879;
    font-size: 14px;
}

.material-guide p {
    margin: 0;
}

.title-buttons {
    display: flex;
    gap: 10px;
}

.sub-information {
    color: #80909a;
    font-size: 12px;
}

.order-button {
    padding: 7px 13px;
    background: #0874a8;
    color: white;
}

.complete-button {
    padding: 7px 13px;
    border: 0;
    border-radius: 5px;
    background: #19834a;
    color: white;
    cursor: pointer;
}

.complete-button:hover {
    background: #126d3c;
}

.completed-text {
    color: #18713b;
    font-weight: bold;
}

.cancelled-text {
    color: #9a342c;
    font-weight: bold;
}


.order-form-container {
    padding: 30px;
}

.order-document {
    max-width: 750px;
    margin: 0 auto;
    padding: 35px;
    border-radius: 9px;
    background: white;
    box-shadow: 0 3px 14px rgba(0, 50, 80, 0.12);
}

.order-document-header {
    padding-bottom: 20px;
    border-bottom: 2px solid #185673;
    text-align: center;
}

.order-document-header h1 {
    margin: 0 0 10px;
    color: #173f57;
}

.order-document-header p {
    margin: 0;
    color: #71838d;
}

.order-detail-table {
    width: 100%;
    margin-top: 25px;
    border-collapse: collapse;
}

.order-detail-table th,
.order-detail-table td {
    padding: 13px;
    border: 1px solid #d7e2e8;
}

.order-detail-table th {
    width: 180px;
    background: #e9f3f7;
    color: #244e65;
    text-align: left;
}

.order-detail-table td {
    text-align: left;
}

.order-quantity {
    color: #b83b2f;
    font-size: 18px;
    font-weight: bold;
}

.order-form-buttons {
    display: flex;
    justify-content: center;
    gap: 10px;
    margin-top: 25px;
}

.order-confirm-button {
    background: #0874a8;
}
</style>