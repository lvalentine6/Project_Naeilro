package com.kh.finale.vo.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class ResultPlanVO {
	private int plannerNo;
	private String plannerName;
	private String plannerOpen;
	
	private int memberNo;
	
	private int dailyNo;
	private int dailyStayDate;
	private int dailyOrder;
	
	private int placeNo;
	private String placeLatitude;
	private String placeLongitude;
	private String placeName;
	private String placeType;
	private String placeRegion;
	
	private int dailyplanPlaceOrder;
	private String dailyplanTransfer;
}
