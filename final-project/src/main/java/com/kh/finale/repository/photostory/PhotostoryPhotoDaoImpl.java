package com.kh.finale.repository.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryPhotoDto;

@Repository
public class PhotostoryPhotoDaoImpl implements PhotostoryPhotoDao {

	@Autowired
	private SqlSession sqlSession;

	// 이미지 등록 기능
	@Override
	public void insertPhotostoryPhoto(PhotostoryPhotoDto photostoryPhotoDto) {
		sqlSession.insert("photostoryPhoto.insert", photostoryPhotoDto);
	}
	
	// 이미지 삭제 기능
	@Override
	public void deletePhotostoryPhoto(int photostoryNo) {
		sqlSession.delete("photostoryPhoto.delete", photostoryNo);
	}
	
	// 이미지 삭제 기능(포토번호)
	@Override
	public void deletePhotostoryPhotoByPhotoNo(int photostoryPhotoNo) {
		sqlSession.delete("photostoryPhoto.deleteByPhotoNo", photostoryPhotoNo);
	}

	// 이미지 리스트 조회 기능
	@Override
	public List<PhotostoryPhotoDto> get(int photostoryNo) {
		return sqlSession.selectList("photostoryPhoto.get", photostoryNo);
	}

	// 이미지 단일 조회 기능
	@Override
	public PhotostoryPhotoDto getSingle(int photostoryPhotoNo) {
		return sqlSession.selectOne("photostoryPhoto.getSingle", photostoryPhotoNo);
	}
	
	@Override
	public void adminDeletePhoto(int photostoryNo) {
		 sqlSession.update("photostoryPhoto.adminDelete", photostoryNo);
	}
}
