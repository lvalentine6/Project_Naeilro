package com.kh.finale.repository.plan;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.finale.entity.plan.GroupsDto;

@Repository
public class GroupsDaoImpl implements GroupsDao {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void groupInsert(GroupsDto groupsDto) {
		sqlSession.insert("groups.groupsInsert", groupsDto);
	}

}
