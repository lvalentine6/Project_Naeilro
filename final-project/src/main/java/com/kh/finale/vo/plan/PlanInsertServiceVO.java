package com.kh.finale.vo.plan;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PlanInsertServiceVO {
	// 통합계획표
	private int plannerNo;
	private String plannerName;
	private String plannerStartDate;
	private String plannerEndDate;
	private String plannerOpen;
	private int memberNo;
	
	// 하루계획표
	private int dailyNo;
	private int dailyStayDate;
	private int dailyOrder;
	
	// 장소
	private int placeNo;
	private String placeLatitude;
	private String placeLongitude;
	private String placeName;
	private String placeType;
	private String placeRegion;
	
	// 장소계획
	private int dailyplanPlaceOrder;
	private String dailyplanTransfer;
	
	// 다차원 배열 : 장소 & 장소계획 & 하루계획표
	private List<List<PlanInsertServiceSubVO>> planList;
}
