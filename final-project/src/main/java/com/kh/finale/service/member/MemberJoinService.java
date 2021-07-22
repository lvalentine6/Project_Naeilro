package com.kh.finale.service.member;

import java.io.IOException;

import com.kh.finale.vo.member.MemberVo;

public interface MemberJoinService {
	
	// 회원가입 처리
	void memberjoin(MemberVo memberVo) throws IllegalStateException, IOException; 
}
