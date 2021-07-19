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

}
