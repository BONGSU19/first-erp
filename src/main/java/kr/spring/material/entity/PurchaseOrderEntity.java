package kr.spring.material.entity;

import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import kr.spring.member.entity.EmployeeEntity;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "PURCHASE_ORDER")
@Getter
@Setter
@NoArgsConstructor
public class PurchaseOrderEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ORDER_ID")
    private Long orderId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "MAT_CODE",
        nullable = false
    )
    private MaterialEntity material;

    @Column(
        name = "ORDER_QUANTITY",
        nullable = false
    )
    private int orderQuantity;

    @Column(
        name = "STATUS",
        nullable = false,
        length = 20
    )
    private String status = "CREATED";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "CREATED_BY",
        nullable = false
    )
    private EmployeeEntity createdBy;

    @Column(
        name = "CREATED_AT",
        insertable = false,
        updatable = false
    )
    private LocalDateTime createdAt;

    @Column(name = "COMPLETED_AT")
    private LocalDateTime completedAt;
}