package com.kh.finale.service.report;

import java.util.List;

import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.vo.report.ReportVo;

public interface CommentReportService {
	
	// 댓글 신고 등록
	void cReportInsert(CommentReportDto commentReportDto);

	List<ReportVo> getList(int pageNo);

	void delete(int reportNo);

	void confirm(int reportNo);

	List<ReportVo> getYList(Integer pageNo);
	List<ReportVo> getNList(Integer pageNo);
}
