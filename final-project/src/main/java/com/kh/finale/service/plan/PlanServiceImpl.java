package com.kh.finale.service.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.GroupsDao;
import com.kh.finale.repository.plan.PlaceDao;
import com.kh.finale.repository.plan.PlannerDao;
import com.kh.finale.vo.plan.PlanInsertServiceSubVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;

@Service
public class PlanServiceImpl implements PlanService {
	
	@Autowired
	private PlannerDao plannerDao;
	
	@Autowired
	private GroupsDao groupsDao;
	
	@Autowired
	private DailyDao dailyDao;
	
	@Autowired
	private PlaceDao placeDao;
	
	@Autowired
	private DailyplanDao dailyplanDao;
	
	@Override
	public void planInsertService(PlanInsertServiceVO planInsertServiceVO) {
		
		// # 순서
		// 1. 통합계획표 등록 -> 2. 공유그룹 등록 -> 3. 하루계획표 등록 -> 4. 장소 등록 -> 5. 장소 계획 등록
		
		// # 번호표
		int plannerNo = plannerDao.getSequnece();
		int dailyNo = 0;
		int dailyplanNo = 0;
		
		// 1. 통합계획표 등록 & 2. 공유그룹 등록
		if(planInsertServiceVO.getPlannerName() != null && planInsertServiceVO.getPlannerStartDate() != null && planInsertServiceVO.getPlannerEndDate() != null) {
			// 통합계획표 번호 세팅
			planInsertServiceVO.setPlannerNo(plannerNo);
			
			// SQL 실행
			plannerDao.plannerInsert(planInsertServiceVO);
			groupsDao.groupInsert(planInsertServiceVO);
		}
		
		// 3. 하루계획표 등록 & 4. 장소 등록 & 5. 장소계획 등록
		for(List<PlanInsertServiceSubVO> planList : planInsertServiceVO.getPlanList()) {
			for(PlanInsertServiceSubVO plan : planList) {
				// 번호 세팅
				int placeNo = placeDao.getSequence();
				
				
				// 하루계획 테이블을 확인했을 때 NULL 이면 시퀀스로 번호를 발급해서 세팅 후 등록시킨다
				if(dailyDao.dailyNoConfirm(dailyNo) == null) {
					dailyNo = dailyDao.getSequence();
					dailyplanNo = dailyNo;
				} else if(dailyDao.dailyNoConfirm(dailyNo) == dailyNo) {
					System.out.println("발급 전  : " + dailyDao.dailyNoConfirm(dailyNo));
					dailyNo = dailyDao.getSequence();
					System.out.println("발급 후  : " + dailyDao.dailyNoConfirm(dailyNo));
				}
				
				/* 값 세팅 */ 
				
				// 하루 계획표
				planInsertServiceVO.setDailyNo(dailyNo);
				planInsertServiceVO.setPlannerNo(plannerNo);
				planInsertServiceVO.setDailyStayDate(plan.getDailyStayDate());
				planInsertServiceVO.setDailyOrder(plan.getDailyOrder());
				
				// 장소
				planInsertServiceVO.setPlaceNo(placeNo);
				planInsertServiceVO.setPlaceLatitude(plan.getPlaceLatitude());
				planInsertServiceVO.setPlaceLongitude(plan.getPlaceLongitude());
				planInsertServiceVO.setPlaceName(plan.getPlaceName());
				planInsertServiceVO.setPlaceType(plan.getPlaceType());
				
				// 장소 계획
				planInsertServiceVO.setDailyplanPlaceOrder(plan.getDailyplanPlaceOrder());
				planInsertServiceVO.setDailyplanTransfer(plan.getDailyplanTransfer());
				
				// 번호 확인
				
				/* SQL 실행 */ 
				// 하루 계획표
				if(planInsertServiceVO.getDailyStayDate() != 0 || planInsertServiceVO.getDailyOrder() != 0) {
					dailyDao.dailyInsert(planInsertServiceVO);
				}
				
				
				// 장소
				if(planInsertServiceVO.getPlaceLatitude() != null || planInsertServiceVO.getPlaceLongitude() != null) {
					placeDao.placeInsert(planInsertServiceVO);
				}
				
				// 장소계획
				if(planInsertServiceVO.getDailyplanPlaceOrder() != 0) {
					System.out.println("장소계획 번호 : " + dailyplanNo);
					planInsertServiceVO.setDailyNo(dailyplanNo);
					dailyplanDao.dailyplanInsert(planInsertServiceVO);
				}
				
			}
		}
	}
	
}
