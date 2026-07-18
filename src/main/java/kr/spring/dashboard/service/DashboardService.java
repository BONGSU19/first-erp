package kr.spring.dashboard.service;

import org.springframework.stereotype.Service;

import kr.spring.approval.repository.ApprovalRepository;
import kr.spring.attendance.repository.AttendanceRepository;
import kr.spring.attendance.service.AttendanceService;
import kr.spring.dashboard.dto.DashboardDTO;
import kr.spring.material.repository.MaterialRepository;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashboardService {
	private final MaterialRepository materialRepository;
    private final MemberRepository memberRepository;
    private final AttendanceService
    attendanceService;
    
    private final ApprovalRepository approvalRepository;
    public DashboardDTO getDashboard(String empId) {

        EmployeeEntity employee =
                memberRepository.findByEmpId(empId);

        DashboardDTO dashboard = new DashboardDTO();

        dashboard.setEmpName(employee.getEmpName());
        dashboard.setDeptName(employee.getDeptName());

        String attendanceStatus =
                attendanceService
                    .getAttendanceStatus(empId);

        dashboard.setAttendanceStatus(
            attendanceStatus
        );
        

        
        long count=approvalRepository.countByApprover_EmpIdAndStatus(empId,"PENDING");
        dashboard.setPendingApprovalCount(count);
        dashboard.setApprovedCount(0);
        dashboard.setRejectedCount(0);
        long lowStockCount =
                materialRepository
                    .countLowStockMaterials();

        dashboard.setLowStockCount(
            lowStockCount
        );
        dashboard.setUnreadNotificationCount(0);

        return dashboard;
    }
}