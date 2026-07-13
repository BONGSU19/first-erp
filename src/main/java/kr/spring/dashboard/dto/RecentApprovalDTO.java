package kr.spring.dashboard.dto;

import lombok.Data;

@Data
public class RecentApprovalDTO {

    private Long approvalId;
    private String title;
    private String writerName;
    private String status;
    private String createdDate;
}