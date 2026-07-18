package kr.spring.material.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "MATERIAL")
@Getter
@Setter
@NoArgsConstructor
public class MaterialEntity {

    @Id
    @Column(name = "MAT_CODE", length = 20)
    private String matCode;

    @Column(
        name = "MAT_NAME",
        nullable = false,
        length = 100
    )
    private String matName;

    @Column(
        name = "CURRENT_STOCK",
        nullable = false
    )
    private int currentStock;

    @Column(
        name = "SAFETY_STOCK",
        nullable = false
    )
    private int safetyStock;

    public void increaseStock(int quantity) {

        if (quantity <= 0) {
            throw new IllegalArgumentException(
                "입고 수량은 1개 이상이어야 합니다."
            );
        }

        this.currentStock += quantity;
    }

    public void decreaseStock(int quantity) {

        if (quantity <= 0) {
            throw new IllegalArgumentException(
                "출고 수량은 1개 이상이어야 합니다."
            );
        }

        if (currentStock < quantity) {
            throw new IllegalArgumentException(
                "현재 재고보다 많이 출고할 수 없습니다."
            );
        }

        this.currentStock -= quantity;
    }

    public boolean isBelowSafetyStock() {
        return currentStock < safetyStock;
    }
}