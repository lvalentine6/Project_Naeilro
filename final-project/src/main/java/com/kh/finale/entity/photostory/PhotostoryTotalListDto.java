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
 * 포토스토리 페이지에서 각각의 게시글 제목, 내용과 댓글, 닉네임을 보여주기 위한 Dto
 * Photostory_detail View와 Photostory_comment_detail View를 조인
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryTotalListDto {
	private int photostoryNo, plannerNo, memberNo;
	private String photostoryTitle, photostoryContent;
	private Date photostoryDate;
	private int photostoryCommentCount, photostoryLikeCount;
	private String memberNick;
	
	private String pastDate;
	
	private int photostoryCommentNo;
	private String photostoryCommentContent;
	private Date photostoryCommentDate;
	private String photostoryCommentMemberNick;
	
	// 글작성시 지난날짜를 표기하기 위한 get 메소드
	public String getPastDateString() throws ParseException {
		DateUtils dateUtils = new DateUtils();
		
		return dateUtils.getDifferenceInDate(photostoryDate);
	}
}
