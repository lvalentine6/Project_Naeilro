package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface PlannerDao {
	int getSequnece();
	
	void plannerInsert(PlanInsertServiceVO planInsertServiceVO);
}
