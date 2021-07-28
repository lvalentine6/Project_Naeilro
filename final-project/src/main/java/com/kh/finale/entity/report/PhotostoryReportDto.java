package com.kh.finale.entity.report;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PhotostoryReportDto {
	private int memberNo;
	private int ReportNo;
	private int photostoryNo;
	private String pReportReason;
}
