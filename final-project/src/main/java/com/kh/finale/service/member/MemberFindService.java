package com.kh.finale.service.member;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberFindService {
	MemberDto findId(MemberDto memberDto);
	MemberVo findPw(MemberVo memberVo);
	MemberAuthDto checkAuthEmail(MemberAuthDto memberAuthDto);
	int idCheck(MemberVo memberVo);
	MemberVo nickCheck(MemberVo memberVo);
}