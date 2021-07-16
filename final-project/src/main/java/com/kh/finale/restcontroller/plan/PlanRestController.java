package com.kh.finale.restcontroller.plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.service.plan.PlanService;
import com.kh.finale.service.plan.PlannerService;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.PlannerInsertVO;

@RestController
@RequestMapping("/plan/data")
public class PlanRestController {
	
	@Autowired
	private PlannerService plannerService;
	
	@Autowired
	private PlanService planService;
	
	@PostMapping("/plannerInsert") 
	public int plannerInsert(@ModelAttribute PlannerInsertVO plannerInsertVO) {
		
		// 컨트롤러 테스트 : 회원번호 임시 세팅
		plannerInsertVO.setMemberNo(45);
		
		int plannerNo = plannerService.plannerInsertService(plannerInsertVO);
		
		return plannerNo;
	}
	
	@PostMapping("/planInsertService")
	public void planInsertService(@ModelAttribute PlanInsertServiceVO planInsertServiceVO) {
		planService.planInsertService(planInsertServiceVO);
	}
}
