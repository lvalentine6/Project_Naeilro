package com.kh.finale.restcontroller.plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.service.plan.PlannerService;
import com.kh.finale.vo.plan.PlannerInsertVO;

@RestController
@RequestMapping("/plan/data")
public class PlanRestController {
	
	@Autowired
	private PlannerService plannerService;
	
	/*
	 * @PostMapping("/plannerInsert") public String plannerInsert(@ModelAttribute
	 * PlannerDto plannerDto) { plannerDao.plannerInsert(plannerDto); return "Y"; }
	 */
	@PostMapping("/plannerInsert") public void plannerInsert(@ModelAttribute PlannerInsertVO plannerInsertVO) {
		
	}
	
}
