package com.kh.finale.repository.hashtag;

import java.util.List;

import com.kh.finale.entity.hashtag.HashtagDto;
import com.kh.finale.vo.photostory.HashtagVo;

public interface HashtagDao {
	void insert(HashtagDto hashtagDto);

	void delete(int photostoryNo);

	List<HashtagVo> searchPreview(String keyword);
}
