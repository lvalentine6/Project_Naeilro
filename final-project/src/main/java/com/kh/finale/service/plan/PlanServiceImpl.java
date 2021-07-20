package com.kh.finale.service.plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlaceDao;
import com.kh.finale.vo.plan.PlanInsertServiceVO;

import lombok.extern.slf4j.Slf4j;

@Service
public class PlanServiceImpl implements PlanService {
	
	@Autowired
	private PlaceDao placeDao;
	
	@Autowired
	private DailyDao dailyDao;
	
	@Autowired
	private DailyplanDao dailyplanDao;
	@Override
	public void planInsertService(PlanInsertServiceVO planInsertServiceVO) {
		
		// 1. 등록 전 값 세팅
		planInsertServiceVO.setPlaceNo(placeDao.getSequence());
		
		planInsertServiceVO.setDailyNo(dailyDao.getSequence());
		
		// 2. 하루계획표 등룍
		// 최초 등록일 경우 하루계획표 데이터를 자동으로 등록한다
		
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
