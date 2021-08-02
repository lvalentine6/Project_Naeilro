package com.kh.finale.controller.plan;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.finale.entity.plan.PlanListDto;
import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlanListDao;
import com.kh.finale.service.plan.PlanService;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

@Controller
@RequestMapping("/plan")
public class PlanViewController {
	
	@GetMapping("/writeplan")
	public String writePlan() {
		return "plan/writeplan";
	}

	@Autowired
	private PlanListDao planListDao;
	
	@Autowired
	private DailyDao dailyDao;

	@Autowired
	private DailyplanDao dailyplanDao;
	
	// 계획표 수정 페이지
	@GetMapping("/editplan")
	public String editPlan(@RequestParam int plannerNo, Model model) {
		List<PlanListDto> planList = planListDao.getPlanList(plannerNo);
		model.addAttribute("planList", planList);
		
		List<PlanInsertServiceVO> dailyList = dailyDao.getDailyList(plannerNo); 
		List<Integer> dailyplanCountList = new ArrayList<>();
		for (PlanInsertServiceVO vo : dailyList) {
			int dailyplanCount = dailyplanDao.getDailyplanCount(vo.getDailyNo());
			dailyplanCountList.add(dailyplanCount);
		}
		System.out.println("???="+dailyplanCountList);
		
		model.addAttribute("dailyplanCountList", dailyplanCountList);
		
		return "plan/editplan";
	}
	
	@Autowired
	HttpSession httpSession;
	
	@Autowired
	PlanService planService;
	
	@GetMapping("/resultPlan")
	public String resultPlan(@ModelAttribute ResultPlanVO resultPlanVO, Model model) throws JsonProcessingException {
		System.out.println("계획 번호 : " + resultPlanVO.getPlannerNo());
		resultPlanVO.setMemberNo(1); // 테스트 용도 : 세션 적용 예정
		System.out.println("회원번호 : " + resultPlanVO.getMemberNo());
		
		List<ResultPlanVO> sendData = planService.selectPlan(resultPlanVO);
		
		// 자바 객체 JSON 변환 (작성자 : 정 계진)
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(sendData);
		
		System.out.println("전송 데이터 : " + jsonStr);
		model.addAttribute("list", jsonStr);
		
		return "plan/resultPlan";
	}
}
