package com.kh.finale.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.vo.plan.PlannerInsertVO;

@Repository
public class GroupsDaoImpl implements GroupsDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void groupInsert(PlannerInsertVO plannerInsertVO) {
		sqlSession.insert("groups.groupsInsert", plannerInsertVO);
	}

}
