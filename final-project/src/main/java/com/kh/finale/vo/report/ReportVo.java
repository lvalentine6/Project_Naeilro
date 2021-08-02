package com.kh.finale.vo.report;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ReportVo {
	private int memberNo;
	private String memberNick;
	private int reportNo;
	private int no; // 댓글 or 포토스토리
	private String reason;
	private String reportConfirm;
}
