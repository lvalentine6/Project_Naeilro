package com.kh.finale.repository.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.vo.report.PageVo;
import com.kh.finale.vo.report.ReportVo;

@Repository
public class CommentReportDaoImpl implements CommentReportDao{
	
	@Autowired
	SqlSession sqlSession;
	
	// 댓글 신고 등록
	@Override
	public void cReportInsert(CommentReportDto commentReportDto) {
		sqlSession.insert("creport.cReportInsert", commentReportDto);
	}
	
	@Override
	public int getCount() {
		return sqlSession.selectOne("creport.count");
	}
	
	@Override
	public int getNCount() {
		return sqlSession.selectOne("creport.ncount");
	}
	@Override
	public int getYCount() {
		return sqlSession.selectOne("creport.ycount");
	}
	
	@Override
	public List<ReportVo> getList(PageVo pageVo) {
		return sqlSession.selectList("creport.list",pageVo);
	}
	@Override
	public List<ReportVo> getNList(PageVo pageVo) {
		return sqlSession.selectList("creport.nlist",pageVo);
	}
	@Override
	public List<ReportVo> getYList(PageVo pageVo) {
		return sqlSession.selectList("creport.ylist",pageVo);
	}
	
	@Override
	public void delete(int reportNo) {
		sqlSession.delete("creport.delete",reportNo);
	}
	
	@Override
	public void confirm(int reportNo) {
		sqlSession.update("creport.confirm",reportNo);
	}
	
	@Override
	public List<ReportVo> getMemberPList(int memberNo) {
		return sqlSession.selectList("creport.memberReportList",memberNo);
	}
}
