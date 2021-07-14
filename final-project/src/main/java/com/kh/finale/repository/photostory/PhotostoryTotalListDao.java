package com.kh.finale.repository.photostory;

import java.util.List;

import com.kh.finale.entity.photostory.PhotostoryTotalListDto;
import com.kh.finale.util.ListParameter;

public interface PhotostoryTotalListDao {
	// 포토스토리 리스트 조회 기능
	List<PhotostoryTotalListDto> list(ListParameter listParameter);
}
