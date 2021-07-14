package com.kh.finale.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.service.member.MemberFindService;
import com.kh.finale.service.member.MemberJoinService;
import com.kh.finale.vo.member.MemberVo;

import sun.print.resources.serviceui;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberDao memberDao;
	
	// 회원 가입 페이지
	@GetMapping("/join")
	public String join() {
		return "member/join";
	}
	
	// 회원 가입 성공 페이지
//	@PostMapping("/join")
//	public String join(@ModelAttribute MemberDto memberDto) {
//		memberDao.join(memberDto);
//		return "redirect:join_success";
//	}
	
	@Autowired
	private MemberJoinService memberJoinService;
	
	@PostMapping("/join")
	public String join(@ModelAttribute MemberVo memberVo) {
		memberJoinService.memberjoin(memberVo);		
		return "redirect:join_success";
	}
	
	
	@GetMapping("/join_success")
	public String registSuccess() {
		return "member/joinSuccess";
	}
	
	// 로그인 페이지
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	// 로그인 처리
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto,
			HttpSession httpSession) {
		MemberDto check = memberDao.login(memberDto);
		if(check != null) {
			httpSession.setAttribute("memberNo", check.getMemberNo());
			return "redirect:/";
		}
		else {
			return "redirect:login?error";
		}
	}
	
	// 로그아웃 처리
	@GetMapping("/logout")
	public String logout(HttpSession httpSession) {
		httpSession.removeAttribute("memberNo");
		return "redirect:/";
	}
	
	// 아이디 찾기 페이지
	@GetMapping("/findId")
	public String findId() {
		return "member/findId";
	}
	
	@Autowired
	MemberFindService memberFindService;
	
	// 아이디 찾기 처리
	@PostMapping("/findId")
	public String findId(@ModelAttribute MemberDto memberDto, Model model) {
		model.addAttribute("memberDto1", memberFindService.findId(memberDto));
		System.out.println(model);
		return "member/findId";
	}

	// 비밀번호 찾기 페이지
	@GetMapping("/findPw")
	public String findPw() {
		return "member/findPw";
	}
	
	// 비밀번호 찾기 처리
//	@PostMapping("member/findPw")
//	public String findPw(ao aoao) {
//		return = null;
//	}
	
	
}
