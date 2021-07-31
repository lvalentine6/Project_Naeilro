package com.kh.finale.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.finale.repository.report.CommentReportDao;
import com.kh.finale.repository.report.PhotostoryReportDao;
import com.kh.finale.service.report.CommentReportService;
import com.kh.finale.service.report.PhotostoryReportService;
import com.kh.finale.vo.report.PageVo;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	private CommentReportService commentReportService;
	@Autowired
	private PhotostoryReportService photostoryReportService;
	@Autowired
	private CommentReportDao commentReportDao;
	@Autowired
	private PhotostoryReportDao photostoryReportDao;
	
	// 관리자 페이지
	@RequestMapping("/")
	public String home(Model model) {
		return "admin/home";
	} 
	// 관리자 페이지
	@RequestMapping("/comment")
	public String comment(Model model,
			@RequestParam(required = false) Integer pageNo) {
		if(pageNo == null) {
			pageNo=1;
		}
		PageVo pageVo = new PageVo();
		pageVo=pageVo.getPageVariable(pageNo, 10, commentReportDao.getCount());
		
		model.addAttribute("page",pageVo);
		model.addAttribute("reportList",commentReportService.getList(pageNo));
		
		return "admin/comment";
	} 
	// 관리자 페이지
	@RequestMapping("/photostory")
	public String photostory(Model model,
			@RequestParam(required = false) Integer pageNo) {
		if(pageNo == null) {
			pageNo=1;
		}
		PageVo pageVo = new PageVo();
		pageVo=pageVo.getPageVariable(pageNo, 10, photostoryReportDao.getCount());
		
		model.addAttribute("page",pageVo);
		model.addAttribute("reportList",photostoryReportService.getList(pageNo));
		return "admin/photostory";
	} 
	// 관리자 페이지
	@RequestMapping("/member")
	public String member(Model model) {
		return "admin/member";
	} 
}
