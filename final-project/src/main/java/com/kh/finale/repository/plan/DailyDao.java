package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface DailyDao {
	int getSequence();
	void dailyInsert(PlanInsertServiceVO planInsertServiceVO);
	Integer dailyNoConfirm(int dailyNo);
}
