package com.kh.finale.service.report;

import com.kh.finale.entity.report.PhotostoryReportDto;

public interface PhotostoryReportService {
	
	// 포토스토리 신고 등록
	void pReportInsert(PhotostoryReportDto photostoryReportDto);
}
