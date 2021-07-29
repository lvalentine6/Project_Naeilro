package com.kh.finale.service.plan;

import java.util.List;

import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

public interface PlanService {
	int planInsertService(PlanInsertServiceVO planInsertServiceVO);
	
	// 결과페이지 DB 조회
		List<ResultPlanVO> selectPlan(ResultPlanVO resultPlanVO);
	
}
