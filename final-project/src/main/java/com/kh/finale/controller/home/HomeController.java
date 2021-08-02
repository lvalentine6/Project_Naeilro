package com.kh.finale.controller.home;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;

@Controller
public class HomeController {
	
	@Autowired
	private MemberDao memberDao;
	
	@RequestMapping("/")
	public String index(Model model, HttpSession session) {
		// 회원 정보 전송
		if (session.getAttribute("memberNo") != null) {
			MemberDto memberDto = memberDao.findInfo((int) session.getAttribute("memberNo"));
			model.addAttribute("memberDto", memberDto);
		}
		
		return "home";
	}



}
