package com.kh.finale.repository.photostory;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.vo.photostory.PhotostoryListVO;

public interface PhotostoryDao {
	// 포토스토리 페이지 관련 파라미터 계산 기능
	PhotostoryListVO getPageVariable(PhotostoryListVO photostoryListVO);

	// 총 포토스토리 개수 획득 기능
	int getPhotostoryCount(PhotostoryListVO photostoryListVO);
	
	// 포토스토리 번호 획득 기능
	int getSequence();
	
	// 포토스토리 작성 기능
	void insertPhotostory(PhotostoryDto photostoryDto);

	// 포토스토리 수정 기능
	void updatePhotostory(PhotostoryDto photostoryDto);
	
	// 포토스토리 삭제 기능
	void deletePhotostory(int photostoryNo);
	
	// 포토스토리 좋아요 수 갱신 기능
	void refreshPhotostoryLikeCount(int photostoryNo);

	// 포토스토리 좋아요 수 조회 기능(임시)
	int getPhotostoryLikeCount(int photostoryNo);
	
	// 포토스토리 댓글 수 갱신 기능
	void refreshPhotostoryCommentCount(int photostoryNo);
	
	// 포토스토리 댓글 수 조회 기능(임시)
	int getPhotostoryCommentCount(int photostoryNo);
}
