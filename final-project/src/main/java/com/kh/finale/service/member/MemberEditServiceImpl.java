package com.kh.finale.service.member;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.member.MemberProfileDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.repository.member.MemberProfileDao;
import com.kh.finale.vo.member.MemberVo;

@Service
public class MemberEditServiceImpl implements MemberEditService{

	@Autowired
	MemberDao memberDao;
	
	@Autowired
	MemberProfileDao memberProfileDao;
	
	@Override
	public void editProfile(MemberVo memberVo) throws IllegalStateException, IOException {
		// 회원 이미지 수정
		
		if(!memberVo.getMemberProfile().isEmpty()) {
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
		
		// 기존 프로필 이미지의 존재 유무 확인
		MemberProfileDto find = memberProfileDao.find(memberVo.getMemberId());
		
		// 기존 프로필 이미지가 존재하면 업데이트, 아니면 등록
		if (find != null) {
			memberProfileDao.update(memberProfileDto);
		} else {
			memberProfileDao.insert(memberProfileDto);
		}
		
		System.out.println("수정 DB 값 확인" + memberProfileDto);
		}
		
		// 이미지를 제외한 회원정보 수정
		memberDao.editProfile(memberVo);
		System.out.println("이미지 제외 회원정보 변경완료");
	
	}
	
	
	// 회원 탈퇴
	@Override
	public void exit(MemberVo memberVo) {
		memberDao.exit(memberVo);
	}

	// 회원 탈퇴 프로필 삭제
	@Override
	public void exitProfile(MemberVo memberVo) {
		memberProfileDao.exitProfile(memberVo);
	}
}
