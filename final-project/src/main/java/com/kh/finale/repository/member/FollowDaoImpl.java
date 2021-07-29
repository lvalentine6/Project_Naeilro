package com.kh.finale.repository.member;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.member.FollowDto;
import com.kh.finale.entity.member.MemberDto;

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
	
	//팔로워 리스트
	@Override
	public List<MemberDto> getFollowerList(MemberDto memberDto) {
		return sqlSession.selectList("follow.followerList",memberDto);
	}
	
	//팔로잉 리스트
	@Override
	public List<MemberDto> getFollowingList(MemberDto memberDto) {
		return sqlSession.selectList("follow.followingList",memberDto);
	}
}
