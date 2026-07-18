package kr.spring.approval.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.spring.approval.entity.ApprovalEntity;

@Repository
public interface ApprovalRepository
        extends JpaRepository<ApprovalEntity, Long> {

    List<ApprovalEntity>
        findByDrafter_EmpIdOrderByAppIdDesc(
            String empId
        );

    List<ApprovalEntity>
        findByApprover_EmpIdOrderByAppIdDesc(
            String empId
        );

    long countByApprover_EmpIdAndStatus(
        String empId,
        String status
    );

    List<ApprovalEntity>
        findTop5ByDrafter_EmpIdOrApprover_EmpIdOrderByAppIdDesc(
            String drafterId,
            String approverId
        );
    
    
}