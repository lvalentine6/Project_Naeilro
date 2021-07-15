package com.kh.finale.repository.member;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberDao {
	void join(MemberDto memberDto);
	MemberDto login(MemberDto memberDto);
	MemberDto findId(MemberDto memberDto);
	MemberVo findPw(MemberVo memberVo);
	void authInsert(MemberAuthDto memberAuthDto);
	MemberAuthDto resultAuth(MemberAuthDto memberAuthDto);
}
