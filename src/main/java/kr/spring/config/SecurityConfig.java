package kr.spring.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import kr.spring.member.service.CustomUserDetailsService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Autowired
    private CustomAuthenticationSuccessHandler customAuthenticationSuccessHandler;

    @Autowired
    private CustomUserDetailsService customUserDetailsService;


    // 비밀번호 암호화
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }


    // Security 설정
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
            // CSRF 비활성화
            .csrf(csrf -> csrf.disable())

            // HTTP Basic 로그인 팝업 제거
            .httpBasic(httpBasic -> httpBasic.disable())


            // ⭐ 인가 설정 (Boot 2.7 방식)
            .authorizeRequests(auth -> auth

                // 로그인 관련
                .antMatchers("/login").permitAll()
                .antMatchers("/error").permitAll()

                // 정적 리소스
                .antMatchers("/css/**").permitAll()
                .antMatchers("/js/**").permitAll()
                .antMatchers("/images/**").permitAll()

                // 비밀번호 변경
                .antMatchers("/change-password").authenticated()

                // 관리자
                .antMatchers("/api/admin/**").hasRole("ADMIN")
                .antMatchers("/api/hr/salary/**").hasRole("ADMIN")

                // 일반 사용자
                .antMatchers("/main").hasAnyRole("USER", "ADMIN")

                // 나머지는 로그인 필요
                .anyRequest().authenticated()
            )


            // DB 사용자 조회 서비스
            .userDetailsService(customUserDetailsService)


            // 로그인 설정
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login-proc")
                .usernameParameter("empId")
                .passwordParameter("password")
                .successHandler(customAuthenticationSuccessHandler)
                .permitAll()
            )


            // 로그아웃
            .logout(logout -> logout
                .logoutUrl("/logout")
                .logoutSuccessUrl("/login?logout")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
            );


        return http.build();
    }
}