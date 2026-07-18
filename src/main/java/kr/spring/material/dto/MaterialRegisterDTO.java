package kr.spring.material.dto;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MaterialRegisterDTO {

    @NotBlank(message = "자재 코드를 입력해 주세요.")
    private String matCode;

    @NotBlank(message = "자재명을 입력해 주세요.")
    private String matName;

    @Min(
        value = 0,
        message = "현재 재고는 0 이상이어야 합니다."
    )
    private int currentStock;

    @Min(
        value = 0,
        message = "안전 재고는 0 이상이어야 합니다."
    )
    private int safetyStock;
}