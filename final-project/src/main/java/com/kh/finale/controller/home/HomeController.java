package com.kh.finale.controller.home;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.entity.block.MemberBlockDto;
import com.kh.finale.entity.member.FollowDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.photostory.PhotostoryCommentListDto;
import com.kh.finale.entity.photostory.PhotostoryLikeDto;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.entity.photostory.PhotostoryPhotoDto;
import com.kh.finale.repository.block.MemberBlockDao;
import com.kh.finale.repository.member.FollowDao;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.repository.photostory.PhotostoryCommentListDao;
import com.kh.finale.repository.photostory.PhotostoryDao;
import com.kh.finale.repository.photostory.PhotostoryLikeDao;
import com.kh.finale.repository.photostory.PhotostoryListDao;
import com.kh.finale.repository.photostory.PhotostoryPhotoDao;
import com.kh.finale.repository.plan.PlannerDao;
import com.kh.finale.vo.member.LikeFollowVo;
import com.kh.finale.vo.photostory.PhotostoryListVO;
import com.kh.finale.vo.report.PageVo;

@Controller
public class HomeController {
	
	@Autowired
	private MemberDao memberDao;
	@Autowired
	private PlannerDao plannerDao;
	@Autowired
	private PhotostoryListDao photostoryListDao;
	@Autowired
	private PhotostoryDao photostoryDao;
	@Autowired
	private PhotostoryLikeDao photostoryLikeDao;
	@Autowired
	private MemberBlockDao memberBlockDao;
	@Autowired
	private PhotostoryCommentListDao photostoryCommentListDao;
	@Autowired
	private PhotostoryPhotoDao photostoryPhotoDao;
	@Autowired
	private FollowDao followDao;
	
	@RequestMapping("/")
	public String index(Model model, HttpSession session) {
		// 회원 정보 전송
		if (session.getAttribute("memberNo") != null) {
			MemberDto memberDto = memberDao.findInfo((int) session.getAttribute("memberNo"));
			model.addAttribute("memberDto", memberDto);
		}
		PageVo pageVo = new PageVo();
		pageVo=pageVo.getPageVariable(1, 9, plannerDao.getCount());
		model.addAttribute("planList", plannerDao.getPlanList(pageVo));
		PhotostoryListVO photostoryListVO = new PhotostoryListVO();
		photostoryListVO.setPageNo(1);
		photostoryListVO = photostoryDao.getPageVariable(photostoryListVO);
		photostoryListVO.setPageSize(8);
		
		List<PhotostoryListDto> photostoryList = photostoryListDao.list(photostoryListVO);
		
		int memberNo = 0;
		if (session.getAttribute("memberNo") != null) {
			memberNo = (int) session.getAttribute("memberNo");
			MemberDto memberDto = memberDao.findInfo(memberNo);
			MemberBlockDto memberBlockDto = memberBlockDao.getBlockInfo(memberNo);
			
			model.addAttribute("memberDto", memberDto);
			model.addAttribute("memberBlockDto", memberBlockDto);
		}
		
		for (int i = 0; i < photostoryList.size(); i++) {
			PhotostoryListDto photostoryListDto = photostoryList.get(i);
			
			// 좋아요 처리
			PhotostoryLikeDto photostoryLikeDto = PhotostoryLikeDto.builder()
					.photostoryNo(photostoryListDto.getPhotostoryNo())
					.memberNo(memberNo)
					.build();
			Boolean isLike = photostoryLikeDao.checkPhotostoryLike(photostoryLikeDto);
			if (isLike != null) {
				photostoryListDto.setIsLike(isLike);
			}
			
			// 댓글 처리
			List<PhotostoryCommentListDto> recentCommentList = 
					photostoryCommentListDao.recentList(photostoryListDto.getPhotostoryNo());
			for (int j = 0; j < recentCommentList.size(); j++) {
				photostoryListDto.setPhotostoryCommentList(recentCommentList);
			}
			
			// 이미지 처리
			List<PhotostoryPhotoDto> photostoryPhotoList = photostoryPhotoDao.get(photostoryListDto.getPhotostoryNo());
			if (!photostoryPhotoList.isEmpty()) {
				photostoryListDto.setPhotostoryPhotoNo(photostoryPhotoList.get(0).getPhotostoryPhotoNo());
			}
			
			//좋아요 리스트 처리
			List<MemberDto> tlikeList = 
					photostoryLikeDao.getLikeList(photostoryListDto.getPhotostoryNo());
			
			List<LikeFollowVo> likeList = new ArrayList<>();
			for(MemberDto m : tlikeList) {
				LikeFollowVo lfv = LikeFollowVo.builder()
						.member(m)
						.isFollow(false)
						.build();
				likeList.add(lfv);
			}
			if((Integer)session.getAttribute("memberNo")!=null) {
				for(LikeFollowVo f : likeList) {
					FollowDto followDto = FollowDto.builder()
							.followFrom((Integer)session.getAttribute("memberNo"))
							.followTo(f.getMember().getMemberNo())
							.build();
					if(followDao.isFollow(followDto)!=null) {
						f.setFollow(true);
					}
				}
			}
			photostoryList.get(i).setPhotostoryLikeMemberList(likeList);
		}

		model.addAttribute("photostoryList", photostoryList);
		return "home";
	}



}
