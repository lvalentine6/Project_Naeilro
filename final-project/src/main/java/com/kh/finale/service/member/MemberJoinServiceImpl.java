package com.kh.finale.service.member;

import java.io.File;
import java.io.IOException;

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
	public void memberjoin(MemberVo memberVo) throws IllegalStateException, IOException {
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
							.memberState(memberVo.getMemberState())
							.build();
							memberDao.join(memberDto);
			int memberNo = memberDao.findWithNick(memberVo.getMemberNick()).getMemberNo();
							
							
			if(!memberVo.getMemberProfile().isEmpty()) {
				// 프로필 이미지 경로
				File dir = new File("D:/upload/kh7e/member");
				dir.mkdir();
				
				// 저장 파일명 설정
				String FileName= memberVo.getMemberNo()+"profile";
				File target = new File(dir, FileName);
				memberVo.getMemberProfile().transferTo(target);
				
				// 파일 정보 등록
				MemberProfileDto memberProfileDto = MemberProfileDto.builder()
						.memberId(String.valueOf(memberNo))
						.profileOriginName(memberVo.getMemberProfile().getOriginalFilename())
						.profileSize(memberVo.getMemberProfile().getSize())
						.profileSaveName(FileName)
						.build();
				memberProfileDao.insert(memberProfileDto);
			}
		
		}
}
