package com.kh.finale.controller.plan;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.service.plan.PlanService;
import com.kh.finale.vo.plan.ResultPlanVO;

@Controller
@RequestMapping("/plan")
public class PlanViewController {
	
	@GetMapping("/writeplan")
	public String writePlan() {
		return "plan/writeplan";
	}
	
	@Autowired
	HttpSession httpSession;
	
	@Autowired
	PlanService planService;
	
	@GetMapping("/resultPlan")
	public String resultPlan(@ModelAttribute ResultPlanVO resultPlanVO, Model model) {
		System.out.println("세션 값 : " + httpSession.getAttribute("memberNo"));
		resultPlanVO.setMemberNo((int) httpSession.getAttribute("memberNo"));
		resultPlanVO.setPlannerNo(29);
		List<ResultPlanVO> send = planService.selectPlan(resultPlanVO);
		System.out.println("DB 값 조회 : " + send);
		model.addAttribute("list", send);
		return "plan/resultPlan";
	}
}
