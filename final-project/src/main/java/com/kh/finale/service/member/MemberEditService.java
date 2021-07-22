package com.kh.finale.service.member;

import com.kh.finale.vo.member.MemberVo;

public interface MemberEditService {
	void editProfile(MemberVo memberVo);
	void exit(MemberVo memberVo);
	void exitProfile(MemberVo memberVo);
}
