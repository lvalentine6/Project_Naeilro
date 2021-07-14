package com.kh.finale.repository.photostory;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.util.ListParameter;

public interface PhotostoryDao {
	// 포토스토리 페이지 관련 파라미터 계산 기능
	ListParameter getPageVariable(ListParameter listParameter);

	// 총 포토스토리 개수 획득 기능
	int getPhotostoryCount(ListParameter listParameter);
	
	// 포토스토리 작성 기능
	void writePhotostory(PhotostoryDto photostoryDto);
	
	// 포토스토리 좋아요 수 갱신 기능
	void refreshPhotostoryLikeCount(int photostoryNo);

	// 포토스토리 좋아요 수 조회 기능(임시)
	int getPhotostoryLikeCount(int photostoryNo);
	
	// 포토스토리 댓글 수 갱신 기능
	void refreshPhotostoryCommentCount(int photostoryNo);
	
	// 포토스토리 댓글 수 조회 기능(임시)
	int getPhotostoryCommentCount(int photostoryNo);
}
