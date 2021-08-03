package com.kh.finale.vo.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class PlanVo {
	int plannerNo;
	String plannerName;
	String placeLatitude;
	String placeLongitude;
}
