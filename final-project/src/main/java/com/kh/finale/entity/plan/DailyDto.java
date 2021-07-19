package com.kh.finale.entity.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class DailyDto {
	private int dailyNo;
	private int plannerNo;
	private int dailyStayDate;
	private int dailyOrder;
}
