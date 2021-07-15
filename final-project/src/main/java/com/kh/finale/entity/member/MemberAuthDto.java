package com.kh.finale.entity.member;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MemberAuthDto {
	private int authId;
	private int memberNo;
	private int authNo;
	private String authEmail;
	private Date authTime;
	private String authType;
	
}
