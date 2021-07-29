package com.kh.finale.controller.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.finale.entity.plan.PlanListDto;
import com.kh.finale.repository.plan.PlanListDao;

@Controller
@RequestMapping("/plan")
public class PlanViewController {
	
	@GetMapping("/writeplan")
	public String writePlan() {
		return "plan/writeplan";
	}

	@Autowired
	private PlanListDao planListDao;
	
	// 계획표 수정 페이지
	@GetMapping("/editplan")
	public String editPlan(@RequestParam int plannerNo, Model model) {
		List<PlanListDto> planList = planListDao.getPlanList(plannerNo);
		model.addAttribute("planList", planList);
		
		return "plan/editplan";
	}
}
