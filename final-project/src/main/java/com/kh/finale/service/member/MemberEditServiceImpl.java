package com.kh.finale.service.member;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;

public class MemberEditServiceImpl implements MemberEditService{

	@Autowired
	MemberDao memberDao;
	
	@Override
	public void editProfile(MemberDto memberDto) {
		memberDao.editProfile(memberDto);
	}
}
