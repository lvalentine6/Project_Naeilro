package com.kh.finale.report;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.entity.report.PhotostoryReportDto;
import com.kh.finale.service.report.PhotostoryReportService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class PhotostoryReportTest {
	
	@Autowired
	SqlSession sqlsession;
	
	@Autowired
	PhotostoryReportService photostoryReportService;
	
	// 포토스토리 신고 DB저장
	@Test
	public void pReportInsert() {
		/*
		 * PhotostoryReportDto photostoryReportDto = PhotostoryReportDto.builder()
		 * .memberNo(112) .ReportNo(16) .pReportReason("부적절한 게시글") .build();
		 * photostoryReportService.pReportInsert(photostoryReportDto);
		 */
	}
}
