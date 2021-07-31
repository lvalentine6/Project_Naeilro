package com.kh.finale.service.report;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.repository.report.CommentReportDao;
import com.kh.finale.vo.report.PageVo;
import com.kh.finale.vo.report.ReportVo;

@Service
public class CommentReportServiceImpl implements CommentReportService{

	@Autowired
	CommentReportDao commentReportDao;
	
	// 댓글 신고 등록
	@Override
	public void cReportInsert(CommentReportDto commentReportDto) {
		commentReportDao.cReportInsert(commentReportDto);
	}
	
	@Override
	public List<ReportVo> getList(int pageNo){
		PageVo pageVo = new PageVo();
		pageVo=pageVo.getPageVariable(pageNo, 10,commentReportDao.getCount());
		return commentReportDao.getList(pageVo);
	}
}
