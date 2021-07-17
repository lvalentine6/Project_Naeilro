package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface DailyDao {
	int getSequence();
	void dailyInsert(PlanInsertServiceVO planInsertServiceVO);
	Integer dailyOrderConfirm(PlanInsertServiceVO planInsertServiceVO);
	int dailyNoConfrim(PlanInsertServiceVO planInsertServiceVO);
}
