package com.kh.finale.plan;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.repository.plan.PlannerDao;
import com.kh.finale.vo.plan.ResultPlanVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class ResultPlannerTest {
	
	@Autowired
	SqlSession sqlSession;
	
	@Autowired
	PlannerDao plannerDao;
	
//	@Test
//	public void test() {
//		
//		ResultPlanVO resultPlanVO = ResultPlanVO.builder()
//									.plannerNo(29)
//									.memberNo(8)
//									.build();
//		plannerDao.selectPlan(resultPlanVO);
//		System.out.println(plannerDao.selectPlan(resultPlanVO));
//	}
	
}
