package com.kh.finale.service.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface PlanService {
	void planInsertService(PlanInsertServiceVO planInsertServiceVO);
	
	// 계획표 수정
	void planUpdateService(PlanInsertServiceVO planInsertServiceVO);
}
