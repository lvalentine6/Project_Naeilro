package com.kh.finale.controller.member;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

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
	
	// Login 페이지
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}
	
	// Login 처리
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto,
			HttpSession httpSession) {
		MemberDto check = memberDao.login(memberDto);
		if(check != null) {
			httpSession.setAttribute("memberNo", check.getMemberNo());
			httpSession.setAttribute("memberId", check.getMemberId());
			httpSession.setAttribute("memberContextNick", check.getMemberNick());
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
		httpSession.removeAttribute("memberId");
		httpSession.removeAttribute("memberContextNick");
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
	public Map<String, Object> findPw(@ModelAttribute MemberVo memberVo) throws MessagingException, UnsupportedEncodingException {
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
	
	// 비밀번호 찾기 (반환값 전송)
	@PostMapping("checkAuthEmail")
	@ResponseBody
	public ModelAndView checkAuthEmail(@ModelAttribute MemberAuthDto memberAuthDto) {
		ModelAndView mav = new ModelAndView("jsonView");
		System.out.println("폼 수신값 : " + memberAuthDto);
		MemberAuthDto checkData = memberFindService.checkAuthEmail(memberAuthDto);
		System.out.println("인증 결과 리턴 : " + checkData);
		if(checkData == null) {
			mav.setView(new MappingJackson2JsonView());
			mav.addObject("memberId", memberAuthDto.getMemberId());
			mav.setViewName("null");
			return mav;
		}
		else {
			mav.setViewName("member/changePw");
			mav.addObject("checkData",checkData);
			System.out.println("Mav값 확인 : " + mav);
			return mav; 
		}
	}
	
	// 비밀번호 찾기 (변경 페이지 이동)
	@GetMapping("/changePw")
	public String changePw(@ModelAttribute MemberAuthDto memberAuthDto, Model model){
		System.out.println("인증페이지 수신값 : " + memberAuthDto);
		MemberAuthDto selectMember = memberAuthService.selectId(memberAuthDto);
		System.out.println("db 수신 값 : " + selectMember);
			model.addAttribute("memberId", selectMember.getMemberId());
			return "member/changePw";
	}
	// 비밀번호 찾기 (변경 후 메인페이지 리다이렉트)
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto){
		System.out.println("리다이렉트 전 검사 : " + memberDto);
		memberAuthService.updatePw(memberDto);
		return "redirect:/";
	}
	
}
