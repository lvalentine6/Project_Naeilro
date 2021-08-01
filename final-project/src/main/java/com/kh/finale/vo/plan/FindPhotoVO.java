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
	private int photostory_photo_no;
	private String photostory_photo_file_path;
	private MultipartFile[] photostoryPhoto;
}
