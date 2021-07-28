package com.kh.finale.repository.plan;

import java.util.List;

import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

public interface PlannerDao {
	int getSequnece();
	
	void plannerInsert(PlanInsertServiceVO planInsertServiceVO);
}
