package com.kh.finale.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.vo.member.MemberVo;

@Service
public class MemberFindServiceImpl implements MemberFindService{
	
	@Autowired
	MemberDao memberDao;
	
	// 아이디 찾기
	@Override
	public MemberDto findId(MemberDto memberDto) {
		return memberDao.findId(memberDto);
	}
	
	// 비밀번호 찾기
	@Override
	public MemberVo findPw(MemberVo memberVo) {
		return memberDao.findPw(memberVo);
	}
	
}
