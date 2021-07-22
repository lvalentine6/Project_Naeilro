package com.kh.finale.repository.plan;

import java.util.List;

import com.kh.finale.vo.plan.PlaceListServiceVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;

public interface PlaceDao {
	int getSequence();
	void placeInsert(PlanInsertServiceVO planInsertServiceVO);
	List<PlaceListServiceVO> placeListService(int dailyNo);
}
