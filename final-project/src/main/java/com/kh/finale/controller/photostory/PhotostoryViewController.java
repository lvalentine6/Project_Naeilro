package com.kh.finale.controller.photostory;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.finale.entity.photostory.PhotostoryCommentListDto;
import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.entity.photostory.PhotostoryLikeDto;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.repository.photostory.PhotostoryCommentListDao;
import com.kh.finale.repository.photostory.PhotostoryDao;
import com.kh.finale.repository.photostory.PhotostoryLikeDao;
import com.kh.finale.repository.photostory.PhotostoryListDao;
import com.kh.finale.service.photostory.PhotostoryService;
import com.kh.finale.vo.photostory.PhotostoryListVO;
import com.kh.finale.vo.photostory.PhotostoryVO;

@Controller
@RequestMapping("/photostory")
public class PhotostoryViewController {

	@Autowired
	PhotostoryDao photostoryDao;
	
	@Autowired
	PhotostoryListDao photostoryListDao;

	@Autowired
	PhotostoryCommentListDao photostoryCommentListDao;
	
	@Autowired
	PhotostoryLikeDao photostoryLikeDao;
	
	@Autowired
	PhotostoryService photostoryService;

	// 포토스토리 리스트 페이지
	@GetMapping("")
	public String home(@ModelAttribute PhotostoryListVO photostoryListVO, Model model, HttpSession session) {
		photostoryListVO = photostoryDao.getPageVariable(photostoryListVO);
		List<PhotostoryListDto> photostoryList = photostoryListDao.list(photostoryListVO);
		
		int memberNo = 0;
		if (session.getAttribute("memberNo") != null) {
			memberNo = (int) session.getAttribute("memberNo");
		}
		
		for (int i = 0; i < photostoryList.size(); i++) {
			// 좋아요 처리
			PhotostoryLikeDto photostoryLikeDto = PhotostoryLikeDto.builder()
					.photostoryNo(photostoryList.get(i).getPhotostoryNo())
					.memberNo(memberNo)
					.build();
			Boolean isLike = photostoryLikeDao.checkPhotostoryLike(photostoryLikeDto);
			if (isLike != null) {
				photostoryList.get(i).setIsLike(isLike);
			}
			
			// 댓글 처리
			List<PhotostoryCommentListDto> recentCommentList = 
					photostoryCommentListDao.recentList(photostoryList.get(i).getPhotostoryNo());
			for (int j = 0; j < recentCommentList.size(); j++) {
				photostoryList.get(i).setPhotostoryCommentList(recentCommentList);
			}
		}

		model.addAttribute("photostoryList", photostoryList);
		
		return "photostory/photostory";
	}
	
	// 포토스토리 상세 페이지
	@GetMapping("/detail")
	public String detail(@RequestParam int photostoryNo, Model model) {
		PhotostoryListDto photostoryListDto = photostoryListDao.get(photostoryNo);
		List<PhotostoryCommentListDto> photostoryCommentList = photostoryCommentListDao.list(photostoryNo);
		
		model.addAttribute("photostoryListDto", photostoryListDto);
		model.addAttribute("photostoryCommentList", photostoryCommentList);
		
		return "photostory/detail";
	}
	
	// 포토스토리 작성 페이지
	@GetMapping("/write")
	public String write() {
		return "photostory/write";
	}
	
	// 포토스토리 작성 처리
	@PostMapping("/write")
	public String write(@ModelAttribute PhotostoryVO photostoryVO,
			HttpSession session) throws IllegalStateException, IOException {
		int memberNo = (int) session.getAttribute("memberNo");
		photostoryVO.setMemberNo(memberNo);
		photostoryVO.setPlannerNo(1); // 임시
		
		photostoryService.insertPhotostory(photostoryVO);
		
		return "redirect:/photostory";
	}
	
	// 포토스토리 수정 페이지?
	
	// 포토스토리 수정 처리
	@PostMapping("/edit")
	public String edit(@ModelAttribute PhotostoryDto photostoryDto, HttpSession session) {
		int memberNo = (int) session.getAttribute("memberNo");
		photostoryDto.setMemberNo(memberNo);
		photostoryDto.setPlannerNo(1); // 임시
		
		photostoryDao.updatePhotostory(photostoryDto);
		
		return "redirect:/photostory";
	}
	
	// 포토스토리 삭제 처리
	@GetMapping("/delete")
	public String delete(@RequestParam int photostoryNo) {
		photostoryDao.deletePhotostory(photostoryNo);
		
		return "redirect:/photostory";
	}
}
