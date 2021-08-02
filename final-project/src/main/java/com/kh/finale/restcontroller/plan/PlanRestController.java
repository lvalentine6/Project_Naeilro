package com.kh.finale.restcontroller.plan;

import javax.servlet.http.HttpSession;

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
	private HttpSession session;
	
	@Autowired
	private PlanService planService;
	
	@PostMapping("/planInsertService")
	public int planInsertService(@ModelAttribute PlanInsertServiceVO planInsertServiceVO) {
		// 회원번호 세팅
		planInsertServiceVO.setMemberNo((int) session.getAttribute("memberNo"));
		
		return planService.planInsertService(planInsertServiceVO);
	}
	
	// 계획표 수정 처리
	@PostMapping("/planUpdateService")
	public void planUpdateService(@ModelAttribute PlanInsertServiceVO planInsertServiceVO) {
		planInsertServiceVO.setMemberNo(1); // 임시
		System.out.println("plannerNo=" + planInsertServiceVO.getPlannerNo());
		
		planService.planUpdateService(planInsertServiceVO);
	}
}
