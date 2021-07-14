package com.kh.finale.repository.photostory;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.photostory.PhotostoryTotalListDto;
import com.kh.finale.util.ListParameter;

@Repository
public class PhotostoryTotalListDaoImpl implements PhotostoryTotalListDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 포토스토리 리스트 조회 기능
	@Override
	public List<PhotostoryTotalListDto> list(ListParameter listParameter) {
		return sqlSession.selectList("photostoryTotalList.list", listParameter);
	}
}
