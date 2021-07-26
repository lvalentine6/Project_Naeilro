package com.kh.finale.service.block;

import java.text.ParseException;

import com.kh.finale.entity.block.MemberBlockDto;

public interface MemberBlockService {
	// 회원 정지
	public void block(MemberBlockDto memberBlockDto) throws ParseException;
	
	// 회원 정지 해제
	public void unblock(int memberNo);
}
