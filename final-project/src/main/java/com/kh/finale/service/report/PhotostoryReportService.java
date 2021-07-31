package com.kh.finale.service.report;

import java.util.List;

import com.kh.finale.entity.report.PhotostoryReportDto;
import com.kh.finale.vo.report.ReportVo;

public interface PhotostoryReportService {
	
	// 포토스토리 신고 등록
	void pReportInsert(PhotostoryReportDto photostoryReportDto);

	List<ReportVo> getList(int pageNo);

	void delete(int reportNo);

	void confirm(int reportNo);
}
