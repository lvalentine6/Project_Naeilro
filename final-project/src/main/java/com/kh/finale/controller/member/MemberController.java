package com.kh.finale.controller.member;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.kh.finale.entity.member.MemberAuthDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.member.MemberProfileDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.repository.member.MemberProfileDao;
import com.kh.finale.service.member.MemberAuthService;
import com.kh.finale.service.member.MemberEditService;
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
	public String join(@ModelAttribute MemberVo memberVo) throws IllegalStateException, IOException {
		System.out.println("수신값 확인 : " + memberVo);
		memberJoinService.memberjoin(memberVo);
		return "redirect:join_success";
	}

	@GetMapping("/join_success")
	public String registSuccess() {
		return "member/joinSuccess";
	}

	// 회원 가입 아이디 중복체크
	@PostMapping("/idCheck")
	@ResponseBody
	public boolean idCheck(@ModelAttribute MemberVo memberVo) {
		System.out.println("아이디 중복값 체크 : " + memberVo);
		boolean idResult = memberFindService.idCheck(memberVo) > 0;
		System.out.println("아이디 체크값 반환 : " + idResult);
		return idResult;
	}
	
	// 회원가입 닉네임 중복체크
	@PostMapping("/jNickCheck")
	@ResponseBody
	public boolean jNickCheck(@ModelAttribute MemberVo memberVo) {
		System.out.println("닉네임 중복값 체크 : " + memberVo);
		boolean Nickresult = memberFindService.jNickCheck(memberVo) > 0;
		System.out.println("닉네임 체크값 반환 : " + Nickresult);
		return Nickresult;
	}

	// 프로필 편집 닉네임 중복체크
	@PostMapping("/pNickCheck")
	@ResponseBody
	public boolean pNickCheck(@ModelAttribute MemberVo memberVo, HttpSession httpSession) {
		System.out.println("닉네임 중복값 체크 : " + memberVo);
		MemberVo Nickresult = memberFindService.pNickCheck(memberVo);
		System.out.println("닉네임 체크값 반환 : " + Nickresult);
		MemberDto memberDto = memberDao.findInfo((int) httpSession.getAttribute("memberNo"));
		boolean result = false;
		if (ObjectUtils.isEmpty(Nickresult)) {
			result = false;
		} else {
			if (Nickresult.getMemberNick().equals(memberDto.getMemberNick())) {
				result = false;
			} else {
				result = true;
			}
		}
		System.out.println(result);
		return result;
	}

	// 로그인 페이지
	@GetMapping("/login")
	public String login() {
		return "member/login";
	}

	// 로그인 처리
	@PostMapping("/login")
	public String login(@ModelAttribute MemberDto memberDto, HttpSession httpSession) {
		MemberDto check = memberDao.login(memberDto);
		if (check != null) {
			httpSession.setAttribute("memberNo", check.getMemberNo());
			httpSession.setAttribute("memberId", check.getMemberId());
			httpSession.setAttribute("memberContextNick", check.getMemberNick());
			return "redirect:/";
		} else {
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
		if (modelList == null) {
			mav.setViewName("member/findId");
			mav.addObject("memberDto", memberDto);
			return mav;
		} else {
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
	public Map<String, Object> findPw(@ModelAttribute MemberVo memberVo)
			throws MessagingException, UnsupportedEncodingException {
		Map<String, Object> sendAuthEmail = new HashMap<>();
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
		if (checkData == null) {
			mav.setView(new MappingJackson2JsonView());
			mav.addObject("memberId", memberAuthDto.getMemberId());
			mav.setViewName("null");
			return mav;
		} else {
			mav.setViewName("member/changePw");
			mav.addObject("checkData", checkData);
			System.out.println("Mav값 확인 : " + mav);
			return mav;
		}
	}

	// 비밀번호 찾기 (변경 페이지 이동)
	@GetMapping("/changePw")
	public String changePw(@ModelAttribute MemberAuthDto memberAuthDto, Model model) {
		System.out.println("인증페이지 수신값 : " + memberAuthDto);
		MemberAuthDto selectMember = memberAuthService.selectId(memberAuthDto);
		System.out.println("db 수신 값 : " + selectMember);
		model.addAttribute("memberId", selectMember.getMemberId());
		return "member/changePw";
	}

	// 비밀번호 찾기 (변경 후 메인페이지 리다이렉트)
	@PostMapping("/edit")
	public String edit(@ModelAttribute MemberDto memberDto) {
		System.out.println("리다이렉트 전 검사 : " + memberDto);
		memberAuthService.updatePw(memberDto);
		return "redirect:/";
	}

	// 마이페이지 이미지 출력

	@Autowired
	MemberProfileDao memberProfileDao;

	@Autowired
	HttpSession httpSession;

	@GetMapping("/profileImage")
	public ResponseEntity<ByteArrayResource> image() throws IOException {
		String memberId = (String) httpSession.getAttribute("memberId");
		System.out.println("아이디 값 :" + memberId);
		MemberProfileDto memberProfileDto = memberProfileDao.find(memberId);
		if (memberProfileDto == null) {
			return ResponseEntity.notFound().build();
		}

		File target = new File("D:/upload/kh5/member", memberProfileDto.getProfileSaveName());
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);

		return ResponseEntity.ok().contentLength(memberProfileDto.getProfileSize())
				.header(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_OCTET_STREAM_VALUE)
				.header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""
						+ URLEncoder.encode(memberProfileDto.getProfileOriginName(), "UTF-8") + "\"")
				.body(resource);
	}

	@Autowired
	MemberEditService memberEditService;

	// 프로필 편집
	@PostMapping("/editProfile")
	public String editProfile(@ModelAttribute MemberVo memberVo, HttpSession httpSession) throws IllegalStateException, IOException {
		System.out.println("수신값 검사 : " + memberVo);
		memberVo.setMemberNo((int) httpSession.getAttribute("memberNo"));
		memberVo.setMemberId((String) httpSession.getAttribute("memberId"));
		System.out.println("세션값 적용 : " + memberVo);
		memberEditService.editProfile(memberVo);

		return "redirect:/";
	}

	// 회원 탈퇴
	@GetMapping("/exit")
	public String exit(HttpSession httpSession, MemberVo memberVo) {
		memberVo.setMemberId((String) httpSession.getAttribute("memberId"));
		memberEditService.exit(memberVo);
		memberEditService.exitProfile(memberVo);
		httpSession.removeAttribute("memberNo");
		httpSession.removeAttribute("memberId");
		return "member/exit";
	}

}
