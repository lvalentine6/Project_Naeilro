package com.kh.finale.controller.home;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String index() {
		return "home";
	}
	
	@Autowired
	private SqlSession sqlSession;
	@RequestMapping("/member/{memberNick}")
	public String myPage(@PathVariable String memberNick
			,Model model) {
		model.addAttribute("memberDto",sqlSession.selectOne("findWithNick",memberNick));
		return "member/myPage";
	}
	
	@RequestMapping("/member/editProfile")
	public String editProfile() {
		return "member/editProfile";
	}
}