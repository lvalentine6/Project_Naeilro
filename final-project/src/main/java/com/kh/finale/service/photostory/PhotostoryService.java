package com.kh.finale.service.photostory;

import java.io.IOException;

import com.kh.finale.vo.photostory.PhotostoryVO;

public interface PhotostoryService {
	// 포토스토리 등록
	void insertPhotostory(PhotostoryVO photostoryVO) throws IllegalStateException, IOException;

	// 포토스토리 수정
	void updatePhotostory(PhotostoryVO photostoryVO) throws IllegalStateException, IOException;
	
	// 포토스토리 삭제
	void deletePhotostory(int photostoryNo);
	
	// 포토스토리 이미지 등록
	void insertPhotostoryPhoto(PhotostoryVO photostoryVO) throws IllegalStateException, IOException;
	
	// 포토스토리 이미지 삭제
	void deletePhotostoryPhoto(int photostoryNo);

	// 포토스토리 기존 이미지 삭제
	void deleteExistencePhotostoryPhoto(PhotostoryVO photostoryVO);
}
