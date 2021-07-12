package com.kh.finale.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.MemberDto;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	SqlSession sqlSession;
	
	@Override
	public void join(MemberDto memberDto) {
		sqlSession.insert("member.join", memberDto);
	}

}
