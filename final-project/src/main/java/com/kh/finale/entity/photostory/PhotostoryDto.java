package com.kh.finale.entity.photostory;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 포토스토리 관련 기능에 필요한 변수를 저장하는 Dto
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryDto {
	private int photostoryNo, memberNo;
	private String photostoryContent;
	private Date photostoryDate;
	private int photostoryCommentCount, photostoryLikeCount;
	private Integer plannerNo;
}
