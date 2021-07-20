package com.kh.finale.restcontroller.member;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.entity.member.FollowDto;
import com.kh.finale.repository.member.FollowDao;


@RestController
@RequestMapping("/memberprocess")
public class MemberRestController {

	@Autowired
	private FollowDao followDao;
	
	
	// 포토스토리 좋아요 등록 처리
	@GetMapping("/insert_follow")
	public void likePhotostory(HttpSession session, @RequestParam int followTo) {
		FollowDto followDto = FollowDto.builder()
				.followFrom((int) session.getAttribute("memberNo"))
				.followTo(followTo)
				.build();
		System.out.println(followDto.getFollowFrom());
		System.out.println(followDto.getFollowTo());
		followDao.insert(followDto);
	}

	// 포토스토리 좋아요 삭제 처리
	@GetMapping("/delete_follow")
	public void unlikePhotostory(HttpSession session, @RequestParam int followTo) {
		FollowDto followDto = FollowDto.builder()
				.followFrom((int) session.getAttribute("memberNo"))
				.followTo(followTo)
				.build();
		followDao.delete(followDto);
	}
}
