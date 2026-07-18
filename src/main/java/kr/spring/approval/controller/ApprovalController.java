package kr.spring.approval.controller;

import javax.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.approval.dto.ApprovalCreateDTO;
import kr.spring.approval.entity.ApprovalEntity;
import kr.spring.approval.service.ApprovalService;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ApprovalController {

    private final ApprovalService approvalService;
    private final MemberRepository memberRepository;

    /**
     * 결재 목록
     */
    @GetMapping("/approvals")
    public String approvalList(
            @RequestParam(
                defaultValue = "received"
            )
            String view,
            Authentication authentication,
            Model model) {

        String empId =
                authentication.getName();

        addLoginMember(authentication, model);

        if ("sent".equals(view)) {
            model.addAttribute(
                "approvals",
                approvalService
                    .getSentApprovals(empId)
            );

        } else {
            view = "received";

            model.addAttribute(
                "approvals",
                approvalService
                    .getReceivedApprovals(empId)
            );
        }

        model.addAttribute(
            "selectedView",
            view
        );

        return "approvals";
    }

    /**
     * 기안서 작성 화면
     */
    @GetMapping("/approvals/write")
    public String approvalWriteForm(
            Authentication authentication,
            Model model) {

        addLoginMember(authentication, model);

        model.addAttribute(
            "approvalCreateDTO",
            new ApprovalCreateDTO()
        );

        model.addAttribute(
            "employees",
            approvalService.getEmployees()
        );

        return "approvalWrite";
    }

    /**
     * 기안서 저장
     */
    @PostMapping("/approvals")
    public String createApproval(
            @Valid
            @ModelAttribute("approvalCreateDTO")
            ApprovalCreateDTO dto,
            BindingResult bindingResult,
            Authentication authentication,
            Model model,
            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            addLoginMember(authentication, model);

            model.addAttribute(
                "employees",
                approvalService.getEmployees()
            );

            return "approvalWrite";
        }

        try {
            approvalService.createApproval(
                dto,
                authentication.getName()
            );

        } catch (IllegalArgumentException e) {
            addLoginMember(authentication, model);

            model.addAttribute(
                "employees",
                approvalService.getEmployees()
            );

            model.addAttribute(
                "error",
                e.getMessage()
            );

            return "approvalWrite";
        }

        redirectAttributes.addFlashAttribute(
            "message",
            "결재 문서가 상신되었습니다."
        );

        return "redirect:/approvals?view=sent";
    }

    /**
     * 결재 상세
     */
    @GetMapping("/approvals/{appId}")
    public String approvalDetail(
            @PathVariable Long appId,
            Authentication authentication,
            Model model,
            RedirectAttributes redirectAttributes) {

        try {
            String loginEmpId =
                    authentication.getName();

            ApprovalEntity approval =
                    approvalService.getApproval(
                        appId,
                        loginEmpId
                    );

            /*
             * 현재 로그인한 사원이
             * 이 문서의 결재자인지 확인
             */
            boolean canProcess =
                    approval.getApprover() != null
                    && loginEmpId.equals(
                        approval.getApprover()
                            .getEmpId()
                    );

            addLoginMember(
                authentication,
                model
            );

            model.addAttribute(
                "approval",
                approval
            );

            model.addAttribute(
                "loginEmpId",
                loginEmpId
            );

            model.addAttribute(
                "canProcess",
                canProcess
            );

            return "approvalDetail";

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute(
                "error",
                e.getMessage()
            );

            return "redirect:/approvals";
        }
    }

    /**
     * 승인
     */
    @PostMapping("/approvals/{appId}/approve")
    public String approve(
            @PathVariable Long appId,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        try {
            approvalService.approve(
                appId,
                authentication.getName()
            );

            redirectAttributes.addFlashAttribute(
                "message",
                "결재를 승인했습니다."
            );

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute(
                "error",
                e.getMessage()
            );
        }

        return "redirect:/approvals/" + appId;
    }

    /**
     * 반려
     */
    @PostMapping("/approvals/{appId}/reject")
    public String reject(
            @PathVariable Long appId,
            @RequestParam String rejectReason,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {

        try {
            approvalService.reject(
                appId,
                authentication.getName(),
                rejectReason
            );

            redirectAttributes.addFlashAttribute(
                "message",
                "결재를 반려했습니다."
            );

        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute(
                "error",
                e.getMessage()
            );
        }

        return "redirect:/approvals/" + appId;
    }

    private void addLoginMember(
            Authentication authentication,
            Model model) {

        EmployeeEntity loginMember =
                memberRepository.findById(
                    authentication.getName()
                )
                .orElseThrow(() ->
                    new IllegalArgumentException(
                        "로그인 사원 정보를 찾을 수 없습니다."
                    )
                );

        model.addAttribute(
            "dashboard",
            loginMember
        );
    }
}