package kr.spring.member.dto;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmployeeRegisterDTO {

    @NotBlank(message = "사번을 입력해주세요.")
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