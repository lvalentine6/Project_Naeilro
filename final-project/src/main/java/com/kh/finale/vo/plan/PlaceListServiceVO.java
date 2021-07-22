package com.kh.finale.vo.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PlaceListServiceVO {
	private int placeNo;
	private String placeLatitude;
	private String placeLongitude;
	private String placeName;
	private String placeType;
	
	private int dailyNo;
	private int dailyplanPlaceOrder;
	private String dailyplanTransfer;
}
