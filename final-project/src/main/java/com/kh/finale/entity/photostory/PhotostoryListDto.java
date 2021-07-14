package com.kh.finale.entity.photostory;

import java.sql.Date;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 포토스토리 상세 페이지에서 작성자 닉네임을 보여주기 위한 Dto
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryListDto {
	private int photostoryNo, plannerNo, memberNo;
	private String photostoryContent;
	private Date photostoryDate;
	private int photostoryCommentCount, photostoryLikeCount;
	private String memberNick;
	
	// 글 작성시간의 시/분/초까지 표시하기 위한 get 메소드
	public String getPhotostoryDateString() {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
		
		return simpleDateformat.format(photostoryDate);
	}
}
