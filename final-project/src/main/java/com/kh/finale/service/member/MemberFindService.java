package com.kh.finale.service.member;

import java.util.List;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberFindService {
	List<MemberDto> findId(MemberDto memberDto);
}