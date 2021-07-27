package com.kh.finale.repository.member;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.member.MemberProfileDto;
import com.kh.finale.vo.member.MemberVo;

@Repository
public class MemberProfileDaoImpl implements MemberProfileDao{
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void insert(MemberProfileDto memberProfileDto) {
		sqlSession.insert("memberProfile.insert", memberProfileDto);	
	}

	@Override
	public void update(MemberProfileDto memberProfileDto) {
		sqlSession.update("memberProfile.update", memberProfileDto);
	}

	@Override
	public MemberProfileDto find(String memberProfileDto) {
		return sqlSession.selectOne("memberProfile.find", memberProfileDto);
	}

	@Override
	public void exitProfile(MemberVo memberVo) {
		sqlSession.delete("memberProfile.exitProfile", memberVo);
	}

}
