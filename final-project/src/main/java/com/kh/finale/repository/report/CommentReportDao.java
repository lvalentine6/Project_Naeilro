package com.kh.finale.repository.report;

import org.springframework.stereotype.Service;

import com.kh.finale.entity.report.CommentReportDto;

@Service
public interface CommentReportDao {
	
	// 댓글 신고 등록
	void cReportInsert(CommentReportDto commentReportDto);
}
