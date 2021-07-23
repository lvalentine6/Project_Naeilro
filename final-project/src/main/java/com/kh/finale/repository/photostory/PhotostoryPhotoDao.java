package com.kh.finale.repository.photostory;

import java.util.List;

import com.kh.finale.entity.photostory.PhotostoryPhotoDto;

public interface PhotostoryPhotoDao {
	// 이미지 등록 기능
	void insertPhotostoryPhoto(PhotostoryPhotoDto photostoryPhotoDto);

	// 이미지 삭제 기능
	void deletePhotostoryPhoto(int photostoryNo);
	
	// 이미지 삭제 기능(포토번호)
	void deletePhotostoryPhotoByPhotoNo(int photostoryPhotoNo);

	// 이미지 리스트 조회 기능
	List<PhotostoryPhotoDto> get(int photostoryNo);
	
	// 이미지 단일 조회 기능
	PhotostoryPhotoDto getSingle(int photostoryPhotoNo);
}
