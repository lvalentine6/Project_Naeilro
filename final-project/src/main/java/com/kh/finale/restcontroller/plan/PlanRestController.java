package com.kh.finale.restcontroller.plan;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.entity.plan.DailyDto;
import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.PlaceDao;
import com.kh.finale.service.plan.PlanService;
import com.kh.finale.service.plan.PlannerService;
import com.kh.finale.vo.plan.PlaceListServiceVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.PlannerInsertVO;

@RestController
@RequestMapping("/plan/data")
public class PlanRestController {
	
	@Autowired
	private PlannerService plannerService;
	
	@Autowired
	private PlanService planService;
	
	@Autowired
	private DailyDao dailyDao;
	
	@Autowired
	private PlaceDao placeDao;
	
	@PostMapping("/plannerInsert") 
	public int plannerInsert(@ModelAttribute PlannerInsertVO plannerInsertVO) {
		
		// 컨트롤러 테스트 : 회원번호 임시 세팅
		plannerInsertVO.setMemberNo(45);
		
		int plannerNo = plannerService.plannerInsertService(plannerInsertVO);
		
		return plannerNo;
	}
	
	@PostMapping("/planInsertService")
	public void planInsertService(@ModelAttribute PlanInsertServiceVO planInsertServiceVO) {
		planService.planInsertService(planInsertServiceVO);
	}
	
	@GetMapping("/dailyListService")
	public List<DailyDto> dailyListService(@RequestParam int plannerNo) {
		return dailyDao.dailyListService(plannerNo);
	}
	
	@GetMapping("/placeListService")
	public List<PlaceListServiceVO> placeListService(@RequestParam int dailyNo){
		return placeDao.placeListService(dailyNo);
	}
	
}
