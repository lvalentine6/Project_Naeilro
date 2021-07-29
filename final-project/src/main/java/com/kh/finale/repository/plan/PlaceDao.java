package com.kh.finale.repository.plan;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface PlaceDao {
	int getSequence();
	void placeInsert(PlanInsertServiceVO planInsertServiceVO);
	
	// 장소 수정 기능
	int placeUpdate(PlanInsertServiceVO planInsertServiceVO);
	
	// 장소 삭제 기능
	void placeDelete(int placeNo);
}
