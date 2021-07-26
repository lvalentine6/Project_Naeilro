package com.kh.finale.controller.photostory;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ByteArrayResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.finale.entity.block.MemberBlockDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.photostory.PhotostoryCommentListDto;
import com.kh.finale.entity.photostory.PhotostoryLikeDto;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.entity.photostory.PhotostoryPhotoDto;
import com.kh.finale.repository.block.MemberBlockDao;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.repository.photostory.PhotostoryCommentListDao;
import com.kh.finale.repository.photostory.PhotostoryDao;
import com.kh.finale.repository.photostory.PhotostoryLikeDao;
import com.kh.finale.repository.photostory.PhotostoryListDao;
import com.kh.finale.repository.photostory.PhotostoryPhotoDao;
import com.kh.finale.service.photostory.PhotostoryService;
import com.kh.finale.vo.photostory.PhotostoryListVO;
import com.kh.finale.vo.photostory.PhotostoryVO;

@Controller
@RequestMapping("/photostory")
public class PhotostoryViewController {

	@Autowired
	private PhotostoryDao photostoryDao;
	
	@Autowired
	private PhotostoryListDao photostoryListDao;

	@Autowired
	private PhotostoryCommentListDao photostoryCommentListDao;
	
	@Autowired
	private PhotostoryLikeDao photostoryLikeDao;
	
	@Autowired
	private PhotostoryService photostoryService;

	@Autowired
	private PhotostoryPhotoDao photostoryPhotoDao;
	
	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private MemberBlockDao memberBlockDao;

	// 포토스토리 리스트 페이지
	@GetMapping("")
	public String home(@ModelAttribute PhotostoryListVO photostoryListVO, Model model, HttpSession session) {
		photostoryListVO = photostoryDao.getPageVariable(photostoryListVO);
		List<PhotostoryListDto> photostoryList = photostoryListDao.list(photostoryListVO);
		
		// 회원 정보 및 회원 정지 정보 전송
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
		}

		model.addAttribute("photostoryList", photostoryList);
		
		return "photostory/photostory";
	}
	
	// 포토스토리 상세 페이지
	@GetMapping("/detail")
	public String detail(@RequestParam int photostoryNo, Model model, HttpSession session) {
		PhotostoryListDto photostoryListDto = photostoryListDao.get(photostoryNo);
		List<PhotostoryCommentListDto> photostoryCommentList = photostoryCommentListDao.list(photostoryNo);
		
		// 회원 정보 및 회원 정지 정보 전송
		int memberNo = 0;
		if (session.getAttribute("memberNo") != null) {
			memberNo = (int) session.getAttribute("memberNo");
			MemberDto memberDto = memberDao.findInfo(memberNo);
			MemberBlockDto memberBlockDto = memberBlockDao.getBlockInfo(memberNo);
			
			model.addAttribute("memberDto", memberDto);
			model.addAttribute("memberBlockDto", memberBlockDto);
		}
		
		// 이미지 리스트
		List<PhotostoryPhotoDto> photostoryPhotoList = photostoryPhotoDao.get(photostoryNo);
		
		// 좋아요 처리
		PhotostoryLikeDto photostoryLikeDto = PhotostoryLikeDto.builder()
				.photostoryNo(photostoryListDto.getPhotostoryNo())
				.memberNo(memberNo)
				.build();
		Boolean isLike = photostoryLikeDao.checkPhotostoryLike(photostoryLikeDto);
		if (isLike != null) {
			photostoryListDto.setIsLike(isLike);
		}
		
		model.addAttribute("photostoryListDto", photostoryListDto);
		model.addAttribute("photostoryCommentList", photostoryCommentList);
		model.addAttribute("photostoryPhotoList", photostoryPhotoList);
		
		return "photostory/detail";
	}
	
	// 포토스토리 작성 페이지
	@GetMapping("/write")
	public String write(HttpSession session, Model model) {
		// 회원 정보 전송
		if (session.getAttribute("memberNo") != null) {
			MemberDto memberDto = memberDao.findInfo((int) session.getAttribute("memberNo"));
			model.addAttribute("memberDto", memberDto);
		}
		
		return "photostory/write";
	}
	
	// 포토스토리 작성 처리
	@PostMapping("/write")
	public String write(@ModelAttribute PhotostoryVO photostoryVO,
			HttpSession session) throws IllegalStateException, IOException {
		int memberNo = (int) session.getAttribute("memberNo");
		photostoryVO.setMemberNo(memberNo);
		
		photostoryService.insertPhotostory(photostoryVO);
		
		return "redirect:/photostory";
	}
	
	// 포토스토리 수정 페이지
	@GetMapping("/edit")
	public String edit(@RequestParam int photostoryNo, Model model) {
		// 포토스토리 정보
		PhotostoryListDto photostoryListDto = photostoryListDao.get(photostoryNo);
		
		// 이미지 리스트
		List<PhotostoryPhotoDto> photostoryPhotoList = photostoryPhotoDao.get(photostoryNo);
		
		model.addAttribute("photostoryListDto", photostoryListDto);
		model.addAttribute("photostoryPhotoList", photostoryPhotoList);
		
		// 회원 정보 전송
		MemberDto memberDto = memberDao.findInfo(photostoryListDto.getMemberNo());
		model.addAttribute("memberDto", memberDto);
		
    	return "photostory/edit";
	}
	
	// 포토스토리 수정 처리
	@PostMapping("/edit")
	public String edit(@ModelAttribute PhotostoryVO photostoryVO,
			HttpSession session) throws IllegalStateException, IOException {
		int memberNo = (int) session.getAttribute("memberNo");
		photostoryVO.setMemberNo(memberNo);
		
		photostoryService.updatePhotostory(photostoryVO);
		
		return "redirect:/photostory/detail?photostoryNo=" + photostoryVO.getPhotostoryNo();
	}
	
	// 포토스토리 삭제 처리
	@GetMapping("/delete")
	public String delete(@RequestParam int photostoryNo) {
		photostoryService.deletePhotostory(photostoryNo);
		
		return "redirect:/photostory";
	}
	
	// 이미지 다운로드 처리
	@GetMapping("/photo/{photostoryPhotoNo}")
	public ResponseEntity<ByteArrayResource> download(@PathVariable int photostoryPhotoNo) throws IOException {
		PhotostoryPhotoDto photostoryPhotoDto = photostoryPhotoDao.getSingle(photostoryPhotoNo);
		
		if (photostoryPhotoDto == null) {
			return ResponseEntity.notFound().build();
		}
		
		File target = new File("D:/upload/kh5/photostory/", photostoryPhotoDto.getPhotostoryPhotoFilePath());
		byte[] data = FileUtils.readFileToByteArray(target);
		ByteArrayResource resource = new ByteArrayResource(data);
		
		return ResponseEntity.ok()
						 	 .contentLength(photostoryPhotoDto.getPhotostoryPhotoFileSize())
							 .header(HttpHeaders.CONTENT_ENCODING, "UTF-8")
							.body(resource);
	}
}
