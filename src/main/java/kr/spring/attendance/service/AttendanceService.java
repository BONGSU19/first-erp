package kr.spring.attendance.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.attendance.entity.AttendanceEntity;
import kr.spring.attendance.repository.AttendanceRepository;
import kr.spring.member.entity.EmployeeEntity;
import kr.spring.member.repository.MemberRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttendanceService {

    private final AttendanceRepository
            attendanceRepository;

    private final MemberRepository
            memberRepository;

    /**
     * 오늘 근태 기록 조회
     */
    @Transactional(readOnly = true)
    public AttendanceEntity getTodayAttendance(
            String empId) {

        LocalDate today =
                LocalDate.now();

        return attendanceRepository
            .findByEmployee_EmpIdAndWorkDate(
                empId,
                today
            )
            .orElse(null);
    }

    /**
     * 최근 근태 기록 10건 조회
     */
    @Transactional(readOnly = true)
    public List<AttendanceEntity>
            getRecentAttendances(
                    String empId) {

        return attendanceRepository
            .findTop10ByEmployee_EmpIdOrderByWorkDateDesc(
                empId
            );
    }

    /**
     * 출근 처리
     */
    @Transactional
    public void clockIn(
            String empId,
            String ipAddress) {

        /*
         * 1. IP 확인
         */
        if (!isAllowedIp(ipAddress)) {
            throw new IllegalArgumentException(
                "허용된 사내 네트워크에서만 출근할 수 있습니다."
            );
        }

        LocalDate today =
                LocalDate.now();

        /*
         * 2. 오늘 출근 기록 중복 확인
         */
        boolean alreadyClockedIn =
                attendanceRepository
                    .findByEmployee_EmpIdAndWorkDate(
                        empId,
                        today
                    )
                    .isPresent();

        if (alreadyClockedIn) {
            throw new IllegalArgumentException(
                "오늘 출근 기록이 이미 존재합니다."
            );
        }

        /*
         * 3. 로그인 사원 조회
         */
        EmployeeEntity employee =
                memberRepository.findById(empId)
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "사원 정보를 찾을 수 없습니다."
                        )
                    );

        /*
         * 4. 출근 기록 생성
         */
        AttendanceEntity attendance =
                new AttendanceEntity();

        attendance.setEmployee(employee);
        attendance.setWorkDate(today);
        attendance.setClockIn(
            LocalDateTime.now()
        );
        attendance.setClockOut(null);
        attendance.setIpAddress(ipAddress);

        /*
         * 5. DB 저장
         */
        attendanceRepository.save(
            attendance
        );
    }

    /**
     * 퇴근 처리
     */
    @Transactional
    public void clockOut(
            String empId,
            String ipAddress) {

        /*
         * 1. IP 확인
         */
        if (!isAllowedIp(ipAddress)) {
            throw new IllegalArgumentException(
                "허용된 사내 네트워크에서만 퇴근할 수 있습니다."
            );
        }

        LocalDate today =
                LocalDate.now();

        /*
         * 2. 오늘 출근 기록 조회
         */
        AttendanceEntity attendance =
                attendanceRepository
                    .findByEmployee_EmpIdAndWorkDate(
                        empId,
                        today
                    )
                    .orElseThrow(() ->
                        new IllegalArgumentException(
                            "오늘 출근 기록이 없습니다."
                        )
                    );

        /*
         * 3. 출근 여부 확인
         */
        if (attendance.getClockIn() == null) {
            throw new IllegalArgumentException(
                "출근 처리 후 퇴근할 수 있습니다."
            );
        }

        /*
         * 4. 중복 퇴근 확인
         */
        if (attendance.getClockOut() != null) {
            throw new IllegalArgumentException(
                "이미 퇴근 처리되었습니다."
            );
        }

        /*
         * 5. 퇴근 시간 기록
         */
        attendance.setClockOut(
            LocalDateTime.now()
        );

        /*
         * findBy...로 조회한 attendance는
         * JPA가 관리하는 영속 상태이므로
         * save() 없이 변경 감지로 수정된다.
         */
    }

    /**
     * 출근 상태 문자열 반환
     */
    
    
    @Transactional(readOnly = true)
    public String getAttendanceStatus(
            String empId) {

        AttendanceEntity attendance =
                getTodayAttendance(empId);

        if (attendance == null) {
            return "출근 전";
        }

        if (attendance.getClockIn() != null
                && attendance.getClockOut() == null) {

            return "근무 중";
        }

        if (attendance.getClockOut() != null) {
            return "퇴근 완료";
        }

        return "출근 전";
    }

    /**
     * 사내 IP 확인
     */
    private boolean isAllowedIp(
            String ipAddress) {

        if (ipAddress == null
                || ipAddress.isBlank()) {

            return false;
        }

        /*
         * Eclipse 로컬 테스트 허용
         */
        if ("127.0.0.1".equals(ipAddress)
                || "0:0:0:0:0:0:0:1"
                    .equals(ipAddress)) {

            return true;
        }

        /*
         * 사내 네트워크 대역
         */
        return ipAddress.startsWith(
            "192.168."
        );
    }
    
    
    
}