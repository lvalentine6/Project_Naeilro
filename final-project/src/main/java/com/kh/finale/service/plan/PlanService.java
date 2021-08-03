package com.kh.finale.service.plan;

import java.util.List;

import com.kh.finale.vo.plan.FindPhotoVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

public interface PlanService {
	int planInsertService(PlanInsertServiceVO planInsertServiceVO);
	
	// 결과페이지 DB 조회
	List<ResultPlanVO> selectPlan(ResultPlanVO resultPlanVO);
	
	// 포토스토리 이미지 조회
	FindPhotoVO selectPhoto(FindPhotoVO findPhotoVO);
}
