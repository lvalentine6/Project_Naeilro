package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface PlannerDao {
	int getSequnece();
	
	void plannerInsert(PlanInsertServiceVO planInsertServiceVO);
	
	// 결과페이지 DB 조회
	PlanInsertServiceVO selectPlan(PlanInsertServiceVO planInsertServiceVO);
}
