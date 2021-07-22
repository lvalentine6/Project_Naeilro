package com.kh.finale.controller.home;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.entity.member.FollowDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.FollowDao;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String index() {
		return "home";
	}
	
	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private FollowDao followDao;
	@RequestMapping("/member/{memberNick}")
	public String myPage(@PathVariable String memberNick
			,Model model,HttpSession session) {
		MemberDto memberDto = sqlSession.selectOne("findWithNick",memberNick);
		model.addAttribute("memberDto",memberDto);
		
		boolean isFollow = false;
		
		if((Integer)session.getAttribute("memberNo")!=null) {
			FollowDto followDto = FollowDto.builder()
					.followFrom((Integer)session.getAttribute("memberNo"))
					.followTo(memberDto.getMemberNo())
					.build();
			if(followDao.isFollow(followDto)!=null) {
				isFollow=true;
			}
		}
		
		model.addAttribute("isFollow",isFollow);
		model.addAttribute("countFollower",followDao.getCountFollower(memberDto.getMemberNo()));
		model.addAttribute("countFollowing",followDao.getCountFollowing(memberDto.getMemberNo()));
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
