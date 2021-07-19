package com.kh.finale.repository.photostory;

import java.util.List;

import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.vo.photostory.PhotostoryListVO;

public interface PhotostoryListDao {
	// 포토스토리 리스트 조회 기능
	List<PhotostoryListDto> list(PhotostoryListVO photostoryListVO);
	
	// 포토스토리 단일 조회 기능
	PhotostoryListDto get(int photostoryNo);
}
