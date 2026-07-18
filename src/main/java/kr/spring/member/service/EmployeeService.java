package kr.spring.member.service;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.member.dto.EmployeeRegisterDTO;
import kr.spring.member.dto.EmployeeUpdateDTO;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    /**
     * 전체 사원 또는 부서별 사원 조회
     */
    /**
     * 부서 및 사번 검색
     */
    @Transactional(readOnly = true)
    public List<EmployeeEntity> searchEmployees(
            String deptName,
            String empName) {

        boolean hasDeptName =
            deptName != null && !deptName.isBlank();

        boolean hasEmpId =
            empName != null && !empName.isBlank();

        // 부서와 사번 모두 입력
        if (hasDeptName && hasEmpId) {
            return memberRepository
                .findByDeptNameAndEmpNameContainingIgnoreCase(
                    deptName,
                    empName.trim()
                );
        }

        // 부서만 선택
        if (hasDeptName) {
            return memberRepository.findByDeptName(deptName);
        }

        // 사번만 입력
        if (hasEmpId) {
            return memberRepository
                .findByEmpNameContainingIgnoreCase(empName.trim());
        }

        // 아무 조건도 없는 경우
        return memberRepository.findAll();
    }

    /**
     * 신규 사원 등록
     */
    @Transactional
    public void registerEmployee(
            EmployeeRegisterDTO dto) {

        // empId가 PK이므로 JpaRepository 기본 메서드 사용
        if (memberRepository.existsById(dto.getEmpId())) {
            throw new IllegalArgumentException(
                    "이미 등록된 사번입니다."
            );
        }

        EmployeeEntity employee = new EmployeeEntity();

        employee.setEmpId(dto.getEmpId());
        employee.setEmpName(dto.getEmpName());
        employee.setDeptName(dto.getDeptName());
        employee.setRole(dto.getRole());

        // 비밀번호는 반드시 암호화해서 저장
        employee.setPassword(
                passwordEncoder.encode("1234")
            );

        // 최초 로그인 시 비밀번호 변경
        employee.setPasswordChanged(0);

        memberRepository.save(employee);
    }
    
    
    @Transactional(readOnly = true)
    public EmployeeUpdateDTO getEmployeeForUpdate(String empId) {

        EmployeeEntity employee = memberRepository.findById(empId)
            .orElseThrow(() ->
                new IllegalArgumentException("사원을 찾을 수 없습니다.")
            );

        EmployeeUpdateDTO dto = new EmployeeUpdateDTO();

        dto.setEmpId(employee.getEmpId());
        dto.setEmpName(employee.getEmpName());
        dto.setDeptName(employee.getDeptName());
        dto.setPositionName(employee.getPositionName());
        dto.setRole(employee.getRole());

        return dto;
    }
    
    @Transactional
    public void updateEmployee(
            String empId,
            EmployeeUpdateDTO dto) {

        EmployeeEntity employee = memberRepository.findById(empId)
            .orElseThrow(() ->
                new IllegalArgumentException("사원을 찾을 수 없습니다.")
            );

        employee.setEmpName(dto.getEmpName());
        employee.setDeptName(dto.getDeptName());
        employee.setPositionName(dto.getPositionName());
        employee.setRole(dto.getRole());
    }
}