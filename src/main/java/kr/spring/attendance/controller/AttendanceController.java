package kr.spring.attendance.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.spring.attendance.service.AttendanceService;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class AttendanceController {

    private final AttendanceService
            attendanceService;

    private final MemberRepository
            memberRepository;

    /**
     * 근태관리 페이지
     */
    @GetMapping("/attendance")
    public String attendancePage(
            Authentication authentication,
            HttpServletRequest request,
            Model model) {

        String empId =
                authentication.getName();

        /*
         * 오늘 근태 정보
         */
        model.addAttribute(
            "todayAttendance",
            attendanceService
                .getTodayAttendance(empId)
        );

        /*
         * 최근 근태 내역
         */
        model.addAttribute(
            "attendanceList",
            attendanceService
                .getRecentAttendances(empId)
        );

        /*
         * 현재 접속 IP
         */
        model.addAttribute(
            "clientIp",
            getClientIp(request)
        );

        /*
         * 공통 헤더 로그인 사용자 정보
         */
        addLoginMember(
            authentication,
            model
        );

        return "attendance";
    }

    /**
     * 출근 처리
     */
    @PostMapping("/attendance/clock-in")
    public String clockIn(
            Authentication authentication,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        try {
            attendanceService.clockIn(
                authentication.getName(),
                getClientIp(request)
            );

            redirectAttributes.addFlashAttribute(
                "message",
                "출근 처리가 완료되었습니다."
            );

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                "error",
                e.getMessage()
            );
        }

        return "redirect:/attendance";
    }

    /**
     * 퇴근 처리
     */
    @PostMapping("/attendance/clock-out")
    public String clockOut(
            Authentication authentication,
            HttpServletRequest request,
            RedirectAttributes redirectAttributes) {

        try {
            attendanceService.clockOut(
                authentication.getName(),
                getClientIp(request)
            );

            redirectAttributes.addFlashAttribute(
                "message",
                "퇴근 처리가 완료되었습니다."
            );

        } catch (IllegalArgumentException e) {

            redirectAttributes.addFlashAttribute(
                "error",
                e.getMessage()
            );
        }

        return "redirect:/attendance";
    }

    /**
     * 사용자 IP 주소 확인
     */
    private String getClientIp(
            HttpServletRequest request) {

        /*
         * 프록시 또는 로드밸런서를 거친 경우
         */
        String ipAddress =
                request.getHeader(
                    "X-Forwarded-For"
                );

        /*
         * X-Forwarded-For 값이 없다면
         * 요청의 실제 원격 주소 사용
         */
        if (ipAddress == null
                || ipAddress.isBlank()
                || "unknown".equalsIgnoreCase(
                    ipAddress
                )) {

            ipAddress =
                    request.getRemoteAddr();
        }

        /*
         * 여러 IP가 전달됐다면
         * 첫 번째 IP를 사용
         */
        if (ipAddress != null
                && ipAddress.contains(",")) {

            ipAddress =
                    ipAddress
                        .split(",")[0]
                        .trim();
        }

        /*
         * IPv6 로컬 주소를
         * IPv4 형태로 변환
         */
        if ("0:0:0:0:0:0:0:1"
                .equals(ipAddress)) {

            ipAddress = "127.0.0.1";
        }

        return ipAddress;
    }

    /**
     * 공통 헤더 로그인 사용자 정보
     */
    private void addLoginMember(
            Authentication authentication,
            Model model) {

        EmployeeEntity loginMember =
                memberRepository
                    .findById(
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