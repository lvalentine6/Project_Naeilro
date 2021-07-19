package com.kh.finale.entity.plan;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @NoArgsConstructor @AllArgsConstructor @Builder
public class PlaceDto {
	private int placeNo;
	private String placeLatitude;
	private String placeLongitude;
	private String placeName;
	private String placeType;
}