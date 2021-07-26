package com.kh.finale.block;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.block.MemberBlockDto;
import com.kh.finale.repository.block.MemberBlockDao;
import com.kh.finale.service.block.MemberBlockService;
import com.kh.finale.util.DateUtils;

import lombok.extern.slf4j.Slf4j;

/**
 * 회원 정지 관련 테스트
 * @author swjk78
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Slf4j
public class MemberBlockTest {

	@Autowired
	private MemberBlockDao memberBlockDao;
	
	@Autowired
	private MemberBlockService memberBlockService;
	
	// 정지 테스트
	@Test
	public void block() throws ParseException {
		MemberBlockDto memberBlockDto = MemberBlockDto.builder()
				.memberNo(119)
				.blockPeriod(1)
				.blockContent("차단글 내용")
				.blockReason("차단 이유")
				.build();
		memberBlockService.block(memberBlockDto);
		log.debug("blockStartDate = {}", memberBlockDto.getBlockStartDate());
		memberBlockDto = memberBlockDao.getBlockInfo(memberBlockDto.getMemberNo());
		log.debug("blockStartDate = {}", memberBlockDto.getBlockStartDate());
		
		// 정지 해제 날짜 설정
		java.sql.Date blockEndDate = DateUtils.formatToSqlDate(DateUtils.plusDayToDate(memberBlockDto.getBlockStartDate(), memberBlockDto.getBlockPeriod()));
		memberBlockDto.setBlockEndDate(blockEndDate);
		log.debug("blockEndDate = {}", memberBlockDto.getBlockEndDate());
	}
	
	// 정지 해제 테스트
//	@Test
//	public void unblock() {
//		int memberNo = 119;
//		memberBlockService.unblock(memberNo);
//	}
}
