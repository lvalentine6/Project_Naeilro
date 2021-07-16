package com.kh.finale.service.plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlaceDao;
import com.kh.finale.vo.plan.PlanInsertServiceVO;

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
		
		// 2. 장소 등록
		placeDao.placeInsert(planInsertServiceVO); //placeNo 발급
		
		// 3. 하루계획표 등록
		dailyDao.dailyInsert(planInsertServiceVO); // dailyNo 발급
		
		// 4. 장소계획 등록
		dailyplanDao.dailyplanInsert(planInsertServiceVO);
	}

}
