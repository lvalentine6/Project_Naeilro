package com.kh.finale.repository.report;

import com.kh.finale.entity.report.PhotostoryReportDto;

public interface PhotostoryReportDao {
	
	// 포토스토리 신고 등록
	void pReportInsert(PhotostoryReportDto photostoryReportDto);
}
