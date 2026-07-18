package kr.spring.approval.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.approval.dto.ApprovalCreateDTO;
import kr.spring.approval.entity.ApprovalEntity;
import kr.spring.approval.repository.ApprovalRepository;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ApprovalService {

    private final ApprovalRepository
            approvalRepository;

    private final MemberRepository
            memberRepository;

    /**
     * 기안서 작성
     */
    @Transactional
    public void createApproval(
            ApprovalCreateDTO dto,
            String drafterId) {

        EmployeeEntity drafter =
                getEmployee(drafterId);

        EmployeeEntity approver =
                getEmployee(dto.getApproverId());

        if (drafter.getEmpId().equals(
                approver.getEmpId())) {

            throw new IllegalArgumentException(
                "본인을 결재자로 지정할 수 없습니다."
            );
        }

        ApprovalEntity approval =
                new ApprovalEntity();

        approval.setDocType(
            dto.getDocType()
        );

        approval.setTitle(
            dto.getTitle().trim()
        );

        approval.setContent(
            dto.getContent().trim()
        );

        approval.setDrafter(drafter);
        approval.setApprover(approver);
        approval.setStatus("PENDING");

        approvalRepository.save(approval);
    }

    /**
     * 받은 결재 목록
     */
    @Transactional(readOnly = true)
    public List<ApprovalEntity>
            getReceivedApprovals(
                    String empId) {

        return approvalRepository
            .findByApprover_EmpIdOrderByAppIdDesc(
                empId
            );
    }
    
    
    
    
    
    
    
    

    /**
     * 보낸 결재 목록
     */
    @Transactional(readOnly = true)
    public List<ApprovalEntity>
            getSentApprovals(
                    String empId) {

        return approvalRepository
            .findByDrafter_EmpIdOrderByAppIdDesc(
                empId
            );
    }

    /**
     * 결재 상세 조회 및 접근 권한 확인
     */
    @Transactional(readOnly = true)
    public ApprovalEntity getApproval(
            Long appId,
            String loginEmpId) {

        ApprovalEntity approval =
                approvalRepository.findById(appId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "결재 문서를 찾을 수 없습니다."
                        )
                    );

        boolean isDrafter =
                approval.getDrafter()
                    .getEmpId()
                    .equals(loginEmpId);

        boolean isApprover =
                approval.getApprover()
                    .getEmpId()
                    .equals(loginEmpId);

        EmployeeEntity loginEmployee =
                getEmployee(loginEmpId);

        boolean isAdmin =
                "ROLE_ADMIN".equals(
                    loginEmployee.getRole()
                )
                || "ADMIN".equals(
                    loginEmployee.getRole()
                );

        if (!isDrafter
                && !isApprover
                && !isAdmin) {

            throw new IllegalArgumentException(
                "해당 결재 문서를 확인할 권한이 없습니다."
            );
        }

        return approval;
    }

    /**
     * 결재 승인
     */
    @Transactional
    public void approve(
            Long appId,
            String approverId) {

        ApprovalEntity approval =
                getPendingApproval(
                    appId,
                    approverId
                );

        approval.setStatus("APPROVED");
        approval.setRejectReason(null);
    }

    /**
     * 결재 반려
     */
    @Transactional
    public void reject(
            Long appId,
            String approverId,
            String rejectReason) {

        if (rejectReason == null
                || rejectReason.isBlank()) {

            throw new IllegalArgumentException(
                "반려 사유를 입력해 주세요."
            );
        }

        ApprovalEntity approval =
                getPendingApproval(
                    appId,
                    approverId
                );

        approval.setStatus("REJECTED");
        approval.setRejectReason(
            rejectReason.trim()
        );
    }

    /**
     * 대기 상태 및 결재자 검증
     */
    private ApprovalEntity getPendingApproval(
            Long appId,
            String approverId) {

        ApprovalEntity approval =
                approvalRepository.findById(appId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "결재 문서를 찾을 수 없습니다."
                        )
                    );

        if (!approval.getApprover()
                .getEmpId()
                .equals(approverId)) {

            throw new IllegalArgumentException(
                "결재 처리 권한이 없습니다."
            );
        }

        if (!approval.isPending()) {
            throw new IllegalArgumentException(
                "이미 처리된 결재 문서입니다."
            );
        }

        return approval;
    }

    /**
     * 결재자 선택 목록
     */
    @Transactional(readOnly = true)
    public List<EmployeeEntity>
            getEmployees() {

        return memberRepository.findAll();
    }

    private EmployeeEntity getEmployee(
            String empId) {

        return memberRepository.findById(empId)
            .orElseThrow(() ->
                new IllegalArgumentException(
                    "사원 정보를 찾을 수 없습니다."
                )
            );
    }
}