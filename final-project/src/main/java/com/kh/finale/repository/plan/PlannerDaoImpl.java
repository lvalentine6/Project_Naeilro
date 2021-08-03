package com.kh.finale.repository.plan;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.PlanVo;
import com.kh.finale.vo.report.PageVo;

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

	// 통합 계획표 삭제 기능
	@Override
	public void plannerDelete(int plannerNo) {
		sqlSession.delete("planner.plannerDelete", plannerNo);
	}
	
	@Override
	public List<PlanVo> getMemberPlanList(int memberNo) {
		return sqlSession.selectList("planList.memberPlanList",memberNo);
	}
	
	@Override
	public List<PlanVo> getPlanList(PageVo pageVo) {
		return sqlSession.selectList("planList.planList",pageVo);
	}
	
	@Override
	public int getCount() {
		return sqlSession.selectOne("planList.count");
	}
}
