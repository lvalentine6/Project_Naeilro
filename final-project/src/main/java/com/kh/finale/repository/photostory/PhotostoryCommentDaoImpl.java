package com.kh.finale.repository.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryCommentDto;

@Repository
public class PhotostoryCommentDaoImpl implements PhotostoryCommentDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 댓글 등록 기능
	@Override
	public void insertPhotostoryComment(PhotostoryCommentDto photostoryCommentDto) {
		sqlSession.insert("photostoryComment.insert", photostoryCommentDto);
	}

	// 댓글 수정 기능
	@Override
	public void updatePhotostoryComment(PhotostoryCommentDto photostoryCommentDto) {
		sqlSession.update("photostoryComment.update", photostoryCommentDto);
	}

	// 댓글 삭제 기능
	@Override
	public void deletePhotostoryComment(PhotostoryCommentDto photostoryCommentDto) {
		sqlSession.delete("photostoryComment.delete", photostoryCommentDto);
	}

	// 댓글 조회 기능
	@Override
	public List<PhotostoryCommentDto> list(int photostoryNo) {
		return sqlSession.selectList("photostoryComment.list", photostoryNo);
	}
}
