package com.kh.finale.controller.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String index() {
		return "home";
	}
	@RequestMapping("/member/findId")
	public String findId() {
		return "member/findId";
	}
	@RequestMapping("/member/findPw")
	public String findPw() {
		return "member/findPw";
	}
	@RequestMapping("/member/changePw")
	public String changePw() {
		return "member/changePw";
	}
	@RequestMapping("/member/{memberNick}")
	public String myPage() {
		return "member/myPage";
	}
}