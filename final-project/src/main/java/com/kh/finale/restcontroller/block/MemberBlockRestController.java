package com.kh.finale.restcontroller.block;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.entity.block.MemberBlockDto;
import com.kh.finale.service.block.MemberBlockService;

@RestController
@RequestMapping("/member_block")
public class MemberBlockRestController {

	@Autowired
	private MemberBlockService memberBlockService;
	
	// 회원 정지 처리
	@PostMapping("/block")
	public void block(@ModelAttribute MemberBlockDto memberBlockDto) {
		memberBlockService.block(memberBlockDto);
	}
	
	// 회원 정지 해제 처리
	@PostMapping("/unblock")
	public void unblock(@RequestParam int memberNo) {
		memberBlockService.unblock(memberNo);
	}
}
