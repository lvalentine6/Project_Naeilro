package com.kh.finale.vo.member;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class MemberVo {
	private int memberNo;
	private String memberId;
	private String memberPw;
	private String memberNick;
	private String memberEmail;
	private String memberName;
	private String memberBirth;
	private String memberGender;
	private String memberProfilePath;
	private int memberGrade;
	private MultipartFile memberProfile;
}
