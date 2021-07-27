package com.kh.finale.controller.plan;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/plan")
public class PlanViewController {
	
	@GetMapping("/writeplan")
	public String writePlan() {
		return "plan/writeplan";
	}
	
	
	@Autowired
	HttpSession httpSession;
	
	@GetMapping("/resultPlan")
	public String resultPlan(Model model) {
		System.out.println("하하" + httpSession.getAttribute("memberNo"));
		
		return "plan/resultPlan";
	}
}
