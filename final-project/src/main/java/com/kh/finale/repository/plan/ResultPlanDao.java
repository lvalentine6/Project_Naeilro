package com.kh.finale.repository.plan;

import java.util.List;

import com.kh.finale.vo.plan.ResultPlanVO;

public interface ResultPlanDao {
	
	// 결과페이지 DB 조회
	List<ResultPlanVO> selectPlan(ResultPlanVO resultPlanVO);
}
