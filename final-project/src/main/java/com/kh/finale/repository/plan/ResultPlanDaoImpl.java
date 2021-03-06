package com.kh.finale.repository.plan;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.FindPhotoVO;
import com.kh.finale.vo.plan.ResultPlanVO;

@Repository
public class ResultPlanDaoImpl implements ResultPlanDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public List<ResultPlanVO> selectPlan(ResultPlanVO resultPlanVO) {
		return sqlSession.selectList("planner.selectPlan", resultPlanVO);
	}
	
	
	// 포토스토리 이미지 조회
	@Override
	public FindPhotoVO selectPhoto(FindPhotoVO findPhotoVO) {
		return sqlSession.selectOne("planner.selectPhoto", findPhotoVO);
	}

}
