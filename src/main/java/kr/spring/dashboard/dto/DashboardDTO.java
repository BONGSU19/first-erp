package kr.spring.dashboard.dto;

import lombok.Data;
import java.util.ArrayList;
import java.util.List;
@Data
public class DashboardDTO {

    private String empName;
    private String deptName;

    private String attendanceStatus;

    private long pendingApprovalCount;
    private long approvedCount;
    private long rejectedCount;

    private long lowStockCount;
    private long unreadNotificationCount;
    private List<RecentApprovalDTO> recentApprovals =
            new ArrayList<>();
}