package com.kh.finale.service.member;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;

@Service
public class MemberFindService implements MemberFindServiceImpl{
	
	@Autowired
	MemberDao memberDao;

	@Override
	public MemberDto findId(MemberDto memberDto) {
		MemberDto memberDto1= MemberDto.builder()
									.memberName(memberDto.getMemberName())
									.memberEmail(memberDto.getMemberEmail())
									.build();
						memberDao.findId(memberDto1);
						System.out.println(memberDto1);
		return memberDto1;
	}
	
}
