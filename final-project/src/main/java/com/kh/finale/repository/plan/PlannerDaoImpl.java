package com.kh.finale.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

@Repository
public class PlannerDaoImpl implements PlannerDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getSequnece() {
		return sqlSession.selectOne("planner.sequnece");
	}
	
	@Override
	public void plannerInsert(PlanInsertServiceVO planInsertServiceVO) {
		sqlSession.insert("planner.plannerInsert", planInsertServiceVO);
	}

	// 통합 계획표 수정 기능
	@Override
	public int plannerUpdate(PlanInsertServiceVO planInsertServiceVO) {
		return sqlSession.update("planner.plannerUpdate", planInsertServiceVO);
	}
	
	// 통합 계획표 삭제 기능
	@Override
	public void plannerDelete(int plannerNo) {
		sqlSession.delete("planner.plannerDelete", plannerNo);
	}
}
