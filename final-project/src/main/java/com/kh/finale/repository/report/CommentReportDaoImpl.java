package com.kh.finale.repository.report;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.report.CommentReportDto;

@Repository
public class CommentReportDaoImpl implements CommentReportDao{
	
	@Autowired
	SqlSession sqlSession;
	
	// 댓글 신고 등록
	@Override
	public void cReportInsert(CommentReportDto commentReportDto) {
		sqlSession.insert("report.cReportInsert", commentReportDto);
	}

}
