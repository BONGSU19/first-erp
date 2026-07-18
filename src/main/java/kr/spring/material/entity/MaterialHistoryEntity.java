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
@Table(name = "MATERIAL_HISTORY")
@Getter
@Setter
@NoArgsConstructor
public class MaterialHistoryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "HISTORY_ID")
    private Long historyId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "MAT_CODE",
        nullable = false
    )
    private MaterialEntity material;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "EMP_ID",
        nullable = false
    )
    private EmployeeEntity employee;

    @Column(
        name = "TYPE",
        nullable = false,
        length = 10
    )
    private String type;

    @Column(
        name = "QUANTITY",
        nullable = false
    )
    private int quantity;


    @Column(name = "STOCK_BEFORE")
    private Integer stockBefore;

    @Column(name = "STOCK_AFTER")
    private Integer stockAfter;
    
    
    @Column(
    	    name = "REG_DATE",
    	    insertable = false,
    	    updatable = false
    	)
    	private LocalDateTime regDate;
}