package kr.spring.dashboard.controller;

import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.dashboard.dto.DashboardDTO;
import kr.spring.dashboard.service.DashboardService;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import kr.spring.member.service.EmployeeService;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class DashboardController {

    private final DashboardService dashboardService;
    private final EmployeeService employeeService;
    private final MemberRepository memberRepository;

    @GetMapping("/main")
    public String main(
            Authentication authentication,
            Model model) {

        String empId = authentication.getName();

        DashboardDTO dashboard =
                dashboardService.getDashboard(empId);

        model.addAttribute("dashboard", dashboard);

        return "main";
    }

    @GetMapping("/employees")
    public String employeeList(
            @RequestParam(required = false) String deptname,
            Authentication authentication,
            Model model) {

        List<EmployeeEntity> employees =
                employeeService.getEmployeesByDepartment(deptname);

        EmployeeEntity loginMember =
                memberRepository.findByEmpId(
                        authentication.getName()
                );

        model.addAttribute("employees", employees);
        model.addAttribute("selectedDept", deptname);
        model.addAttribute("loginMember", loginMember);

        return "list";
    }
}