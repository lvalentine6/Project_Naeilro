package com.kh.finale.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

@Repository
public class DailyplanDaoImpl implements DailyplanDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void dailyplanInsert(PlanInsertServiceVO planInsertServiceVO) {
		sqlSession.insert("dailyplan.dailyplanInsert", planInsertServiceVO);
	}

	// 장소 계획 개수 조회
	@Override
	public int getDailyplanCount(int dailyNo) {
		return sqlSession.selectOne("dailyplan.getDailyplanCount", dailyNo);
	}
	
	// 장소 계획 수정 기능
	@Override
	public int dailyplanUpdate(PlanInsertServiceVO planInsertServiceVO) {
		return sqlSession.update("dailyplan.dailyplanUpdate", planInsertServiceVO);
	}
	
	// 장소 계획 삭제 기능
	@Override
	public void dailyplanDelete(PlanInsertServiceVO planInsertServiceVO) {
		sqlSession.delete("dailyplan.dailyplanDelete", planInsertServiceVO);
	}
}
