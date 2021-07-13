package com.kh.finale.entity.member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MemberProfileDto {
	private String profileNo;
	private String memberId;
	private String profileOriginName;
	private long profileSize;
	private String profileSaveName;
}
