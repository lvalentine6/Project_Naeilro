package com.kh.finale.repository.plan;

import java.util.List;

import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

public interface PlannerDao {
	int getSequnece();
	
	void plannerInsert(PlanInsertServiceVO planInsertServiceVO);
	
	// 통합 계획표 수정 기능
	int plannerUpdate(PlanInsertServiceVO planInsertServiceVO);
	
	// 통합 계획표 삭제 기능
	void plannerDelete(int plannerNo);
}
