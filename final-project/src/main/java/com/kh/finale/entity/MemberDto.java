package com.kh.finale.entity;

import javax.xml.ws.BindingType;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class MemberDto {
	private int memberNo;
	private String memberId;
	private String memberPw;
	private String memberNick;
	private String memberEmail;
	private String membername;
	private String memberBirth;
	private String memberGender;
	private String memberProfilePath;
	private int memberGrade;
	
}
