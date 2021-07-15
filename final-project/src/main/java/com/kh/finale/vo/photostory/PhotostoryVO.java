package com.kh.finale.vo.photostory;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryVO {
	private String memberNick, photostoryContent;
	private int memberNo, photostoryNo;
	// 글 사진 url 예정
	// 프로필 사진 url 예정
	private Date photostoryDate;
	private int photostoryCommentCount, photostoryLikeCount;
	// 댓글 최신순 3개 예정
}
