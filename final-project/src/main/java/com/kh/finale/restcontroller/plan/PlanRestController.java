package com.kh.finale.restcontroller.plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.service.plan.PlanService;
import com.kh.finale.vo.plan.PlanInsertServiceVO;

@RestController
@RequestMapping("/plan/data")
public class PlanRestController {
	
	@Autowired
	private PlanService planService;
	
	@PostMapping("/planInsertService")
	public int planInsertService(@ModelAttribute PlanInsertServiceVO planInsertServiceVO) {
		// 회원번호 세팅
		planInsertServiceVO.setMemberNo(1);
		
		return planService.planInsertService(planInsertServiceVO);
	}
	
}
