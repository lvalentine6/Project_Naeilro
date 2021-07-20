package com.kh.finale.service.member;

import java.io.File;

import javax.mail.SendFailedException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.member.MemberProfileDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.repository.member.MemberProfileDao;
import com.kh.finale.vo.member.MemberVo;
@Service
public class MemberJoinServiceImpl implements MemberJoinService{
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	MemberProfileDao memberProfileDao;
	
	@Override
	public void memberjoin(MemberVo memberVo) {
	try {	
		// 프로필 이미지를 제외한 맴버 정보 등록
		MemberDto memberDto = MemberDto.builder()
							.memberId(memberVo.getMemberId())
							.memberPw(memberVo.getMemberPw())
							.memberNick(memberVo.getMemberNick())
							.memberEmail(memberVo.getMemberEmail())
							.memberName(memberVo.getMemberName())
							.memberBirth(memberVo.getMemberBirth())
							.memberGender(memberVo.getMemberGender())
							.memberGrade(memberVo.getMemberGrade())
							.memberIntro(memberVo.getMemberIntro())
							.build();
							memberDao.join(memberDto);
			
			// 프로필 이미지 경로
			File dir = new File("D:/upload/kh5/member");
			dir.mkdir();
			
			// 저장 파일명 설정
			String FileName= memberVo.getMemberId()+"profile";
			File target = new File(dir, FileName);
				memberVo.getMemberProfile().transferTo(target);
			
		// 파일 정보 등록
		MemberProfileDto memberProfileDto = MemberProfileDto.builder()
											.memberId(memberVo.getMemberId())
											.profileOriginName(memberVo.getMemberProfile().getOriginalFilename())
											.profileSize(memberVo.getMemberProfile().getSize())
											.profileSaveName(FileName)
											.build();
		memberProfileDao.insert(memberProfileDto);
		
		}
	catch (Exception e) {
		e.printStackTrace();
		}
	}
}
