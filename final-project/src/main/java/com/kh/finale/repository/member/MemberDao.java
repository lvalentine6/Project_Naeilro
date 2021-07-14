package com.kh.finale.repository.member;

import com.kh.finale.entity.member.MemberDto;

public interface MemberDao {
	void join(MemberDto memberDto);
	MemberDto login(MemberDto memberDto);
	MemberDto findId(MemberDto memberDto);
}
