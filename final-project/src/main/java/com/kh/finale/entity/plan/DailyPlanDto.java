package com.kh.finale.entity.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class DailyPlanDto {
	private int dailyNo;
	private int placeNo;
	private int dailyplanPlaceOrder;
	private String dailyplanTransfer;
}
