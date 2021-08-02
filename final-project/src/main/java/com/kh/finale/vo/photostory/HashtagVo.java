package com.kh.finale.vo.photostory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class HashtagVo {
	private int count;
	private String hashtagTag;
}
