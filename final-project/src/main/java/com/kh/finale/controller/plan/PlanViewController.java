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
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.entity.photostory.PhotostoryPhotoDto;
import com.kh.finale.entity.plan.PlanListDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.repository.photostory.PhotostoryListDao;
import com.kh.finale.repository.photostory.PhotostoryPhotoDao;
import com.kh.finale.repository.plan.DailyDao;
import com.kh.finale.repository.plan.DailyplanDao;
import com.kh.finale.repository.plan.PlanListDao;
import com.kh.finale.repository.plan.PlannerDao;
import com.kh.finale.service.plan.PlanService;
import com.kh.finale.vo.plan.FindPhotoVO;
import com.kh.finale.vo.plan.PlanInsertServiceVO;
import com.kh.finale.vo.plan.ResultPlanVO;
import com.kh.finale.vo.report.PageVo;

@Controller
@RequestMapping("/plan")
public class PlanViewController {


	@Autowired
	private PlanService planService;

	@Autowired
	private PlanListDao planListDao;

	@Autowired
	private DailyDao dailyDao;

	@Autowired
	private DailyplanDao dailyplanDao;

	@Autowired
	private PlannerDao plannerDao;

	@Autowired
	MemberDao memberDao;
	
	// 상세 페이지
	@Autowired
	private HttpSession httpSession;
	
	@Autowired
	private PhotostoryPhotoDao photostoryPhotoDao;
	
	@Autowired
	private PhotostoryListDao photostoryListDao;
	
	@RequestMapping("")
	public String home(Model model,@RequestParam(required = false) Integer pageNo, HttpSession session) {
		if(pageNo == null) {
			pageNo=1;
		}
		
		// 회원 정보 전송
		if (session.getAttribute("memberNo") != null) {
			MemberDto memberDto = memberDao.findInfo((int) session.getAttribute("memberNo"));
			model.addAttribute("memberDto", memberDto);
		}
		
		PageVo pageVo = new PageVo();
		pageVo=pageVo.getPageVariable(pageNo, 12, plannerDao.getCount());
		model.addAttribute("planList", plannerDao.getPlanList(pageVo));
		model.addAttribute("page",pageVo);
		return "plan/planList";
	}
	
	// 계획표 작성 페이지
	@GetMapping("/writeplan")
	public String writePlan(Model model, HttpSession session) {
		if (session.getAttribute("memberNo") != null) {
			MemberDto memberDto = memberDao.findInfo((int) session.getAttribute("memberNo"));
			model.addAttribute("memberDto", memberDto);
		}
		return "plan/writeplan";
	}

	// 계획표 수정 페이지
	@GetMapping("/editplan")
	public String editPlan(@RequestParam int plannerNo, Model model, HttpSession session) {
		if (session.getAttribute("memberNo") != null) {
			MemberDto memberDto = memberDao.findInfo((int) session.getAttribute("memberNo"));
			model.addAttribute("memberDto", memberDto);
		}
		List<PlanListDto> planList = planListDao.getPlanList(plannerNo);
		model.addAttribute("planList", planList);

		List<PlanInsertServiceVO> dailyList = dailyDao.getDailyList(plannerNo);
		List<Integer> dailyplanCountList = new ArrayList<>();
		for (PlanInsertServiceVO vo : dailyList) {
			int dailyplanCount = dailyplanDao.getDailyplanCount(vo.getDailyNo());
			dailyplanCountList.add(dailyplanCount);
		}

		model.addAttribute("dailyplanCountList", dailyplanCountList);

		return "plan/editplan";
	}
	
	

	@GetMapping("/resultPlan")
	public String resultPlan(@ModelAttribute ResultPlanVO resultPlanVO, Model model, FindPhotoVO findPhotoVO, HttpSession session)
			throws JsonProcessingException {
		if (session.getAttribute("memberNo") != null) {
			MemberDto memberDto = memberDao.findInfo((int) session.getAttribute("memberNo"));
			model.addAttribute("memberDto", memberDto);
		}
		resultPlanVO.setMemberNo((int) httpSession.getAttribute("memberNo"));
		List<PhotostoryListDto> photostoryList = photostoryListDao.planList(resultPlanVO.getPlannerNo());
		
		for (int i = 0; i < photostoryList.size(); i++) {
			PhotostoryListDto photostoryListDto = photostoryList.get(i);
		// 포토스토리 이미지 처리 
			List<PhotostoryPhotoDto> photostoryPhotoList = photostoryPhotoDao.get(photostoryListDto.getPhotostoryNo());
			if(!photostoryPhotoList.isEmpty()) {
			photostoryListDto.setPhotostoryPhotoNo(photostoryPhotoList.get(0).getPhotostoryPhotoNo());
			}
		}
		
		List<ResultPlanVO> sendData = planService.selectPlan(resultPlanVO);

		Collections.sort(sendData, new Comparator<ResultPlanVO>() {
			@Override
			public int compare(ResultPlanVO o1, ResultPlanVO o2) {
				if (o1.getDailyOrder() > o2.getDailyOrder())
					return 1;
				if (o1.getDailyOrder() < o2.getDailyOrder())
					return -1;
				return 0;
			}
		});
		model.addAttribute("list", sendData);
		model.addAttribute("photoStroyList", photostoryList);
		if(photostoryList.size()!=0) {
			model.addAttribute("plannerNo", photostoryList.get(0).getPlannerNo());
		}
		ObjectMapper mapper = new ObjectMapper();
		String jsonStr = mapper.writeValueAsString(sendData);
		model.addAttribute("jlist", jsonStr);
		return "plan/resultPlan";
	}

	// 이미지 다운로드 처리
	@GetMapping("/resultPlan/image")
	public ResponseEntity<ByteArrayResource> download(@PathVariable int plannerNo,
			@ModelAttribute FindPhotoVO findPhotoVO) throws IOException {
		FindPhotoVO sendPhoto = planService.selectPhoto(findPhotoVO);
		if (findPhotoVO == null) {
			return ResponseEntity.notFound().build();
		}

		File target = new File("D:/upload/kh5/photostory/", sendPhoto.getPhotostoryPhotoFilePath());
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);

		return ResponseEntity.ok().header(HttpHeaders.CONTENT_ENCODING, "UTF-8").body(resource);
	}

	// 계획표 삭제 처리
	@GetMapping("/deleteplan")
	public String deletePlan(@RequestParam int plannerNo) {
		plannerDao.plannerDelete(plannerNo);
		return "redirect:/";
	}
}