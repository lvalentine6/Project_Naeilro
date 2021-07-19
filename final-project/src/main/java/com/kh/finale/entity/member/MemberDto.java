package com.kh.finale.entity.member;

// import javax.xml.ws.BindingType;

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
	private String memberName;
	private String memberBirth;
	private String memberGender;
	private int memberGrade;
	private String memberIntro;
}
