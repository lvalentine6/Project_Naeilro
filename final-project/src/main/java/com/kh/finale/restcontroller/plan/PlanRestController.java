package com.kh.finale.restcontroller.plan;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.entity.plan.PlannerDto;
import com.kh.finale.repository.plan.PlannerDao;

@RestController
@RequestMapping("/plan/data")
public class PlanRestController {
	
	@Autowired
	private PlannerDao plannerDao;
	
	@PostMapping("/plannerInsert")
	public String plannerInsert(@ModelAttribute PlannerDto plannerDto) {
		plannerDao.plannerInsert(plannerDto);
		return "Y";
	}
	
}
