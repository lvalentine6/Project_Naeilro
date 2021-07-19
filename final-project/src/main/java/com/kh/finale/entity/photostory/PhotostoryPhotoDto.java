package com.kh.finale.entity.photostory;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 포토스토리의 이미지 관련 기능에 필요한 Dto
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
