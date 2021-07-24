package com.kh.finale.service.report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.repository.report.CommentReportDao;

@Service
public class CommentReportServiceImpl implements CommentReportService{

	@Autowired
	CommentReportDao commentReportDao;
	
	// 댓글 신고 등록
	@Override
	public void cReportInsert(CommentReportDto commentReportDto) {
		commentReportDao.cReportInsert(commentReportDto);
	}

}
