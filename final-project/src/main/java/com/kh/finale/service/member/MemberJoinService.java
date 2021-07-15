package com.kh.finale.service.member;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberJoinService {
	
	// 회원가입 처리
	void memberjoin(MemberVo memberVo);
}
