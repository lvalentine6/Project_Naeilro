package com.kh.finale.repository.member;

import java.util.List;
import java.util.Map;

import com.kh.finale.entity.member.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	MemberDto login(MemberDto memberDto);
	List<MemberDto> findId(MemberDto memberDto);
}
