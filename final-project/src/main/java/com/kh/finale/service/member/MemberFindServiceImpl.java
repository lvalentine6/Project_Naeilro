package com.kh.finale.service.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;

@Service
public class MemberFindServiceImpl implements MemberFindService{
	
	@Autowired
	MemberDao memberDao;

	@Override
	public List<MemberDto> findId(MemberDto memberDto) {
		return memberDao.findId(memberDto);
	}

//	@Override
//	public MemberDto findId(MemberVo memberVo) {
//		MemberDto memberDto = MemberDto.builder()
//										.memberName(memberVo.getMemberName())
//										.memberEmail(memberVo.getMemberEmail())
//										.build();
//		memberDao.findId(memberDto);
//		System.out.println(memberDto);
//		return memberDto;
//	}
	
}
