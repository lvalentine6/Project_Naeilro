package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface PlannerDao {
	int getSequnece();
	
	void plannerInsert(PlanInsertServiceVO planInsertServiceVO);
	
	// 통합 계획표 삭제 기능
	void plannerDelete(int plannerNo);
}
