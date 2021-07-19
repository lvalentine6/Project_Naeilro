package com.kh.finale.service.photostory;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.entity.photostory.PhotostoryPhotoDto;
import com.kh.finale.repository.photostory.PhotostoryDao;
import com.kh.finale.repository.photostory.PhotostoryPhotoDao;
import com.kh.finale.util.DateUtils;
import com.kh.finale.vo.photostory.PhotostoryVO;

@Service
public class PhotostoryServiceImpl implements PhotostoryService {

	@Autowired
	PhotostoryDao photostoryDao;
	
	@Autowired
	PhotostoryPhotoDao photostoryPhotoDao;
	
	// 포토스토리 등록
	@Override
	public void insertPhotostory(PhotostoryVO photostoryVO) throws IllegalStateException, IOException {
		// 포토스토리 정보 등록
		int photostoryNo = photostoryDao.getSequence();
		
		PhotostoryDto photostoryDto = PhotostoryDto.builder()
				.photostoryNo(photostoryNo)
				.plannerNo(photostoryVO.getPlannerNo())
				.memberNo(photostoryVO.getMemberNo())
				.photostoryContent(photostoryVO.getPhotostoryContent())
				.build();
		photostoryDao.insertPhotostory(photostoryDto);
		
		if (!photostoryVO.getPhotostoryPhoto()[0].isEmpty()) {
			// 포토스토리 이미지 등록
			// 경로 설정 및 생성
			DateUtils dateUtils = new DateUtils();
			File dir = new File("D:/upload/photostory" + dateUtils.getSysdate());
			dir.mkdirs();
			
			for (int i = 0; i < photostoryVO.getPhotostoryPhoto().length; i++) {
				String fileName = String.valueOf(photostoryNo) + "_" + String.valueOf(i);
				File target = new File(dir, fileName);
				photostoryVO.getPhotostoryPhoto()[i].transferTo(target);

				PhotostoryPhotoDto photostoryPhotoDto = PhotostoryPhotoDto.builder()
						.photostoryNo(photostoryNo)
						.photostoryPhotoOriginName(photostoryVO.getPhotostoryPhoto()[i].getOriginalFilename())
						.photostoryPhotoSaveName(fileName)
						.build();
				photostoryPhotoDao.insertPhotostoryPhoto(photostoryPhotoDto);
			}
		}
	}
}
