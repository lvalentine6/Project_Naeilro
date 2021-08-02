package com.kh.finale.repository.report;

import java.util.List;

import com.kh.finale.entity.report.PhotostoryReportDto;
import com.kh.finale.vo.report.PageVo;
import com.kh.finale.vo.report.ReportVo;

public interface PhotostoryReportDao {
	
	// 포토스토리 신고 등록
	void pReportInsert(PhotostoryReportDto photostoryReportDto);

	int getCount();

	List<ReportVo> getList(PageVo pageVo);

	void delete(int reportNo);

	void confirm(int reportNo);

	int getYCount();
	int getNCount();
	
	List<ReportVo> getYList(PageVo pageVo);
	List<ReportVo> getNList(PageVo pageVo);

	List<ReportVo> getMemberPList(int memberNo);
}
