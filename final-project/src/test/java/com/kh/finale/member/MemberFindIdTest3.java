package com.kh.finale.member;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class MemberFindIdTest3 {
	
	@Autowired
	MemberDao memberDao;
	
	@Test
	public void testFindId() {
		MemberDto memberDto1 = MemberDto.builder()
				 .memberEmail("admin@admin.com")
				 .memberName("관리자")
				 .build();
		
				 memberDao.findId(memberDto1);
	}
}
