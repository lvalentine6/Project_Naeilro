package com.kh.finale.entity.report;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class CommentReportDto {
	private int memberNo;
	private int cReportNo;
	private String cReportReason;
}
