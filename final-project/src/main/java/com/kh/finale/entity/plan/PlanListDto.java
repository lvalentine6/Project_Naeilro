package com.kh.finale.entity.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 계획표 리스트 뷰를 이용해 데이터를 관리하기 위한 Dto
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PlanListDto {
	private int plannerNo;
	private String plannerName;
	private String plannerStartDate;
	private String plannerEndDate;
	private String plannerOpen;
	
	private int dailyNo;
	private int dailyStayDate;
	
	private String dailyplanTransfer;
	
	private int placeNo;
	private String placeLatitude;
	private String placeLongitude;
	private String placeName;
	private String placeType;
}
