package com.kh.finale.repository.plan;

import java.util.List;

import com.kh.finale.entity.plan.PlanListDto;

public interface PlanListDao {
	// 계획표 리스트 조회 기능
	List<PlanListDto> getPlanList(int plannerNo);
	
	// 일정 번호로 장소 번호를 조회하는 기능
	List<Integer> getPlaceNoList(int dailyNo);
}
