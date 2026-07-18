package kr.spring.attendance.repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import kr.spring.attendance.entity.AttendanceEntity;

@Repository
public interface AttendanceRepository
        extends JpaRepository<AttendanceEntity, Long> {

    Optional<AttendanceEntity>
        findByEmployee_EmpIdAndWorkDate(
            String empId,
            LocalDate workDate
        );

    List<AttendanceEntity>
        findTop10ByEmployee_EmpIdOrderByWorkDateDesc(
            String empId
        );

    List<AttendanceEntity>
        findByWorkDateBetweenOrderByWorkDateAsc(
            LocalDate startDate,
            LocalDate endDate
        );
}