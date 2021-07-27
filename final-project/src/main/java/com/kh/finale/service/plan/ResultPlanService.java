package com.kh.finale.service.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface ResultPlanService {
	
	// 결과페이지 DB 조회
	PlanInsertServiceVO selectPlan(PlanInsertServiceVO planInsertServiceVO);
}
