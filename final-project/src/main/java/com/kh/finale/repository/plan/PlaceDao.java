package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface PlaceDao {
	int getSequence();
	void placeInsert(PlanInsertServiceVO planInsertServiceVO);
}
