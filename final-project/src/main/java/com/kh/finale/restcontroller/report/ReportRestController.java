package com.kh.finale.restcontroller.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.entity.photostory.PhotostoryCommentListDto;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.entity.photostory.PhotostoryPhotoDto;
import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.entity.report.PhotostoryReportDto;
import com.kh.finale.repository.photostory.PhotostoryCommentListDao;
import com.kh.finale.repository.photostory.PhotostoryListDao;
import com.kh.finale.repository.photostory.PhotostoryPhotoDao;
import com.kh.finale.service.report.CommentReportService;
import com.kh.finale.service.report.PhotostoryReportService;

@RestController
@RequestMapping("/report_rest")
public class ReportRestController {
	
	@Autowired
	private CommentReportService commentReportService;
	@Autowired
	private PhotostoryReportService photostoryReportService;
	@Autowired
	private PhotostoryCommentListDao photostoryCommentListDao;
	@Autowired
	private PhotostoryListDao photostoryListDao;
	@Autowired
	private PhotostoryPhotoDao photostoryPhotoDao;
	
	@RequestMapping("/c_report")
	public void cReportInsert(
			@ModelAttribute CommentReportDto commentReportDto) {
		commentReportService.cReportInsert(commentReportDto);
	}
	
	@RequestMapping("/p_report")
	public void pReportInsert(
			@ModelAttribute PhotostoryReportDto photostoryReportDto) {
		photostoryReportService.pReportInsert(photostoryReportDto);
	}
	
	@RequestMapping("/get_comment")
	public PhotostoryCommentListDto getComment(int reportNo) {
		return photostoryCommentListDao.getReportComment(reportNo);
	}
	
	@RequestMapping("/get_story")
	public Map<String,Object> getStory(int reportNo) {
		PhotostoryListDto photostoryListDto = photostoryListDao.getReportStory(reportNo);
		List<PhotostoryPhotoDto> photostoryPhotoList = photostoryPhotoDao.get(photostoryListDto.getPhotostoryNo());
		Map<String,Object> map = new HashMap<>();
		map.put("story", photostoryListDto);
		map.put("imgList", photostoryPhotoList);
		return map;
	}
	
	
	@RequestMapping("/delete_p_report")
	public void deletePhotoReport(int reportNo) {
		photostoryReportService.delete(reportNo);
	}
	
	@RequestMapping("/delete_c_report")
	public void deleteCommentReport(int reportNo) {
		commentReportService.delete(reportNo);
	}
}













