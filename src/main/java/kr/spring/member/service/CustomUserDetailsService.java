package kr.spring.member.service;

import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired // 이미 생성되어 있는 리포지토리 부품을 부릅니다.
    private MemberRepository memberRepository;
  
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 리포지토리가 DB에서 꺼내어 '새로 채워준 데이터 그릇(Entity)'을 받습니다.
        EmployeeEntity employee = memberRepository.findByEmpId(username);
        System.out.println("조회할 아이디: " + username);
        if (employee == null) {
            throw new UsernameNotFoundException("존재하지 않는 사원번호입니다: " + username);
        }
        String role;

        if (employee.getPasswordChanged() == 0) {
            role = "TEMP";
        } else {
            role = employee.getRole().replace("ROLE_", "");
        }
        // 시큐리티가 체킹할 수 있게 포장해서 리턴
        return User.builder()
                .username(employee.getEmpId()) 
                .password(employee.getPassword())
                .roles(employee.getRole().replace("ROLE_", ""))
                .build();  
        
        
    }
}     