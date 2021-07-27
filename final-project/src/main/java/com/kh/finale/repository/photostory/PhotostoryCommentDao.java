package com.kh.finale.repository.photostory;

import java.util.List;

import com.kh.finale.entity.photostory.PhotostoryCommentDto;

public interface PhotostoryCommentDao {
	int getPhotostoryCommentNo();
	// 댓글 등록 기능
	void insertPhotostoryComment(PhotostoryCommentDto photostoryCommentDto);
	
	// 댓글 수정 기능
	void updatePhotostoryComment(PhotostoryCommentDto photostoryCommentDto);
	
	// 댓글 삭제 기능
	void deletePhotostoryComment(PhotostoryCommentDto photostoryCommentDto);
	
	// 댓글 조회 기능
	List<PhotostoryCommentDto> list(int photostoryNo);
}
