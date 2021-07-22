package com.kh.finale.plan;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlaceDao;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class PlanInsertServiceTest {
	
	@Autowired
	private PlaceDao placeDao;
	
	@Autowired
	private DailyDao dailyDao;
	
	@Autowired
	private DailyplanDao dailyplanDao;
	
	@Test
	public void test() {
		PlanInsertServiceVO planInsertServiceVO = PlanInsertServiceVO.builder()
																														.plannerNo(190)
																														.dailyStayDate(1)
																														.dailyOrder(1)
																														.dailyplanPlaceOrder(1)
																														.dailyplanTransfer("항공")
																														.placeLatitude("33.37830925245249")
																														.placeLongitude("126.251182712647")
																														.placeName("제주도")
																														.placeType("호텔")
																														.build();
		
		if(dailyDao.dailyOrderConfirm(planInsertServiceVO) == null) {
			dailyDao.dailyInsert(planInsertServiceVO); 
		}  else {
			int dailyNo = dailyDao.dailyNoConfirm(planInsertServiceVO);
			planInsertServiceVO.setDailyNo(dailyNo);
		}
		
		// 3. 장소 등록
		placeDao.placeInsert(planInsertServiceVO); 
		
		// 4. 장소계획 등록
		dailyplanDao.dailyplanInsert(planInsertServiceVO);
	}
	
}
