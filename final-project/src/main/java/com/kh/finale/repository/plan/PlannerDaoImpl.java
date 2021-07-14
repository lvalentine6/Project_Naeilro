package com.kh.finale.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.plan.PlannerDto;

@Repository
public class PlannerDaoImpl implements PlannerDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void plannerInsert(PlannerDto plannerDto) {
		sqlSession.insert("plan.plannerInsert", plannerDto);
	}

}
