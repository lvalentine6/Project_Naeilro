package com.kh.finale.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.PlannerInsertVO;

@Repository
public class PlannerDaoImpl implements PlannerDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getSequnece() {
		return sqlSession.selectOne("planner.sequnece");
	}
	
	@Override
	public void plannerInsert(PlannerInsertVO plannerInsertVO) {
		sqlSession.insert("planner.plannerInsert", plannerInsertVO);
	}


}
