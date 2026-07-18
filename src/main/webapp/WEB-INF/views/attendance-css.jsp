<style>
.attendance-container {
    padding: 28px 32px;
}

.attendance-page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
}

.attendance-page-header h1 {
    margin: 0 0 7px;
    color: #173f57;
}

.attendance-page-header p {
    margin: 0;
    color: #74858f;
}

.attendance-link-button {
    padding: 10px 16px;
    border-radius: 5px;
    background: #5b7180;
    color: white;
    text-decoration: none;
}

.attendance-alert {
    margin-bottom: 18px;
    padding: 13px 16px;
    border-radius: 6px;
}

.attendance-alert.success {
    background: #e2f4e8;
    color: #176b37;
}

.attendance-alert.error {
    background: #fce3df;
    color: #ad3025;
}

.attendance-summary {
    display: grid;
    grid-template-columns: 1.4fr 1fr 1fr;
    gap: 17px;
    margin-bottom: 22px;
}

.attendance-profile-card,
.attendance-status-card,
.attendance-ip-card {
    padding: 22px;
    border-radius: 9px;
    background: white;
    box-shadow: 0 2px 10px rgba(0, 50, 80, 0.09);
}

.attendance-profile-card {
    display: flex;
    align-items: center;
    gap: 16px;
}

.attendance-profile-icon {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 63px;
    height: 63px;
    border-radius: 50%;
    background: #e5f2f8;
    font-size: 29px;
}

.attendance-profile-information h2 {
    margin: 0 0 5px;
    color: #193f56;
}

.attendance-profile-information p {
    margin: 0 0 6px;
    color: #657b88;
}

.attendance-profile-information span {
    color: #8a999f;
    font-size: 13px;
}

.attendance-status-card,
.attendance-ip-card {
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.status-label,
.attendance-ip-card p {
    margin: 0 0 11px;
    color: #647a86;
}

.attendance-ip-card strong {
    color: #164761;
    font-size: 19px;
}

.attendance-ip-card span {
    margin-top: 7px;
    color: #89979e;
    font-size: 12px;
}

.work-status {
    display: inline-block;
    width: fit-content;
    padding: 7px 13px;
    border-radius: 16px;
    font-weight: bold;
}

.work-status.before,
.record-status.before {
    background: #eeeeee;
    color: #666666;
}

.work-status.working,
.record-status.working {
    background: #dceffc;
    color: #176f9e;
}

.work-status.completed,
.record-status.completed {
    background: #def3e6;
    color: #186c38;
}

.attendance-box {
    margin-top: 20px;
    padding: 25px;
    border-radius: 9px;
    background: white;
    box-shadow: 0 2px 10px rgba(0, 50, 80, 0.09);
}

.attendance-box-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 15px;
    border-bottom: 1px solid #dde7eb;
}

.attendance-box-header h2 {
    margin: 0;
    color: #234b61;
    font-size: 19px;
}

.attendance-box-header span {
    color: #7b8b93;
    font-size: 14px;
}

.today-time-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 16px;
    margin-top: 20px;
}

.time-card {
    padding: 22px;
    border: 1px solid #dce6ea;
    border-radius: 8px;
    text-align: center;
}

.time-icon {
    font-size: 27px;
}

.time-card p {
    margin: 8px 0;
    color: #657985;
}

.time-card strong {
    color: #173f57;
    font-size: 18px;
}

.attendance-actions {
    display: flex;
    justify-content: center;
    margin-top: 22px;
}

.attendance-button {
    min-width: 150px;
    padding: 12px 22px;
    border: 0;
    border-radius: 6px;
    color: white;
    font-size: 15px;
    font-weight: bold;
    cursor: pointer;
}

.attendance-button.clock-in {
    background: #0874a8;
}

.attendance-button.clock-out {
    background: #d06829;
}

.attendance-button.finished {
    background: #87979f;
    cursor: default;
}

.history-box {
    margin-bottom: 25px;
}

.attendance-table-wrapper {
    overflow-x: auto;
    margin-top: 20px;
}

.attendance-table {
    width: 100%;
    border-collapse: collapse;
}

.attendance-table th,
.attendance-table td {
    padding: 13px 11px;
    border-bottom: 1px solid #e1eaee;
    text-align: center;
    white-space: nowrap;
}

.attendance-table th {
    background: #e8f2f6;
    color: #284f64;
}

.record-status {
    display: inline-block;
    padding: 5px 10px;
    border-radius: 14px;
    font-size: 12px;
    font-weight: bold;
}

.empty-attendance {
    padding: 30px !important;
    color: #80909a;
}

@media (max-width: 900px) {
    .attendance-summary {
        grid-template-columns: 1fr;
    }

    .today-time-grid {
        grid-template-columns: 1fr;
    }
}
</style>