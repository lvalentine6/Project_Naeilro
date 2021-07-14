package com.kh.finale.restcontroller.photostory;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.entity.photostory.PhotostoryCommentDto;
import com.kh.finale.entity.photostory.PhotostoryLikeDto;
import com.kh.finale.repository.photostory.PhotostoryCommentDao;
import com.kh.finale.repository.photostory.PhotostoryDao;
import com.kh.finale.repository.photostory.PhotostoryLikeDao;

@RestController
@RequestMapping("/process")
public class PhotostoryRestController {

	@Autowired
	PhotostoryDao photostoryDao;

	@Autowired
	PhotostoryLikeDao photostoryLikeDao;
	
	@Autowired
	PhotostoryCommentDao photostoryCommentDao;
	
	// 포토스토리 좋아요 등록 처리
	@GetMapping("/insert_like")
	public int likePhotostory(HttpSession session, @RequestParam int photostoryNo) {
		PhotostoryLikeDto photostoryLikeDto = PhotostoryLikeDto.builder()
				.photostoryNo(photostoryNo)
				.memberNo((int) session.getAttribute("memberNo"))
				.build();
		photostoryLikeDao.insertPhotostoryLike(photostoryLikeDto);
		photostoryDao.refreshPhotostoryLikeCount(photostoryNo);
		
		return photostoryDao.getPhotostoryLikeCount(photostoryNo);
	}

	// 포토스토리 좋아요 삭제 처리
	@GetMapping("/delete_like")
	public int unlikePhotostory(HttpSession session, @RequestParam int photostoryNo) {
		PhotostoryLikeDto photostoryLikeDto = PhotostoryLikeDto.builder()
				.photostoryNo(photostoryNo)
				.memberNo((int) session.getAttribute("memberNo"))
				.build();
		photostoryLikeDao.deletePhotostoryLike(photostoryLikeDto);
		photostoryDao.refreshPhotostoryLikeCount(photostoryNo);
		
		return photostoryDao.getPhotostoryLikeCount(photostoryNo);
	}
	
	// 포토스토리 댓글 등록 처리
	@PostMapping("/insert_comment")
	public int insertPhotostoryComment(
			HttpSession session, @ModelAttribute PhotostoryCommentDto photostoryCommentDto) {
		photostoryCommentDao.insertPhotostoryComment(photostoryCommentDto);
		photostoryDao.refreshPhotostoryCommentCount(photostoryCommentDto.getPhotostoryNo());
		
		return 0;
	}
	
	// 포토스토리 댓글 수정 처리
	@PostMapping("/update_comment")
	public int updatePhotostoryComment(
			HttpSession session, @ModelAttribute PhotostoryCommentDto photostoryCommentDto) {
		
		return 0;
	}
	
	// 포토스토리 댓글 삭제 처리
	@PostMapping("/delete_comment")
	public int deletePhotostoryComment(
			HttpSession session, @ModelAttribute PhotostoryCommentDto photostoryCommentDto) {
		
		return 0;
	}
}
