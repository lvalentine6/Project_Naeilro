package com.kh.finale.controller.home;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.entity.member.MemberDto;

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
	@Autowired
	HttpSession httpSession;
	
	@RequestMapping("/member/editProfile")
	public String editProfile(Model model) {
		model.addAttribute("memberId", httpSession.getAttribute("memberId"));
		return "member/editProfile";
	}
}