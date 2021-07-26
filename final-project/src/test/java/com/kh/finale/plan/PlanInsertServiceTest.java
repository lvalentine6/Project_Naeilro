package com.kh.finale.plan;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kh.finale.vo.plan.TestVO;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
public class PlanInsertServiceTest {
	
	@Test
	public void test() {
		
		TestVO entity1 = TestVO.builder().dailyOrder(1).dailyplanPlaceOrder(1).placeName("테스트1").build(); 
		TestVO entity2 = TestVO.builder().dailyOrder(1).dailyplanPlaceOrder(2).placeName("테스트2").build(); 
		TestVO entity3 = TestVO.builder().dailyOrder(2).dailyplanPlaceOrder(1).placeName("테스트3").build(); 
		TestVO entity4 = TestVO.builder().dailyOrder(2).dailyplanPlaceOrder(2).placeName("테스트4").build(); 
		
		List<TestVO> data1 = new ArrayList<TestVO>();
		data1.add(entity1);
		data1.add(entity2);
		
		for(TestVO test : data1) {
			System.out.println("하루 순서 : " + test.getDailyOrder());
			System.out.println("장소 순서 : " + test.getDailyplanPlaceOrder());
		}
		
		System.out.println("=====");
		
		List<TestVO> data2 = new ArrayList<TestVO>();
		data2.add(entity3);
		data2.add(entity4);
		
		for(TestVO test : data2) {
			System.out.println("하루 순서 : " + test.getDailyOrder());
			System.out.println("장소 순서 : " + test.getDailyplanPlaceOrder());
		}
		
		List<List<TestVO>> datas = new ArrayList<List<TestVO>>();
		datas.add(data1);
		datas.add(data2);
		
		System.out.println("=====");
		
		for(List<TestVO> data : datas) {
			for(TestVO test : data) {
				System.out.println(test);
				System.out.println(test.getDailyOrder() + "일 차의 장소 순서 : " + test.getDailyplanPlaceOrder() + ", 장소 이름 : " + test.getPlaceName());
			}
		}
	}
	
}
