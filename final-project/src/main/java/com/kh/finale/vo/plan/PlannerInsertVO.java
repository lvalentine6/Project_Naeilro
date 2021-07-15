package com.kh.finale.vo.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PlannerInsertVO {
	
	// 통합계획표
	private int plannerNo;
	private String plannerName;
	private String plannerStartDate;
	private String plannerEndDate;
	private String plannerOpen;
	
	// 그룹공유
	private int groupNo;
	private int memberNo;
}
