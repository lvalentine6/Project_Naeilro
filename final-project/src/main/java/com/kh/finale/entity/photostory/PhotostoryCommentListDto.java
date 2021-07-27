package com.kh.finale.entity.photostory;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import com.kh.finale.util.DateUtils;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 포토스토리 페이지에서 댓글 리스트를 보여주기 위한 변수를 저장하는 Dto
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryCommentListDto {
	private int photostoryCommentNo,memberNo;
	private String photostoryCommentContent;
	private Date photostoryCommentDate;
	private String photostoryCommentMemberNick;
	
	private String pastDate;
	
	// 댓글 작성시간의 시/분/초까지 표시하기 위한 get 메소드
	public String getPhotostoryCommentDateString() {
		SimpleDateFormat simpleDateformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");				
		
		return simpleDateformat.format(photostoryCommentDate);
	}
	
	// 댓글작성시 지난날짜를 표기하기 위한 get 메소드
	public String getPastDateString() throws ParseException {
		return DateUtils.getDifferenceInDate(photostoryCommentDate);
	}
}
