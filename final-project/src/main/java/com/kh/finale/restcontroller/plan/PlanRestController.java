package com.kh.finale.restcontroller.plan;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.service.plan.PlanService;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

@RestController
@RequestMapping("/plan/data")
public class PlanRestController {
	
	@Autowired
	private PlanService planService;
	
	@PostMapping("/planInsertService")
	public void planInsertService(@ModelAttribute PlanInsertServiceVO planInsertServiceVO) {
		// 회원번호 세팅
		planInsertServiceVO.setMemberNo(1);
		
		planService.planInsertService(planInsertServiceVO);
	}
	
	@GetMapping("/planResultService")
	public List<ResultPlanVO> resultPlan(ResultPlanVO resultPlanVO, Model model){
		return planService.selectPlan(resultPlanVO);
	}
}
