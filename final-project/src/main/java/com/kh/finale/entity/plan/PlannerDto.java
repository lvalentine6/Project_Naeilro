package com.kh.finale.entity.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PlannerDto {
	private int plannerNo;
	private String plannerName;
	private String plannerStartDate;
	private String plannerEndDate;
	private String plannerOpen;
}
