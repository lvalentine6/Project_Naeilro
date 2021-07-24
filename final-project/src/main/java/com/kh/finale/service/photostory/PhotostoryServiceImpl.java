package com.kh.finale.service.photostory;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.entity.photostory.PhotostoryPhotoDto;
import com.kh.finale.repository.photostory.PhotostoryDao;
import com.kh.finale.repository.photostory.PhotostoryPhotoDao;
import com.kh.finale.util.ArrayUtils;
import com.kh.finale.util.DateUtils;
import com.kh.finale.vo.photostory.PhotostoryVO;

@Service
public class PhotostoryServiceImpl implements PhotostoryService {

	@Autowired
	private PhotostoryDao photostoryDao;
	
	@Autowired
	private PhotostoryPhotoDao photostoryPhotoDao;
	
	// 포토스토리 등록
	@Override
	public void insertPhotostory(PhotostoryVO photostoryVO) throws IllegalStateException, IOException {
		// 포토스토리 정보 등록
		photostoryVO.setPhotostoryNo(photostoryDao.getSequence());
		
		PhotostoryDto photostoryDto = PhotostoryDto.builder()
				.photostoryNo(photostoryVO.getPhotostoryNo())
				.plannerNo(photostoryVO.getPlannerNo())
				.memberNo(photostoryVO.getMemberNo())
				.photostoryContent(photostoryVO.getPhotostoryContent())
				.build();
		photostoryDao.insertPhotostory(photostoryDto);
		
		if (!photostoryVO.getPhotostoryPhoto()[0].isEmpty()) {
			// 포토스토리 이미지 등록
			insertPhotostoryPhoto(photostoryVO);
		}
	}

	// 포토스토리 수정
	@Override
	public void updatePhotostory(PhotostoryVO photostoryVO) throws IllegalStateException, IOException {
		// 포토스토리 정보 수정
		PhotostoryDto photostoryDto = PhotostoryDto.builder()
				.photostoryNo(photostoryVO.getPhotostoryNo())
				.plannerNo(photostoryVO.getPlannerNo())
				.memberNo(photostoryVO.getMemberNo())
				.photostoryContent(photostoryVO.getPhotostoryContent())
				.build();
		photostoryDao.updatePhotostory(photostoryDto);
		
		// 기존 이미지 파일을 삭제할 경우 삭제
		if (photostoryVO.getDeleteNo() != null) {
			deleteExistencePhotostoryPhoto(photostoryVO);
		}
		
		if (!photostoryVO.getPhotostoryPhoto()[0].isEmpty()) {
			// 포토스토리 이미지 등록
			insertPhotostoryPhoto(photostoryVO);
		}
	}

	// 포토스토리 삭제
	@Override
	public void deletePhotostory(int photostoryNo) {
		deletePhotostoryPhoto(photostoryNo);
		photostoryDao.deletePhotostory(photostoryNo);
	}

	// 포토스토리 이미지 등록
	@Override
	public void insertPhotostoryPhoto(PhotostoryVO photostoryVO) throws IllegalStateException, IOException {
		// 경로 설정 및 생성
		File dir = new File("D:/upload/kh5/photostory/");
		dir.mkdirs();
		for (int i = 0; i < photostoryVO.getPhotostoryPhoto().length; i++) {
			System.out.println("사진: " + photostoryVO.getPhotostoryPhoto()[i]);
		}
		for (int i = 0; i < photostoryVO.getPhotostoryPhoto().length; i++) {
			if (ArrayUtils.contains(photostoryVO.getIndex(), i)) {
				String filePath = String.valueOf(photostoryVO.getPhotostoryNo()) + "/"
						+ DateUtils.getDateString() + "_" + String.valueOf(i + 1);
				File target = new File(dir, filePath);
				target.mkdirs();
				photostoryVO.getPhotostoryPhoto()[i].transferTo(target);
				
				PhotostoryPhotoDto photostoryPhotoDto = PhotostoryPhotoDto.builder()
						.photostoryNo(photostoryVO.getPhotostoryNo())
						.photostoryPhotoFilePath(filePath)
						.photostoryPhotoFileSize(photostoryVO.getPhotostoryPhoto()[i].getSize())
						.build();
				photostoryPhotoDao.insertPhotostoryPhoto(photostoryPhotoDto);
			}
		}
	}
	
	// 포토스토리 이미지 삭제
	@Override
	public void deletePhotostoryPhoto(int photostoryNo) {
		// 서버에서 이미지 파일 삭제
		File dir = new File("D:/upload/kh5/photostory/" + String.valueOf(photostoryNo));
		File[] fileList = dir.listFiles();
		if (fileList != null) {
			for (int i = 0; i < fileList.length; i++) {
				fileList[i].delete();
			}
			dir.delete();
			
			// DB에서 이미지 정보 삭제
			photostoryPhotoDao.deletePhotostoryPhoto(photostoryNo);
		}		
	}
	
	// 포토스토리 기존 이미지 삭제
	@Override
	public void deleteExistencePhotostoryPhoto(PhotostoryVO photostoryVO) {
		for (int i = 0; i < photostoryVO.getDeleteNo().length; i++) {
			// 서버에서 이미지 파일 삭제
			PhotostoryPhotoDto photostoryPhotoDto = photostoryPhotoDao.getSingle(photostoryVO.getDeleteNo()[i]);
			File dir = new File("D:/upload/kh5/photostory/" + photostoryPhotoDto.getPhotostoryPhotoFilePath());
			dir.delete();
				
			// DB에서 이미지 정보 삭제
			photostoryPhotoDao.deletePhotostoryPhotoByPhotoNo(photostoryVO.getDeleteNo()[i]);
		}		
	}
}
