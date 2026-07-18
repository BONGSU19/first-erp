package kr.spring.approval.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import kr.spring.member.entity.EmployeeEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "APPROVAL")
@Getter
@Setter
@NoArgsConstructor
public class ApprovalEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "APP_ID")
    private Long appId;

    @Column(
        name = "TITLE",
        nullable = false,
        length = 200
    )
    private String title;

    @Lob
    @Column(
        name = "CONTENT",
        nullable = false
    )
    private String content;

    @Column(
        name = "DOC_TYPE",
        nullable = false,
        length = 30
    )
    private String docType;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "DRAFTER_ID",
        nullable = false
    )
    private EmployeeEntity drafter;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "APPROVER_ID",
        nullable = false
    )
    private EmployeeEntity approver;

    @Column(
        name = "STATUS",
        nullable = false,
        length = 20
    )
    private String status = "PENDING";

    @Column(
        name = "CREATED_AT",
        insertable = false,
        updatable = false
    )
    private LocalDateTime createdAt;

    @Column(
        name = "REJECT_REASON",
        length = 500
    )
    private String rejectReason;

    public boolean isPending() {
        return "PENDING".equals(status);
    }
}