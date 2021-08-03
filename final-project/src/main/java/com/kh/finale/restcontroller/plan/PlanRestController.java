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
	
	// 수정
	
	// 1. 가져온 통합계획표 번호로 삭제를 먼저 진행한 후
	
	// 2. 새로운 데이터 삽입한 뒤
	
	// 3. 새로운 통합계획표 번호 리턴
}
