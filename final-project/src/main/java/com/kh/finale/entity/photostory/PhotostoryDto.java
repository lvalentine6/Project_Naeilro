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
public class PhotostoryDto {
	private int photostoryNo, plannerNo, memberNo;
	private String photostoryTitle, photostoryContent;
	private Date photostoryDate;
	private int photostoryCommentCount, photostoryLikeCount;
}
