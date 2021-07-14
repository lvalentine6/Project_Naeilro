package com.kh.finale.repository.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryCommentListDto;

@Repository
public class PhotostoryCommentListDaoImpl implements PhotostoryCommentListDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<PhotostoryCommentListDto> list(int photostoryNo) {
		return sqlSession.selectList("photostoryCommentList.list", photostoryNo);
	}
}
