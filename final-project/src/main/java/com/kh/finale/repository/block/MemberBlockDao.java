package com.kh.finale.repository.block;

import com.kh.finale.entity.block.MemberBlockDto;

public interface MemberBlockDao {
	// 회원 정지 정보 등록 기능
	void insertBlockInfo(MemberBlockDto memberBlockDto);

	// 회원 정지 정보 삭제 기능
	void deleteBlockInfo(int memberNo);
	
	// 정지 정보 조회 기능
	MemberBlockDto getBlockInfo(int memberNo);
	
	// 정지 해제 체크 기능
	boolean checkBlock(int memberNo) throws Exception;
}
