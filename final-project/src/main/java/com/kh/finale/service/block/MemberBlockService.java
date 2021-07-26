package com.kh.finale.service.block;

import com.kh.finale.entity.block.MemberBlockDto;

public interface MemberBlockService {
	// 회원 정지
	public void block(MemberBlockDto memberBlockDto);
	
	// 회원 정지 해제
	public void unblock(int memberNo);
}
