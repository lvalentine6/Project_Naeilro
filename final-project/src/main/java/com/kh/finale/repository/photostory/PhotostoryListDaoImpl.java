package com.kh.finale.repository.photostory;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryListDto;

@Repository
public class PhotostoryListDaoImpl implements PhotostoryListDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 포토스토리 상세 조회 기능
	@Override
	public PhotostoryListDto find(int photostoryNo) {
		return sqlSession.selectOne("photostoryList.find", photostoryNo);
	}
}
