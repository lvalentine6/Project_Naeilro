package com.kh.finale.member;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.member.MemberProfileDto;
import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.repository.member.MemberProfileDao;
import com.kh.finale.vo.member.MemberVo;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class MemberJoinTest2 {
	
	@Autowired
	MemberDao memberDao;
	
	@Autowired
	MemberVo memberVo;
	
	@Autowired
	MemberProfileDao memberProfileDao;
	
	@Test
	public void join2() {
		MemberProfileDto memberProfileDto = MemberProfileDto.builder()
				.memberId("테스트")
				.profileOriginName("테스트오리지널")
				.profileSize(1234)
				.profileSaveName("1")
				.build();
		memberProfileDao.insert(memberProfileDto);
	}
}
