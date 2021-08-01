package com.kh.finale.vo.plan;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @AllArgsConstructor @NoArgsConstructor @Builder
public class FindPhotoVO {
	private int plannerNo;
	private int memberNo;
	private int photostoryNo;
	private int photostoryPhotoNo;
	private String photostoryPhotoFilePath;
	private MultipartFile[] photostoryPhoto;
}
