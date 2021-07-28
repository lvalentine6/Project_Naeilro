package com.kh.finale.vo.member;

import com.kh.finale.entity.member.MemberDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class LikeFollowVo {
	private MemberDto member;
	private boolean isFollow; 
}
