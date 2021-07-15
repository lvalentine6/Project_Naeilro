package com.kh.finale.service.member;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberAuthService {
	MemberAuthDto pwSendEmail(MemberVo memberVo);
	void authInsert(MemberAuthDto memberAuthDto);
}
