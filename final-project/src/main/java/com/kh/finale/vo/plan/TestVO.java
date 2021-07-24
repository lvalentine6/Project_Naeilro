package com.kh.finale.vo.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class TestVO {
	// 장소
	private int placeNo;
	private String placeLatitude;
	private String placeLongitude;
	private String placeName;
	private String placeType;
		
	// 장소계획
	private int dailyplanPlaceOrder;
	private String dailyplanTransfer;
	
	// 하루계획표
	private int dailyStayDate;
	private int dailyOrder;
	
}
