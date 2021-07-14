package com.kh.finale.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;

@Service
public class MemberFindService {
	
	@Autowired
	MemberDao memberDao;
	
	public MemberDto findId(MemberDto memberDto) {
		MemberDto.builder()
				 .memberId(memberDto.getMemberName())
				 .memberEmail(memberDto.getMemberEmail())
				 .memberName(memberDto.getMemberName())
				 .build();
		
				 memberDao.findId(memberDto);
		return memberDto;
	}
	
	
}
