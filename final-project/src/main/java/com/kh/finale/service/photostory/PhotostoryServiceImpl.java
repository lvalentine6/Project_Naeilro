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
			File dir = new File("D:/upload/kh5/photostory/");
			dir.mkdirs();
			
			for (int i = 0; i < photostoryVO.getPhotostoryPhoto().length; i++) {
				String filePath = String.valueOf(photostoryNo) + "/"
						+ String.valueOf(photostoryNo) + "_" + String.valueOf(i + 1);
				File target = new File(dir, filePath);
				target.mkdirs();
				photostoryVO.getPhotostoryPhoto()[i].transferTo(target);

				PhotostoryPhotoDto photostoryPhotoDto = PhotostoryPhotoDto.builder()
						.photostoryNo(photostoryNo)
						.photostoryPhotoFilePath(filePath)
						.photostoryPhotoFileSize(photostoryVO.getPhotostoryPhoto()[i].getSize())
						.build();
				photostoryPhotoDao.insertPhotostoryPhoto(photostoryPhotoDto);
			}
		}
	}

	// 포토스토리 수정
	@Override
	public void updatePhotostory(PhotostoryVO photostoryVO) throws IllegalStateException, IOException {
		// 포토스토리 정보 수정
		int photostoryNo = photostoryDao.getSequence();
		
		PhotostoryDto photostoryDto = PhotostoryDto.builder()
				.photostoryNo(photostoryVO.getPhotostoryNo())
				.plannerNo(photostoryVO.getPlannerNo())
				.memberNo(photostoryVO.getMemberNo())
				.photostoryContent(photostoryVO.getPhotostoryContent())
				.build();
		photostoryDao.updatePhotostory(photostoryDto);
		
		if (!photostoryVO.getPhotostoryPhoto()[0].isEmpty()) {
			// 포토스토리 이미지 수정
			// 경로 설정 및 생성
			File dir = new File("D:/upload/kh5/photostory/");
			dir.mkdirs();
			
			for (int i = 0; i < photostoryVO.getPhotostoryPhoto().length; i++) {
				String filePath = String.valueOf(photostoryNo) + "/"
						+ String.valueOf(photostoryNo) + "_" + String.valueOf(i + 1);
				File target = new File(dir, filePath);
				target.mkdirs();
				photostoryVO.getPhotostoryPhoto()[i].transferTo(target);
				
				PhotostoryPhotoDto photostoryPhotoDto = PhotostoryPhotoDto.builder()
						.photostoryNo(photostoryNo)
						.photostoryPhotoFilePath(filePath)
						.photostoryPhotoFileSize(photostoryVO.getPhotostoryPhoto()[i].getSize())
						.build();
				photostoryPhotoDao.updatePhotostoryPhoto(photostoryPhotoDto);
			}
		}
	}
}
