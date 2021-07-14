package com.kh.finale.entity.photostory;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryLikeDto {
	private int photostoryNo, memberNo;
	private Date photostoryLikeDate;
}
