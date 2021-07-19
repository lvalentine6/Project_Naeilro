package com.kh.finale.entity.photostory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 포토스토리에 업로드할 이미지 정보를 담는 Dto
 * @author swjk78
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PhotostoryPhotoDto {
	private int photostoryPhotoNo, photostoryNo;
	private String photostoryPhotoFilePath;
	private long photostoryPhotoFileSize;
}
