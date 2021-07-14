package com.kh.finale.repository.photostory;

import com.kh.finale.entity.photostory.PhotostoryLikeDto;

public interface PhotostoryLikeDao {
	// 좋아요 등록 기능
	void insertPhotostoryLike(PhotostoryLikeDto photostoryLikeDto);
	
	// 좋아요 삭제 기능
	void deletePhotostoryLike(PhotostoryLikeDto photostoryLikeDto);
	
	// 좋아요 확인 기능
	boolean checkPhotostoryLike(PhotostoryLikeDto photostoryLikeDto);
}
