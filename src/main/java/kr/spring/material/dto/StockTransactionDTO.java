package kr.spring.material.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class StockTransactionDTO {

    @NotBlank(message = "입출고 유형을 선택해 주세요.")
    private String type;

    @Min(
        value = 1,
        message = "수량은 1개 이상이어야 합니다."
    )
    private int quantity;
}