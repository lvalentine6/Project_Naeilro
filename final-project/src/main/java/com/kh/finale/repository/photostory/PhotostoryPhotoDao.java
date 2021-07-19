package com.kh.finale.repository.photostory;

import java.util.List;

import com.kh.finale.entity.photostory.PhotostoryPhotoDto;

public interface PhotostoryPhotoDao {
	// 이미지 등록 기능
	void insertPhotostoryPhoto(PhotostoryPhotoDto photostoryPhotoDto);

	// 이미지 정보 조회 기능
	List<PhotostoryPhotoDto> get(int photostoryNo);
}
