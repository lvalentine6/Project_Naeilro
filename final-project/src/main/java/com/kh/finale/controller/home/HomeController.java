package com.kh.finale.controller.home;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String index() {
		return "home";
	}
	@RequestMapping("/member/{memberNick}")
	public String myPage() {
		return "member/myPage";
	}
	@RequestMapping("/member/editProfile")
	public String editProfile() {
		return "member/editProfile";
	}
}