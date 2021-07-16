package com.kh.finale.service.member;

import java.util.Map;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberAuthService {
	MemberAuthDto pwSendEmail(MemberVo memberVo);
	void authInsert(MemberAuthDto memberAuthDto);
	Map<String,Object> resultAuth(MemberAuthDto memberAuthDto);
	MemberAuthDto selectId(MemberAuthDto memberAuthDto);
}
