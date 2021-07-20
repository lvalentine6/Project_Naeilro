package com.kh.finale.repository.member;

import com.kh.finale.entity.member.FollowDto;

public interface FollowDao {
	void insert(FollowDto followDto);
	void delete(FollowDto followDto);
	FollowDto isFollow(FollowDto followDto);
	int getCountFollower(int memberNo);
	int getCountFollowing(int memberNo);
}
