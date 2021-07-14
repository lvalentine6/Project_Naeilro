package com.kh.finale.repository.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.util.ListParameter;

public class PhotostoryListDaoImpl implements PhotostoryListDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 포토스토리 리스트 조회 기능
	@Override
	public List<PhotostoryListDto> list(ListParameter listParameter) {
		return sqlSession.selectList("photostory.list", listParameter);
	}
	
	// 포토스토리 상세 조회 기능
	@Override
	public PhotostoryListDto find(int photostoryNo) {
		return sqlSession.selectOne("photostoryList.find", photostoryNo);
	}
}
