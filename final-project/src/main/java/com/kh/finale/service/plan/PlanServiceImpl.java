package com.kh.finale.service.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlaceDao;
import com.kh.finale.repository.plan.PlannerDao;
import com.kh.finale.repository.plan.ResultPlanDao;
import com.kh.finale.vo.plan.PlanInsertServiceSubVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PlanServiceImpl implements PlanService {
	
	@Autowired
	private PlannerDao plannerDao;
	
	@Autowired
	private DailyDao dailyDao;
	
	@Autowired
	private PlaceDao placeDao;
	
	@Autowired
	private DailyplanDao dailyplanDao;
	
	@Autowired
	private ResultPlanDao resultPlanDao;
	
	@Override
	public int planInsertService(PlanInsertServiceVO planInsertServiceVO) {
		
		// # 순서
		// 1. 통합계획표 등록 -> 2. 공유그룹 등록 -> 3. 하루계획표 등록 -> 4. 장소 등록 -> 5. 장소 계획 등록
		
		// 번호표
		int plannerNo = plannerDao.getSequnece();
		
		
		// 1. 통합계획표 등록 & 2. 공유그룹 등록
		if(planInsertServiceVO.getPlannerName() != null && planInsertServiceVO.getPlannerStartDate() != null && planInsertServiceVO.getPlannerEndDate() != null) {
			// 통합계획표 번호 세팅
			planInsertServiceVO.setPlannerNo(plannerNo);
			
			// SQL 실행
			plannerDao.plannerInsert(planInsertServiceVO);
		}
		
		// 3. 하루계획표 등록 & 4. 장소 등록 & 5. 장소계획 등록
		
		// 하루계획표 번호를 발급받고 하루계획표 등록
		
		// 발급받은 하루계획표 번호를 장소계획 번호에 등록
		
		// 장소 등록
		
		// 장소계획 번호를 하루계획 번호에 등록
		
		// 장소계획 등록
		for(List<PlanInsertServiceSubVO> planList : planInsertServiceVO.getPlanList()) {
			for(PlanInsertServiceSubVO plan : planList) {
				// 번호 세팅
				int placeNo = placeDao.getSequence();
				int dailyNo = 0;
				
				if(plan.getDailyStayDate() != 0 || plan.getDailyOrder() != 0) { // 데이터가 0 0 이 같이 들어오고 있음
					dailyNo = dailyDao.getSequence();
					
					planInsertServiceVO.setDailyNo(dailyNo);
					planInsertServiceVO.setPlannerNo(plannerNo);
					planInsertServiceVO.setDailyStayDate(plan.getDailyStayDate());
					planInsertServiceVO.setDailyOrder(plan.getDailyOrder());
					
					dailyDao.dailyInsert(planInsertServiceVO);
				}
				
				// 장소
				planInsertServiceVO.setPlaceNo(placeNo);
				planInsertServiceVO.setPlaceLatitude(plan.getPlaceLatitude());
				planInsertServiceVO.setPlaceLongitude(plan.getPlaceLongitude());
				planInsertServiceVO.setPlaceName(plan.getPlaceName());
				planInsertServiceVO.setPlaceType(plan.getPlaceType());
				
				if(planInsertServiceVO.getPlaceLatitude() != null || planInsertServiceVO.getPlaceLongitude() != null) {
					placeDao.placeInsert(planInsertServiceVO);
				}
				
				// 장소계획
				// 문제 : 하루계획 번호가 들어가지 않는다는 게 문제
				// 해결 : 하루계획 번호를 검사한 후, 제어하기
				
				
				planInsertServiceVO.setDailyplanPlaceOrder(plan.getDailyplanPlaceOrder());
				planInsertServiceVO.setDailyplanTransfer(plan.getDailyplanTransfer());
				
				// 확인
				log.info("하루계획 번호 : " + planInsertServiceVO.getDailyNo());
				log.info("장소 번호 : " + planInsertServiceVO.getPlaceNo());
				log.info("장소순서 : " + planInsertServiceVO.getDailyplanPlaceOrder());
				log.info("교통수단 : " + planInsertServiceVO.getDailyplanTransfer());
				log.info("문제 데이터 : " + plan.getDailyStayDate()); // 확인 : 2번째 인덱스부터 인식을 못하는 것 같다(..) -> 근데 해결은 됐는데 왜 됐는지 모르겠다 (...)
				
				if(planInsertServiceVO.getDailyplanTransfer() != null) {
					dailyplanDao.dailyplanInsert(planInsertServiceVO);
				}
				
			}
		}
		return plannerNo;
	}
	// 결과페이지 DB 조회
	@Override
	public List<ResultPlanVO> selectPlan(ResultPlanVO resultPlanVO) {
		return resultPlanDao.selectPlan(resultPlanVO);
	}
	
}
