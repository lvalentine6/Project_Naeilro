package com.kh.finale.entity.photostory;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 댓글 관련 기능에 필요한 변수를 저장하는 Dto
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryCommentDto {
	private int photostoryCommentNo, photostoryNo, memberNo;
	private String photostoryCommentContent;
	private Date photostoryCommentDate;
}
