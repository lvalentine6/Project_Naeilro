package com.kh.finale.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.member.MemberProfileDto;

@Repository
public class MemberProfileImpl implements MemberProfileDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(MemberProfileDto memberProfileDto) {
		sqlSession.insert("memberProfile.insert", memberProfileDto);	
	}

}
