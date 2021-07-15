package com.kh.finale.controller.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	@PostMapping("sendAuthEmail")
	@ResponseBody
	public Map<String, Object> findPw(@ModelAttribute MemberVo memberVo) {
		Map<String,Object> sendAuthEmail = new HashMap<>();
		System.out.println("폼 수신값 확인 : " + memberVo);
		MemberVo searchResult = memberFindService.findPw(memberVo);
		System.out.println("FindId 수신값 확인 : " + searchResult);
		
		MemberAuthDto authResult = memberAuthService.pwSendEmail(searchResult); 
		System.out.println("authResult 수신값 확인 : " + authResult);
		memberAuthService.authInsert(authResult);
		Map<String, Object> memberAuthDto = memberAuthService.resultAuth(authResult);
		System.out.println("마지막 값 확인 : " + memberAuthDto);
		return memberAuthDto;
		
	}
	
	// 비밀번호 찾기 (인증번호 검사)
//	@PostMapping("checkAuthEmail")
//	@ResponseBody
//	public Map<String, Object> checkAuthEmail(@ModelAttribute MemberAuthDto memberAuthDto) {
//		Map<String,Object> checkData = new HashMap<>();
//		System.out.println("폼 수신값 : " + memberAuthDto);
//		checkData = memberFindService.checkAuthEmail(memberAuthDto);
//		System.out.println("인증 결과 리턴 : " + checkData);
//		return checkData;
//	}
	
	@PostMapping("checkAuthEmail")
	@ResponseBody
	public ModelAndView checkAuthEmail(@ModelAttribute MemberAuthDto memberAuthDto) {
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("폼 수신값 : " + memberAuthDto);
		MemberAuthDto checkData = memberFindService.checkAuthEmail(memberAuthDto);
		System.out.println("인증 결과 리턴 : " + checkData);
		mav.setViewName("jsonView");
		mav.setViewName("member/changePw");
		mav.addObject("checkData",checkData);
		System.out.println("Mav값 확인 : " + mav);
		return mav;
	}
	
	@PostMapping("changePw")
	public String changePw(@ModelAttribute MemberDto memberDto){
		System.out.println("변경 페이지 : " + memberDto);
		return "redirect:member/changePw";
	}
	
	// 비밀번호 찾기 페이지 (새 비밀번호 입력)
//	@GetMapping("/changePw")
//	public String changePw() {
//		return "member/changePw";
//	}
}
