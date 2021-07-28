package com.kh.finale.repository.member;

import java.util.List;

import com.kh.finale.entity.member.FollowDto;
import com.kh.finale.entity.member.MemberDto;

public interface FollowDao {
	void insert(FollowDto followDto);
	void delete(FollowDto followDto);
	FollowDto isFollow(FollowDto followDto);
	int getCountFollower(int memberNo);
	int getCountFollowing(int memberNo);
	
	List<MemberDto> getFollowingList(MemberDto memberDto);
	List<MemberDto> getFollowerList(MemberDto memberDto);
}
