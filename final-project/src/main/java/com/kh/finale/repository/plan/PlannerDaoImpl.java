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

}
