package com.kh.finale.service.plan;

import org.springframework.beans.factory.annotation.Autowired;

import com.kh.finale.repository.plan.PlannerDao;
import com.kh.finale.vo.plan.PlanInsertServiceVO;

public class ResultPlanServiceImpl implements ResultPlanService{

	@Autowired
	PlannerDao plannerDao;
	
	@Override
	public PlanInsertServiceVO selectPlan(PlanInsertServiceVO planInsertServiceVO) {
		return plannerDao.selectPlan(planInsertServiceVO);
	}

}
