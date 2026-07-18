package kr.spring.approval.dto;

import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApprovalCreateDTO {

    @NotBlank(
        message = "문서 구분을 선택해 주세요."
    )
    private String docType;

    @NotBlank(
        message = "제목을 입력해 주세요."
    )
    private String title;

    @NotBlank(
        message = "내용을 입력해 주세요."
    )
    private String content;

    @NotBlank(
        message = "결재자를 선택해 주세요."
    )
    private String approverId;
}