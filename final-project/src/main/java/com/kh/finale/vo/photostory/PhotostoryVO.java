package com.kh.finale.vo.photostory;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 포토스토리 등록 시 이미지 등록을 위한 변수를 저장하는 VO
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryVO {
	private int photostoryNo, plannerNo, memberNo;
	private String photostoryContent;
	private MultipartFile[] photostoryPhoto;
}
