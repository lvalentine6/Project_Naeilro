package com.kh.finale.repository.plan;

import java.util.List;

import com.kh.finale.entity.plan.DailyDto;
import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface DailyDao {
	int getSequence();
	void dailyInsert(PlanInsertServiceVO planInsertServiceVO);
	Integer dailyOrderConfirm(PlanInsertServiceVO planInsertServiceVO);
	int dailyNoConfirm(PlanInsertServiceVO planInsertServiceVO);
	
	List<DailyDto> dailyListService(int plannerNo);
}
