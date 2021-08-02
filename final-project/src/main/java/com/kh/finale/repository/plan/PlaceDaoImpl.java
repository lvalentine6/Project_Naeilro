package com.kh.finale.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	// 장소 수정 기능
	@Override
	public int placeUpdate(PlanInsertServiceVO planInsertServiceVO) {
		return sqlSession.update("place.placeUpdate", planInsertServiceVO);
	}
	
	// 장소 삭제 기능
	@Override
	public void placeDelete(int placeNo) {
		sqlSession.delete("place.placeDelete", placeNo);
	}
}
