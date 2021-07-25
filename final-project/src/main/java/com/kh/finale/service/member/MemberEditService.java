package com.kh.finale.service.member;

import java.io.IOException;

import com.kh.finale.vo.member.MemberVo;

public interface MemberEditService {
	void editProfile(MemberVo memberVo) throws IllegalStateException, IOException;
	void exit(MemberVo memberVo);
	void exitProfile(MemberVo memberVo);
}
