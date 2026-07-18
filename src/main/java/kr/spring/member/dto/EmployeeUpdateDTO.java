package kr.spring.member.dto;

import javax.validation.constraints.NotBlank;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeeUpdateDTO {

    private String empId;

    @NotBlank(message = "이름을 입력해주세요.")
    private String empName;

    @NotBlank(message = "부서를 선택해주세요.")
    private String deptName;

    @NotBlank(message = "직급을 선택해주세요.")
    private String positionName;

    @NotBlank(message = "권한을 선택해주세요.")
    private String role;
}