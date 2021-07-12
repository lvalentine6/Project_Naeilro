package com.kh.finale.controller.plan;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/plan")
public class PlanController {
	
	@GetMapping("/writeplan")
	public String writePlan() {
		return "plan/writeplan";
	}
	
	
}
