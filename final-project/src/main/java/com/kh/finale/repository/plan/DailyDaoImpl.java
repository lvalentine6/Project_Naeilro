package com.kh.finale.repository.plan;


import java.util.List;

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
	public Integer dailyNoConfirm(int dailyNo) {
		return sqlSession.selectOne("daily.dailyNoConfirm", dailyNo);
	}

	// 하루 계획표 개수 조회 기능
	@Override
	public int getDailyCount(int plannerNo) {
		return sqlSession.selectOne("daily.getDailyCount", plannerNo);
	}
	
	// 하루 계획표 리스트 조회 기능
	@Override
	public List<PlanInsertServiceVO> getDailyList(int plannerNo) {
		return sqlSession.selectList("daily.getDaily", plannerNo);
	}
	
	// 하루 계획표 수정 기능
	@Override
	public int dailyUpdate(PlanInsertServiceVO planInsertServiceVO) {
		return sqlSession.update("daily.dailyUpdate", planInsertServiceVO);
	}
	
	// 하루 계획표 삭제 기능
	@Override
	public void dailyDelete(int dailyNo) {
		sqlSession.delete("daily.dailyDelete", dailyNo);
	}
}
