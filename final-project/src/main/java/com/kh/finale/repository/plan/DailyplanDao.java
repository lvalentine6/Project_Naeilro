package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface DailyplanDao {
	void dailyplanInsert(PlanInsertServiceVO planInsertServiceVO);
	
	// 장소 계획 개수 조회
	int getDailyplanCount(int dailyNo);
	
	// 장소 계획 수정 기능
	int dailyplanUpdate(PlanInsertServiceVO planInsertServiceVO);
	
	// 장소 계획 삭제 기능
	void dailyplanDelete(PlanInsertServiceVO planInsertServiceVO);
}
