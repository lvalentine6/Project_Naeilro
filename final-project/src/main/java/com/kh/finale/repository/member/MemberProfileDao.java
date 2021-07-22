package com.kh.finale.repository.member;

import com.kh.finale.entity.member.MemberProfileDto;
import com.kh.finale.vo.member.MemberVo;

public interface MemberProfileDao {
	void insert(MemberProfileDto MemberProfileDto);
	void update(MemberProfileDto MemberProfileDto);
	MemberProfileDto find(String memberId);
	void exitProfile(MemberVo memberVo);
}
