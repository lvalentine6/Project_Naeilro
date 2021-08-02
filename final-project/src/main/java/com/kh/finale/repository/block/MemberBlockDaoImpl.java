package com.kh.finale.repository.block;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.block.MemberBlockDto;
import com.kh.finale.util.DateUtils;

@Repository
public class MemberBlockDaoImpl implements MemberBlockDao {

	@Autowired
	private SqlSession sqlSession;
	
	
	// 회원 정지 정보 등록 기능
	@Override
	public void insertBlockInfo(MemberBlockDto memberBlockDto) throws ParseException {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
		String currentTime = simpleDateformat.format(System.currentTimeMillis());
		java.sql.Date sysdate = DateUtils.formatToSqlDate(simpleDateformat.parse(currentTime));
		
		// 정지 해제 날짜 계산 및 설정
		java.sql.Date blockEndDate = DateUtils.formatToSqlDate(
				DateUtils.plusDayToDate(sysdate, memberBlockDto.getBlockPeriod())
		);
		memberBlockDto.setBlockStartDate(sysdate);
		memberBlockDto.setBlockEndDate(blockEndDate);
		
		sqlSession.insert("memberBlock.insert", memberBlockDto);
	}

	// 회원 정지 정보 삭제 기능
	@Override
	public void deleteBlockInfo(int memberNo) {
		sqlSession.delete("memberBlock.delete", memberNo);
	}

	// 정지 정보 조회 기능
	@Override
	public MemberBlockDto getBlockInfo(int memberNo) {
		return sqlSession.selectOne("memberBlock.select", memberNo);
	}
	
	// 정지 해제 체크 기능
	// - 정지 해제 날짜가 지났으면 true 반환
	@Override
	public boolean checkBlock(int memberNo) throws Exception {
		// 회원 정지 정보 및 정지 해제 날짜 조회
		MemberBlockDto memberBlockDto = getBlockInfo(memberNo);
		
		// 정지 해제 날짜 계산
		Date blockEndDate = memberBlockDto.getBlockEndDate();
		return DateUtils.compareWithSysdate(blockEndDate);
	}
}
