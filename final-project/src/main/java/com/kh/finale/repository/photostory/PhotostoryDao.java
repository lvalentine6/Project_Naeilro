package com.kh.finale.repository.photostory;

import java.util.List;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.vo.photostory.PhotostoryVO;

public interface PhotostoryDao {
	// 포토스토리 페이지 관련 파라미터 계산 기능
	PhotostoryVO getPageVariable(PhotostoryVO photostoryVO);

	// 총 포토스토리 개수 획득 기능
	int getPhotostoryCount(PhotostoryVO photostoryVO);

	// 포토스토리 리스트 기능
	List<PhotostoryDto> list(PhotostoryVO photostoryVO);
	
	// 포토스토리 작성 기능
	void write(PhotostoryDto photostoryDto);
}
