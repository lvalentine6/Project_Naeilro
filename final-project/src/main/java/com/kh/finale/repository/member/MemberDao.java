package com.kh.finale.repository.member;

import java.util.Map;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberDao {
	void join(MemberDto memberDto);
	MemberDto login(MemberDto memberDto);
	// 회원정보 조회(프로필 편집)
	MemberDto findInfo(int memberNo);
	MemberDto findId(MemberDto memberDto);
	MemberVo findPw(MemberVo memberVo);
	void authInsert(MemberAuthDto memberAuthDto);
	Map<String,Object> resultAuth(MemberAuthDto memberAuthDto);
	MemberAuthDto checkAuthEmail(MemberAuthDto memberAuthDto);
	MemberAuthDto selectId (MemberAuthDto memberAuthDto);
	void updatePw(MemberDto memberDto);
	void editProfile(MemberVo memberVo);
	int idCheck(MemberVo memberVo);
	int nickCheck(MemberVo memberVo);
	void exit(MemberVo memberVo);
}
