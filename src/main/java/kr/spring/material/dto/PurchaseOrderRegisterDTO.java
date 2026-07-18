package kr.spring.material.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PurchaseOrderRegisterDTO {

    @NotBlank(
        message = "발주할 자재를 선택해 주세요."
    )
    private String matCode;

    @Min(
        value = 1,
        message = "발주 수량은 1개 이상이어야 합니다."
    )
    private int orderQuantity;
}