package com.kh.finale.report;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.service.report.CommentReportService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class CommentReportTest {

	@Autowired
	SqlSession sqlsession;
	
	@Autowired
	CommentReportService commentReportService;
	
	// 댓글 신고 DB저장
	@Test
	public void cReportInsert() {
		CommentReportDto commentReportDto = CommentReportDto.builder()
									.memberNo(112)
									.cReportNo(2)
									.cReportReason("부적절한 댓글2")
									.build();
		commentReportService.cReportInsert(commentReportDto);
	}
}
