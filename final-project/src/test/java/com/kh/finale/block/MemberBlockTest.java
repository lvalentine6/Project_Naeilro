package com.kh.finale.block;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.block.MemberBlockDto;
import com.kh.finale.service.block.MemberBlockService;

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
public class MemberBlockTest {

	@Autowired
	private MemberBlockService memberBlockService;
	
	// 정지 테스트
	@Test
	public void block() {
		MemberBlockDto memberBlockDto = MemberBlockDto.builder()
				.memberNo(119)
				.blockPeriod(1)
				.blockContent("차단글 내용")
				.blockReason("차단 이유")
				.build();
		memberBlockService.block(memberBlockDto);
	}
	
	// 정지 해제 테스트
//	@Test
//	public void unblock() {
//		int memberNo = 119;
//		memberBlockService.unblock(memberNo);
//	}
}
