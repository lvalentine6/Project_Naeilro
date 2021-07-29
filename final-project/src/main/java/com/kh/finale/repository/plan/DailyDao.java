package com.kh.finale.repository.plan;

import java.util.List;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface DailyDao {
	int getSequence();
	void dailyInsert(PlanInsertServiceVO planInsertServiceVO);
	Integer dailyNoConfirm(int dailyNo);
	
	// 하루 계획표 개수 조회 기능
	int getDailyCount(int plannerNo);
	
	// 하루 계획표 리스트 조회 기능
	List<PlanInsertServiceVO> getDailyList(int plannerNo);
	
	// 하루 계획표 수정 기능
	int dailyUpdate(PlanInsertServiceVO planInsertServiceVO);
	
	// 하루 계획표 삭제 기능
	void dailyDelete(int dailyNo);
}
