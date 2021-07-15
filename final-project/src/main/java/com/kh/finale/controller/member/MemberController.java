package com.kh.finale.controller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.service.member.MemberAuthService;
import com.kh.finale.service.member.MemberFindService;
import com.kh.finale.service.member.MemberJoinService;
import com.kh.finale.vo.member.MemberVo;

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
		public ModelAndView findId(@ModelAttribute MemberDto memberDto) {
			ModelAndView mav = new ModelAndView();
			Object modelList = memberFindService.findId(memberDto);
			System.out.println(modelList);
			if(modelList == null) {
				mav.setViewName("member/findId");
				mav.addObject("memberDto", memberDto);
				return mav;
			}
			else {
				mav.setViewName("member/findId");
				mav.addObject("memberDto", modelList);
				return mav;
			}
		}
	

	// 비밀번호 찾기 페이지
	@GetMapping("/findPw")
	public String findPw() {
		return "member/findPw";
	}
	
	@Autowired
	MemberAuthService memberAuthService;
	
	@Autowired
	MemberAuthDto memberAuthDto;
	
	// 비밀번호 찾기 (인증번호 발송)
	@PostMapping("/sendAuthEamil")
	public ModelAndView findPw(@ModelAttribute MemberVo memberVo) {
		ModelAndView mav = new ModelAndView();
		System.out.println("폼 수신값 확인 : " + memberVo);
		Object searchResult = memberFindService.findPw(memberVo); // 문제없음
		System.out.println("FindId 수신값 확인 : " + searchResult);
		
//		if(searchResult == null) {
//			mav.setViewName("member/findId");
//			mav.addObject("memberVo", memberVo);
//			return mav;
//		}
//		else {
		Object authResult = memberAuthService.pwSendEmail(memberVo); // memberNo 값이 안넘어옴
		System.out.println("authResult 수신값 확인 : " + authResult);
		memberAuthService.authInsert(memberAuthDto); // 직접문제
		System.out.println("마지막 값 수신확인 : " + memberAuthDto);	
		mav.setViewName("member/findId");
		mav.addObject("memberVo", authResult);
		return mav;
//		}
		
	}
	
	
}
