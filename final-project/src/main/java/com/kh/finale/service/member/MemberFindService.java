package com.kh.finale.service.member;

import java.util.Map;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberFindService {
	MemberDto findId(MemberDto memberDto);
	MemberVo findPw(MemberVo memberVo);
	Map<String,Object> checkAuthEmail(MemberAuthDto memberAuthDto);
}