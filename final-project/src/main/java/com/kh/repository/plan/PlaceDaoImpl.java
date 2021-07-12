package com.kh.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.plan.PlaceDto;

@Repository
public class PlaceDaoImpl implements PlaceDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void placeInsert(PlaceDto placeDto) {
		sqlSession.insert("plan.placeInsert", placeDto);
	}

}
