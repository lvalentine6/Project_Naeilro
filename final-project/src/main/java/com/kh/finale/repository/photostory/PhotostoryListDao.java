package com.kh.finale.repository.photostory;

import com.kh.finale.entity.photostory.PhotostoryListDto;

public interface PhotostoryListDao {
	// 포토스토리 상세 조회 기능
	PhotostoryListDto find(int photostoryNo);
}
