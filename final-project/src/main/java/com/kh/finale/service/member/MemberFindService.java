package com.kh.finale.service.member;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberFindService {
	MemberDto findId(MemberDto memberDto);
	MemberVo findPw(MemberVo memberVo);
}