
package kr.spring.member.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;

@Controller
public class MemberController {

	@Autowired
	private MemberRepository memberRepository;
	@Autowired
	private PasswordEncoder passwordEncoder;

	
	
	
    // 1. 로그인 화면을 보여주는 메서드
	@GetMapping("/login")
	public String loginPage(
	        @RequestParam(value = "error", required = false) String error,
	        @RequestParam(value = "exception", required = false) String exception,
	        Authentication authentication,
	        HttpServletResponse response,
	        Model model) {

	    // 로그인 페이지가 브라우저 캐시에 저장되지 않도록 설정
	    response.setHeader(
	        "Cache-Control",
	        "no-cache, no-store, must-revalidate"
	    );
	    response.setHeader("Pragma", "no-cache");
	    response.setDateHeader("Expires", 0);

	    // 이미 로그인된 사용자라면 메인 페이지로 이동
	    if (authentication != null
	            && authentication.isAuthenticated()
	            && !(authentication instanceof AnonymousAuthenticationToken)) {

	        return "redirect:/main";
	    }

	    // 로그인 실패 메시지
	    if (error != null) {
	        model.addAttribute(
	            "error",
	            "사원번호 또는 비밀번호가 올바르지 않습니다."
	        );
	        model.addAttribute("exception", exception);
	    }

	    return "login";
	}
    // 2. 메인 화면 (로그인 성공 후 이동할 페이지)

 // MemberController.java 에 추가
    
    @GetMapping("/change-password")
    public String changePasswordPage() {
        return "change-password";
    }
    @PostMapping("/change-password")
    public String changePassword(Authentication authentication,
                                 @RequestParam String newPassword,
                                 @RequestParam String confirmPassword) {


        if (!newPassword.equals(confirmPassword)) {
            return "change-password";
        }

        String empId = authentication.getName();

        EmployeeEntity employee = memberRepository.findByEmpId(empId);

   
        
        employee.setPassword(passwordEncoder.encode(newPassword));
        employee.setPasswordChanged(1);

        memberRepository.save(employee);

        return "redirect:/login?changed";
    }


    
    @GetMapping("/")
    public String index() {
        // 사용자가 처음 주소(http://localhost:8080/)로 들어오면
        // 바로 /login 주소로 강제 이동(Redirect) 시킵니다!
        return "redirect:/login"; 
    }
}