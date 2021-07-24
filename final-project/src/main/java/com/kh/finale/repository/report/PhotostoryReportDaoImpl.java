package com.kh.finale.repository.report;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.report.PhotostoryReportDto;

@Repository
public class PhotostoryReportDaoImpl implements PhotostoryReportDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void pReportInsert(PhotostoryReportDto photostoryReportDto) {
		sqlSession.insert("report.pReportInsert", photostoryReportDto);
	}

}
