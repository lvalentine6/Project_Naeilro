package com.kh.finale.service.report;

import com.kh.finale.entity.report.CommentReportDto;

public interface CommentReportService {
	
	// 댓글 신고 등록
	void cReportInsert(CommentReportDto commentReportDto);
}
