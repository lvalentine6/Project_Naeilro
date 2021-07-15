package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlannerInsertVO;

public interface PlannerDao {
	int getSequnece();
	
	void plannerInsert(PlannerInsertVO plannerInsertVO);
}
