package com.kh.finale.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.entity.MemberDto;
import com.kh.finale.repository.MemberDao;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberDao memberDao;
	
//	회원 가입 페이지
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
//	회원 가입 성공 페이지
	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto memberDto) {
		memberDao.join(memberDto);
		return "redirect:join_success";
	}
	
	@GetMapping("/join_success")
	public String registSuccess() {
		return "member/joinSuccess";
	}
	
	
	
}
