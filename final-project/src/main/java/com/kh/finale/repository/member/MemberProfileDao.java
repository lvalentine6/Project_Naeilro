package com.kh.finale.repository.member;

import com.kh.finale.entity.member.MemberProfileDto;

public interface MemberProfileDao {
	void insert(MemberProfileDto MemberProfileDto);
	void update(MemberProfileDto MemberProfileDto);
	MemberProfileDto find(String memberId);
}
