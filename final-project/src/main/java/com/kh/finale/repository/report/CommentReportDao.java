package com.kh.finale.repository.report;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.vo.report.PageVo;
import com.kh.finale.vo.report.ReportVo;

@Service
public interface CommentReportDao {
	
	// 댓글 신고 등록
	void cReportInsert(CommentReportDto commentReportDto);

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
