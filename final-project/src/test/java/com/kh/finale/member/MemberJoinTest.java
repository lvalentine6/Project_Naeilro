package com.kh.finale.member;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.repository.member.MemberDao;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class MemberJoinTest {
	
	@Autowired
	MemberDao memberDao;
	
	@Test
	public void join() {
		memberDao.join(MemberDto.builder()
								.memberId("test4")
								.memberPw("qwer100")
								.memberNick("테스트계정4")
								.memberEmail("test4@naver.com")
								.memberName("테스트이름4")
								.memberBirth("1990-01-01")
								.memberGender("여")
								.memberProfilePath("D:upload")
								.memberGrade(2)
								.build());
	}
}
