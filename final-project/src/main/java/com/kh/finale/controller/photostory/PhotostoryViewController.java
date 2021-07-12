package com.kh.finale.controller.photostory;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.entity.photostory.PhotostoryDto;
import com.kh.finale.repository.photostory.PhotostoryDao;
import com.kh.finale.vo.photostory.PhotostoryVO;

@Controller
@RequestMapping("/photostory")
public class PhotostoryViewController {

	@Autowired
	PhotostoryDao photostoryDao;
	
	// 포토스토리 리스트 페이지
	@GetMapping("")
	public String home(@ModelAttribute PhotostoryVO photostoryVO, Model model) {
		photostoryVO = photostoryDao.getPageVariable(photostoryVO);
		List<PhotostoryDto> list = photostoryDao.list(photostoryVO);

		model.addAttribute("photostoryVO", photostoryVO);
		model.addAttribute("list", list);
		
		return "photostory/photostory";
	}
	
	// 포토스토리 작성 페이지
	@GetMapping("/write")
	public String write() {
		return "photostory/write";
	}
	
	// 포토스토리 작성 처리
	@PostMapping("/write")
	public String write(@ModelAttribute PhotostoryDto photostoryDto, HttpSession session) {
//		int memberNo = (int) session.getAttribute("memberNo");
		int memberNo = 1; // 임시
		photostoryDto.setMemberNo(memberNo);
		photostoryDto.setPlannerNo(1); // 임시
		
		photostoryDao.write(photostoryDto);
		
		return "redirect:/photostory";
	}
}
