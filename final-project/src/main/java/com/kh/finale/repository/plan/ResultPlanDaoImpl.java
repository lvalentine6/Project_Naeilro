package com.kh.finale.repository.plan;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.ResultPlanVO;

@Repository
public class ResultPlanDaoImpl implements ResultPlanDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ResultPlanVO> selectPlan(ResultPlanVO resultPlanVO) {
		return sqlSession.selectList("planner.selectPlan", resultPlanVO);
	}

}
