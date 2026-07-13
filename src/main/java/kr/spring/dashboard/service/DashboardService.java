package kr.spring.dashboard.service;

import org.springframework.stereotype.Service;

import kr.spring.dashboard.dto.DashboardDTO;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DashboardService {

    private final MemberRepository memberRepository;

    public DashboardDTO getDashboard(String empId) {

        EmployeeEntity employee =
                memberRepository.findByEmpId(empId);

        DashboardDTO dashboard = new DashboardDTO();

        dashboard.setEmpName(employee.getEmpName());
        dashboard.setDeptName(employee.getDeptName());

        // 아직 해당 기능을 구현하지 않았으므로 임시 값
        dashboard.setAttendanceStatus("미출근");
        dashboard.setPendingApprovalCount(0);
        dashboard.setApprovedCount(0);
        dashboard.setRejectedCount(0);
        dashboard.setLowStockCount(0);
        dashboard.setUnreadNotificationCount(0);

        return dashboard;
    }
}