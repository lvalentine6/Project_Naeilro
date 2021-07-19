package com.kh.finale.repository.photostory;

import java.io.File;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryPhotoDto;

@Repository
public class PhotostoryPhotoDaoImpl implements PhotostoryPhotoDao {

	@Autowired
	SqlSession sqlSession;

	// 이미지 등록 기능
	@Override
	public void insertPhotostoryPhoto(PhotostoryPhotoDto photostoryPhotoDto) {
		sqlSession.insert("photostoryPhoto.insert", photostoryPhotoDto);
	}

	// 이미지 정보 조회 기능
	@Override
	public List<PhotostoryPhotoDto> get(int photostoryNo) {
		return sqlSession.selectList("photostoryPhoto.get", photostoryNo);
	}
}
