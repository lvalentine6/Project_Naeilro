package com.kh.finale.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.PlanInsertServiceVO;

@Repository
public class DailyDaoImpl implements DailyDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getSequence() {
		return sqlSession.selectOne("daily.sequnece");
	}
	
	@Override
	public void dailyInsert(PlanInsertServiceVO planInsertServiceVO) {
		sqlSession.insert("daily.dailyInsert", planInsertServiceVO);
	}

	@Override
	public Integer dailyOrderConfirm(PlanInsertServiceVO planInsertServiceVO) {
		return sqlSession.selectOne("daily.dailyOrderConfirm", planInsertServiceVO);
	}

	@Override
	public int dailyNoConfrim(PlanInsertServiceVO planInsertServiceVO) {
		return sqlSession.selectOne("daily.dailyNoConfirm", planInsertServiceVO);
	}

}
