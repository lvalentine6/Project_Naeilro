package com.kh.finale.plan;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.service.plan.PlannerService;
import com.kh.finale.vo.plan.PlannerInsertVO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class PlannerInsertServiceTest {
	
	@Autowired
	private PlannerService plannerService;
	
	@Test
	public void test() {
		PlannerInsertVO plannerInsertVO = PlannerInsertVO.builder()
																										.plannerName("서비스")
																										.plannerStartDate("2021/09/01")
																										.plannerEndDate("2021/09/02")
																										.memberNo(45)
																									.build();
		
		plannerService.plannerInsertService(plannerInsertVO);
		
	}
	
}
