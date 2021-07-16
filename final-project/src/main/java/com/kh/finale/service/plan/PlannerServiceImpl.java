package com.kh.finale.service.plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.finale.repository.plan.GroupsDao;
import com.kh.finale.repository.plan.PlannerDao;
import com.kh.finale.vo.plan.PlannerInsertVO;

import lombok.extern.slf4j.Slf4j;

@Service
public class PlannerServiceImpl implements PlannerService {
	
	@Autowired
	PlannerDao plannerDao;
	
	@Autowired
	GroupsDao groupsDao;
	
	@Override
	public int plannerInsertService(PlannerInsertVO plannerInsertVO) {
		
		//목표 : 통합계획표 데이터 생성하고 바로 공유그룹 데이터 생성시키기
		
		int plannerNo = plannerDao.getSequnece();
		
		// 뽑은 번호 세팅
		plannerInsertVO.setPlannerNo(plannerNo);
		
		// 통합계획표 생성 SQL 실행
		plannerDao.plannerInsert(plannerInsertVO); 
		
		// 그룹공유 생성 SQL 실행
		groupsDao.groupInsert(plannerInsertVO);
		
		// 계획표 번호
		return plannerNo;
	}
	
}
