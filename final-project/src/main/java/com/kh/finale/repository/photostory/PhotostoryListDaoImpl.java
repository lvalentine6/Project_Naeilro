package com.kh.finale.repository.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.vo.photostory.PhotostoryListVO;

@Repository
public class PhotostoryListDaoImpl implements PhotostoryListDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 포토스토리 리스트 조회 기능
	@Override
	public List<PhotostoryListDto> list(PhotostoryListVO photostoryListVO) {
		return sqlSession.selectList("photostoryList.list", photostoryListVO);
	}
	
	// 포토스토리 리스트 조회 기능
	@Override
	public List<PhotostoryListDto> planList(int plannerNo) {
		return sqlSession.selectList("photostoryList.planList", plannerNo);
	}
	
	// 포토스토리 단일 조회 기능
	@Override
	public PhotostoryListDto get(int photostoryNo) {
		return sqlSession.selectOne("photostoryList.get", photostoryNo);
	}
	
	@Override
	public List<PhotostoryListDto> listWhitMemberNo(PhotostoryListVO photostoryListVO) {
		return sqlSession.selectList("photostoryList.listWithMemberNo", photostoryListVO);
	}
	
	@Override
	public PhotostoryListDto getReportStory(int reportNo) {
		return sqlSession.selectOne("photostoryList.getReportStort", reportNo);
	}
}
