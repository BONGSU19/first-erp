package kr.spring.attendance.entity;

import java.time.LocalDate;
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
@Table(name = "ATTENDANCE")
@Getter
@Setter
@NoArgsConstructor
public class AttendanceEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ATT_ID")
    private Long attId;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(
        name = "EMP_ID",
        nullable = false
    )
    private EmployeeEntity employee;

    @Column(
        name = "WORK_DATE",
        nullable = false
    )
    private LocalDate workDate;

    @Column(name = "CLOCK_IN")
    private LocalDateTime clockIn;

    @Column(name = "CLOCK_OUT")
    private LocalDateTime clockOut;

    @Column(
        name = "IP_ADDRESS",
        length = 50
    )
    private String ipAddress;

    public boolean isWorking() {
        return clockIn != null
            && clockOut == null;
    }

    public boolean isCompleted() {
        return clockIn != null
            && clockOut != null;
    }
}