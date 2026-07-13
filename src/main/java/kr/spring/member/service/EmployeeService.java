package kr.spring.member.service;

import java.util.List;

import org.springframework.stereotype.Service;

import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeService {

    private final MemberRepository memberRepository;

    /**
     * 전체 사원 또는 부서별 사원 조회
     */
    public List<EmployeeEntity> getEmployeesByDepartment(
            String deptName) {

        // 1. 최초로 /employees에 접속한 경우
        //    deptname은 null
        //
        // 2. 검색창에서 '전체 부서'를 선택한 경우
        //    deptname은 빈 문자열 ""
        if (deptName == null || deptName.isBlank()) {
            return memberRepository.findAll();
        }

        // 특정 부서를 선택한 경우
        return memberRepository.findByDeptName(deptName);
    }
}