package com.kh.finale.repository.photostory;

import java.util.List;

import com.kh.finale.entity.photostory.PhotostoryCommentListDto;

public interface PhotostoryCommentListDao {
	// 댓글 리스트 조회 기능
	List<PhotostoryCommentListDto> list(int photostoryNo);
	
	// 최신 댓글 리스트 조회 기능
	List<PhotostoryCommentListDto> recentList(int photostoryNo);

	PhotostoryCommentListDto getReportComment(int reportNo);
}
