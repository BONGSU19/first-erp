package kr.spring.dashboard.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.dashboard.dto.DashboardDTO;
import kr.spring.dashboard.service.DashboardService;
import kr.spring.member.dto.EmployeeRegisterDTO;
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
            @RequestParam(required = false)
            String deptName,
            Authentication authentication,
            @RequestParam(required = false)
            String empName,

            Model model) {

        List<EmployeeEntity> employees =
            employeeService.searchEmployees(deptName, empName);
        String loginUser = authentication.getName();

        EmployeeEntity employee =
            memberRepository.findByEmpId(loginUser);

        model.addAttribute("dashboard", employee);
        model.addAttribute("employees", employees);

        // 검색 후 화면에 검색 조건 유지
        model.addAttribute("selectedDept", deptName);
        model.addAttribute("selectedEmpId", empName);

        return "employees";
    }
    
    
    @GetMapping("/employeesRegister")
    public String employeeRegisterForm(
            Authentication authentication,
            Model model) {

        addLoginMember(authentication, model);

        model.addAttribute(
                "employeeRegisterDTO",
                new EmployeeRegisterDTO()
        );

        return "employeeRegister";
    }
    

    
    // 사원 등록 처리
    @PostMapping("/employeesRegister")
    public String registerEmployee(
            @Valid
            @ModelAttribute("employeeRegisterDTO")
            EmployeeRegisterDTO dto,
            BindingResult bindingResult,
            Authentication authentication,
            Model model,
            RedirectAttributes redirectAttributes) {



        if (bindingResult.hasErrors()) {
            addLoginMember(authentication, model);

            return "employeeRegister";
        }

        try {
            employeeService.registerEmployee(dto);

        } catch (IllegalArgumentException e) {
            addLoginMember(authentication, model);
            model.addAttribute("error", e.getMessage());

            return "employeeRegister";
        }

        redirectAttributes.addFlashAttribute(
                "message",
                "신규 사원이 등록되었습니다."
        );

        return "redirect:/employees";
    }


    
    
    private void addLoginMember(
            Authentication authentication,
            Model model) {

        EmployeeEntity loginMember =
                memberRepository.findByEmpId(
                        authentication.getName()
                );

        model.addAttribute("dashboard", loginMember);
    }
}