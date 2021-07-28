package com.kh.finale.repository.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.photostory.PhotostoryLikeDto;

@Repository
public class PhotostoryLikeDaoImpl implements PhotostoryLikeDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 좋아요 등록 기능
	@Override
	public void insertPhotostoryLike(PhotostoryLikeDto photostoryLikeDto) {
		sqlSession.insert("photostoryLike.insert", photostoryLikeDto);
	}

	// 좋아요 삭제 기능
	@Override
	public void deletePhotostoryLike(PhotostoryLikeDto photostoryLikeDto) {
		sqlSession.delete("photostoryLike.delete", photostoryLikeDto);
	}

	// 좋아요 확인 기능
	@Override
	public Boolean checkPhotostoryLike(PhotostoryLikeDto photostoryLikeDto) {
		return sqlSession.selectOne("photostoryLike.check", photostoryLikeDto);
	}
	
	@Override
	public List<MemberDto> getLikeList(int photostoryNo) {
		return sqlSession.selectList("photostoryLike.memberList", photostoryNo);
	}
}
