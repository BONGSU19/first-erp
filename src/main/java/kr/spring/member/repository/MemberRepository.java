package kr.spring.member.repository;

import  kr.spring.member.entity.EmployeeEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MemberRepository extends JpaRepository<EmployeeEntity, String> {
    
    // 사원번호(empId)로 DB에서 사원 정보를 찾아오는 메서드 (JPA가 SQL을 자동 생성함)
    EmployeeEntity findByEmpId(String empId);
    
    List<EmployeeEntity> findByDeptName(String deptName);
}