package com.kh.finale.controller.plan;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.entity.photostory.PhotostoryPhotoDto;
import com.kh.finale.entity.plan.PlanListDto;
import com.kh.finale.repository.photostory.PhotostoryListDao;
import com.kh.finale.repository.photostory.PhotostoryPhotoDao;
import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlanListDao;
import com.kh.finale.service.plan.PlanService;
import com.kh.finale.vo.plan.FindPhotoVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;

@Controller
@RequestMapping("/plan")
public class PlanViewController {
	
	@Autowired
	HttpSession session;
	
	@Autowired
	PlanService planService;
	
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
	private HttpSession httpSession;
	@Autowired
	private PhotostoryPhotoDao photostoryPhotoDao;
	@Autowired
	private PhotostoryListDao photostoryListDao;
	
	@GetMapping("/resultPlan")
	public String resultPlan(@ModelAttribute ResultPlanVO resultPlanVO, Model model, FindPhotoVO findPhotoVO) throws JsonProcessingException {
		System.out.println("계획 번호 : " + resultPlanVO.getPlannerNo());
		resultPlanVO.setMemberNo((int) httpSession.getAttribute("memberNo"));
		System.out.println("회원번호 : " + resultPlanVO.getMemberNo());
		List<PhotostoryListDto> photostoryListDto = photostoryListDao.planList(resultPlanVO.getPlannerNo());
		
		
		
		/*
		 * // 포토스토리 이미지 처리 List<PhotostoryPhotoDto> photostoryPhotoList =
		 * photostoryPhotoDao.get(photostoryListDto.getPhotostoryNo()); if
		 * (!photostoryPhotoList.isEmpty()) {
		 * photostoryListDto.setPhotostoryphotoNo(photostoryPhotoList.get(0).
		 * getPhotostoryPhotoNo()); }
		 */
		
		List<ResultPlanVO> sendData = planService.selectPlan(resultPlanVO);
		
		Collections.sort(sendData,new Comparator<ResultPlanVO>() {
			@Override
			public int compare(ResultPlanVO o1, ResultPlanVO o2) {
				if(o1.getDailyOrder()>o2.getDailyOrder()) return 1;
				if(o1.getDailyOrder()<o2.getDailyOrder()) return -1;
				return 0;
			}
		});
		
		model.addAttribute("list", sendData);
		
		return "plan/resultPlan";
	}
	
	// 이미지 다운로드 처리
	@GetMapping("/resultPlan/image")
	public ResponseEntity<ByteArrayResource> download(@PathVariable int plannerNo, @ModelAttribute FindPhotoVO findPhotoVO) throws IOException {
		FindPhotoVO sendPhoto = planService.selectPhoto(findPhotoVO);
		System.out.println("이미지 반환값 : " + sendPhoto);
		if (findPhotoVO == null) {
			System.out.println("NOT FOUND");
			return ResponseEntity.notFound().build();
		}
		System.out.println("FOUND");
		
		File target = new File("D:/upload/kh5/photostory/", sendPhoto.getPhotostoryPhotoFilePath());
		System.out.println("타겟 : " + target);
		byte[] data = FileUtils.readFileToByteArray(target);
		System.out.println("데이터 : " + data);
		ByteArrayResource resource = new ByteArrayResource(data);
		System.out.println("리소스 : " + resource);
		
		return ResponseEntity.ok()
							 .header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
							.body(resource);
	}
	
	
}