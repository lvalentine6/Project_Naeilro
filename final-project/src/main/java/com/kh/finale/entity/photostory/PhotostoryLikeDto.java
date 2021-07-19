package com.kh.finale.entity.photostory;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 포토스토리 좋아요에 필요한 변수를 저장하는 Dto
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryLikeDto {
	private int photostoryNo, memberNo;
	private Date photostoryLikeDate;
}
