package com.kh.finale.restcontroller.report;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.finale.entity.report.CommentReportDto;
import com.kh.finale.entity.report.PhotostoryReportDto;
import com.kh.finale.service.report.CommentReportService;
import com.kh.finale.service.report.PhotostoryReportService;

@RestController
@RequestMapping("/report_rest")
public class ReportRestController {
	
	@Autowired
	CommentReportService commentReportService;
	@Autowired
	PhotostoryReportService photostoryReportService;
	
	@RequestMapping("/c_report")
	public void cReportInsert(
			@ModelAttribute CommentReportDto commentReportDto) {
		System.out.println(commentReportDto.getMemberNo());
		System.out.println(commentReportDto.getPhotostoryCommentNo());
		System.out.println(commentReportDto.getCReportReason());
		commentReportService.cReportInsert(commentReportDto);
	}
	
	@RequestMapping("/p_report")
	public void pReportInsert(
			@ModelAttribute PhotostoryReportDto photostoryReportDto) {
		System.out.println(photostoryReportDto.getMemberNo());
		System.out.println(photostoryReportDto.getPhotostoryNo());
		System.out.println(photostoryReportDto.getPReportReason());
		photostoryReportService.pReportInsert(photostoryReportDto);
	}
}
