package com.kh.finale.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.member.FollowDto;

@Repository
public class FollowDaoImpl implements FollowDao{
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(FollowDto followDto) {
		sqlSession.insert("follow.insert",followDto);
	}
	
	@Override
	public void delete(FollowDto followDto) {
		sqlSession.insert("follow.delete",followDto);
		
	}
	@Override
	public FollowDto isFollow(FollowDto followDto) {
		return sqlSession.selectOne("follow.selectOne",followDto);
	}
	
	@Override
	public int getCountFollower(int memberNo) {
		return sqlSession.selectOne("follow.countFollower",memberNo);
	}
	
	@Override
	public int getCountFollowing(int memberNo) {
		return sqlSession.selectOne("follow.countFollowing",memberNo);
	}
}
