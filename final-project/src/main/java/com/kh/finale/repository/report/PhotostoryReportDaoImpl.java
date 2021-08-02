package com.kh.finale.repository.report;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.report.PhotostoryReportDto;
import com.kh.finale.vo.report.PageVo;
import com.kh.finale.vo.report.ReportVo;

@Repository
public class PhotostoryReportDaoImpl implements PhotostoryReportDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void pReportInsert(PhotostoryReportDto photostoryReportDto) {
		sqlSession.insert("preport.pReportInsert", photostoryReportDto);
	}
	
	@Override
	public int getCount() {
		return sqlSession.selectOne("preport.count");
	}
	@Override
	public int getNCount() {
		return sqlSession.selectOne("preport.ncount");
	}
	@Override
	public int getYCount() {
		return sqlSession.selectOne("preport.ycount");
	}
	
	@Override
	public List<ReportVo> getList(PageVo pageVo) {
		return sqlSession.selectList("preport.list",pageVo);
	}
	@Override
	public List<ReportVo> getNList(PageVo pageVo) {
		return sqlSession.selectList("preport.nlist",pageVo);
	}
	@Override
	public List<ReportVo> getYList(PageVo pageVo) {
		return sqlSession.selectList("preport.ylist",pageVo);
	}
	
	@Override
	public void delete(int reportNo) {
		sqlSession.delete("preport.delete",reportNo);
	}
	
	@Override
	public void confirm(int reportNo) {
		sqlSession.update("preport.confirm",reportNo);
	}
	
	@Override
	public List<ReportVo> getMemberPList(int memberNo) {
		return sqlSession.selectList("preport.memberReportList",memberNo);
	}
}
