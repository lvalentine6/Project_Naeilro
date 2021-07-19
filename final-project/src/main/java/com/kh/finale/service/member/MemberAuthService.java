package com.kh.finale.service.member;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.mail.MessagingException;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberAuthService {
	MemberAuthDto pwSendEmail(MemberVo memberVo) throws MessagingException, UnsupportedEncodingException;
	void authInsert(MemberAuthDto memberAuthDto);
	Map<String,Object> resultAuth(MemberAuthDto memberAuthDto);
	MemberAuthDto selectId(MemberAuthDto memberAuthDto);
	void updatePw(MemberDto memberDto);
}
