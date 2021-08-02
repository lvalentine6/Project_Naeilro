package com.kh.finale.repository.plan;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.plan.PlanListDto;

@Repository
public class PlanListDaoImpl implements PlanListDao {

	@Autowired
	private SqlSession sqlSession;
	
	// 계획표 리스트 조회 기능
	@Override
	public List<PlanListDto> getPlanList(int plannerNo) {
		return sqlSession.selectList("planList.selectPlanList", plannerNo);
	}
	
	// 일정 번호로 장소 번호를 조회하는 기능
	@Override
	public List<Integer> getPlaceNoList(int dailyNo) {
		return sqlSession.selectList("planList.selectPlanListByDailyNo", dailyNo);
	}
}
