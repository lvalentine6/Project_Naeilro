package com.kh.finale.repository.plan;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.PlaceListServiceVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;

@Repository
public class PlaceDaoImpl implements PlaceDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("place.sequnece");
	}
	
	@Override
	public void placeInsert(PlanInsertServiceVO planInsertServiceVO) {
		sqlSession.insert("place.placeInsert", planInsertServiceVO);
	}

	@Override
	public List<PlaceListServiceVO> placeListService(int dailyNo) {
		return sqlSession.selectList("place.placeListService", dailyNo);
	}

}
