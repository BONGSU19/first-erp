package kr.spring.config;
import kr.spring.member.entity.EmployeeEntity;

import kr.spring.member.repository.MemberRepository;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.security.core.Authentication;

import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import org.springframework.stereotype.Component;



// javax 패키지를 사용합니다!

import javax.servlet.ServletException;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;

import java.io.IOException;



@Component

public class CustomAuthenticationSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {



@Autowired

private MemberRepository memberRepository;



@Override

public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,

Authentication authentication) throws IOException, ServletException {


String empId = authentication.getName();

EmployeeEntity employee = memberRepository.findByEmpId(empId);



// 비밀번호를 바꾼 적이 없다면 (false인 경우)

if (employee != null && 0==employee.getPasswordChanged()) {

getRedirectStrategy().sendRedirect(request, response, "/change-password");

} else {

getRedirectStrategy().sendRedirect(request, response, "/main");

}

}

}