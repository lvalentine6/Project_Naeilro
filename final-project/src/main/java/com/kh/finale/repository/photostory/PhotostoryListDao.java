package com.kh.finale.repository.photostory;

import java.util.List;

import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.vo.photostory.PhotostoryVO;

public interface PhotostoryListDao {
	// 포토스토리 리스트 조회 기능
	List<PhotostoryListDto> list(PhotostoryVO photostoryVO);
	
	// 포토스토리 상세 조회 기능
	PhotostoryListDto get(int photostoryNo);
}
