package com.kh.finale.service.block;

import java.text.ParseException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.finale.entity.block.MemberBlockDto;
import com.kh.finale.repository.block.MemberBlockDao;
import com.kh.finale.repository.member.MemberDao;

@Service
public class MemberBlockServiceImpl implements MemberBlockService {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberBlockDao memberBlockDao;
	
	// 회원 정지
	@Override
	@Transactional
	public void block(MemberBlockDto memberBlockDto) throws ParseException {
		memberDao.block(memberBlockDto.getMemberNo());
		memberBlockDao.insertBlockInfo(memberBlockDto);
	}

	// 회원 정지 해제
	@Override
	@Transactional
	public void unblock(int memberNo) {
		memberDao.unblock(memberNo);
		memberBlockDao.deleteBlockInfo(memberNo);
	}
}
