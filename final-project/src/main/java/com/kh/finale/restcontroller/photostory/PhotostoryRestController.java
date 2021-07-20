package com.kh.finale.restcontroller.photostory;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.entity.photostory.PhotostoryCommentDto;
import com.kh.finale.entity.photostory.PhotostoryCommentListDto;
import com.kh.finale.entity.photostory.PhotostoryLikeDto;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.entity.photostory.PhotostoryPhotoDto;
import com.kh.finale.repository.photostory.PhotostoryCommentDao;
import com.kh.finale.repository.photostory.PhotostoryCommentListDao;
import com.kh.finale.repository.photostory.PhotostoryDao;
import com.kh.finale.repository.photostory.PhotostoryLikeDao;
import com.kh.finale.repository.photostory.PhotostoryListDao;
import com.kh.finale.repository.photostory.PhotostoryPhotoDao;
import com.kh.finale.vo.photostory.PhotostoryListVO;

@RestController
@RequestMapping("/process")
public class PhotostoryRestController {

	@Autowired
	private PhotostoryDao photostoryDao;

	@Autowired
	private PhotostoryListDao photostoryListDao;

	@Autowired
	private PhotostoryLikeDao photostoryLikeDao;
	
	@Autowired
	private PhotostoryCommentDao photostoryCommentDao;

	@Autowired
	private PhotostoryCommentListDao photostoryCommentListDao;
	
	@Autowired
	private PhotostoryPhotoDao photostoryPhotoDao;
	
	// 포토스토리 리스트 조회
	@GetMapping("load")
	public List<PhotostoryListDto> load(@ModelAttribute PhotostoryListVO photostoryListVO, HttpSession session) {
		photostoryListVO = photostoryDao.getPageVariable(photostoryListVO);
		List<PhotostoryListDto> photostoryList = photostoryListDao.list(photostoryListVO);
		
		int memberNo = 0;
		if (session.getAttribute("memberNo") != null) {
			memberNo = (int) session.getAttribute("memberNo");
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
		}

		return photostoryList;
	}
	
	// 포토스토리 좋아요 등록 처리
	@GetMapping("/insert_like")
	public void likePhotostory(HttpSession session, @RequestParam int photostoryNo) {
		PhotostoryLikeDto photostoryLikeDto = PhotostoryLikeDto.builder()
				.photostoryNo(photostoryNo)
				.memberNo((int) session.getAttribute("memberNo"))
				.build();
		photostoryLikeDao.insertPhotostoryLike(photostoryLikeDto);
		photostoryDao.refreshPhotostoryLikeCount(photostoryNo);
	}

	// 포토스토리 좋아요 삭제 처리
	@GetMapping("/delete_like")
	public void unlikePhotostory(HttpSession session, @RequestParam int photostoryNo) {
		PhotostoryLikeDto photostoryLikeDto = PhotostoryLikeDto.builder()
				.photostoryNo(photostoryNo)
				.memberNo((int) session.getAttribute("memberNo"))
				.build();
		photostoryLikeDao.deletePhotostoryLike(photostoryLikeDto);
		photostoryDao.refreshPhotostoryLikeCount(photostoryNo);
	}
	
	// 포토스토리 댓글 등록 처리
	@PostMapping("/insert_comment")
	public void insertPhotostoryComment(
			HttpSession session, @ModelAttribute PhotostoryCommentDto photostoryCommentDto) {
		PhotostoryCommentDto commentDto = PhotostoryCommentDto.builder()
				.photostoryNo(photostoryCommentDto.getPhotostoryNo())
				.memberNo((int) session.getAttribute("memberNo"))
				.photostoryCommentContent(photostoryCommentDto.getPhotostoryCommentContent())
				.build();
		photostoryCommentDao.insertPhotostoryComment(commentDto);
		photostoryDao.refreshPhotostoryCommentCount(commentDto.getPhotostoryNo());
	}
	
	// 포토스토리 댓글 수정 처리
	@PostMapping("/update_comment")
	public void updatePhotostoryComment(
			HttpSession session, @ModelAttribute PhotostoryCommentDto photostoryCommentDto) {
		PhotostoryCommentDto commentDto = PhotostoryCommentDto.builder()
				.photostoryNo(photostoryCommentDto.getPhotostoryNo())
				.memberNo((int) session.getAttribute("memberNo"))
				.photostoryCommentContent(photostoryCommentDto.getPhotostoryCommentContent())
				.build();
		photostoryCommentDao.updatePhotostoryComment(commentDto);
	}
	
	// 포토스토리 댓글 삭제 처리
	@PostMapping("/delete_comment")
	public void deletePhotostoryComment(
			HttpSession session, @ModelAttribute PhotostoryCommentDto photostoryCommentDto) {
		PhotostoryCommentDto commentDto = PhotostoryCommentDto.builder()
				.photostoryNo(photostoryCommentDto.getPhotostoryNo())
				.memberNo((int) session.getAttribute("memberNo"))
				.photostoryCommentContent(photostoryCommentDto.getPhotostoryCommentContent())
				.build();
		photostoryCommentDao.deletePhotostoryComment(commentDto);
		photostoryDao.refreshPhotostoryCommentCount(commentDto.getPhotostoryNo());
	}
}
