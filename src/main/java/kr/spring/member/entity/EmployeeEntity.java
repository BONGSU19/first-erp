package kr.spring.member.entity;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import lombok.Data;

@Data // ◀ 보내주신 @Getter, @Setter가 이 안에 다 들어있습니다!
@Entity // ◀ JPA: 이 클래스를 DB 테이블과 연결합니다.
@Table(name = "employee") // ◀ Oracle DB의 실제 테이블 이름
public class EmployeeEntity {

    @Id // ◀ JPA: 이 변수가 테이블의 기본키(PK, 사원번호)임을 지정합니다.
    private String empId;     // 사원번호 (로그인 ID)
    
    private String password;  // 암호화된 비밀번호
    private String empName;   // 사원명
    private String deptName;  // 부서코드
    private String role;      // 권한 (ROLE_USER, ROLE_ADMIN)
    private int passwordChanged; // 기본값은 false(바꾸기 전)
    private String positionName;
    
    
}