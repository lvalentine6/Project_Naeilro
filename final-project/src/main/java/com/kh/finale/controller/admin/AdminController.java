package com.kh.finale.controller.admin;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.finale.repository.member.MemberDao;
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
	@Autowired
	private MemberDao memberDao;
	// 관리자 페이지
	@RequestMapping("/")
	public String home(Model model,
			@RequestParam(required = false) Integer pageNo,
			@RequestParam(required = false) String  type) {
		if(pageNo == null) {
			pageNo=1;
		}
		PageVo pageVo = new PageVo();
		

		if(type==null||type.equals("all")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, memberDao.getCount());
			model.addAttribute("memberList",memberDao.list(pageVo));
		}else if(type.equals("Y")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, memberDao.getBlockCount());
			model.addAttribute("memberList",memberDao.blockList(pageVo));
		}else if(type.equals("N")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, memberDao.getUnBlockCount());
			model.addAttribute("memberList",memberDao.unblockList(pageVo));
		}
		model.addAttribute("type",type);
		model.addAttribute("page",pageVo);
		return "admin/member";
	} 
	// 관리자 페이지
	@RequestMapping("/comment")
	public String comment(Model model,
			@RequestParam(required = false) Integer pageNo,
			@RequestParam(required = false) String  type
			) {
		if(pageNo == null) {
			pageNo=1;
		}
		PageVo pageVo = new PageVo();
		model.addAttribute("page",pageVo);
		
		if(type==null||type.equals("all")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, commentReportDao.getCount());
			model.addAttribute("reportList",commentReportService.getList(pageNo));
		}else if(type.equals("Y")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, commentReportDao.getCount());
			model.addAttribute("reportList",commentReportService.getYList(pageNo));
		}else if(type.equals("N")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, commentReportDao.getCount());
			model.addAttribute("reportList",commentReportService.getNList(pageNo));
		}
		model.addAttribute("page",pageVo);
		model.addAttribute("type",type);
		return "admin/comment";
	} 
	// 관리자 페이지
	@RequestMapping("/photostory")
	public String photostory(Model model,
			@RequestParam(required = false) Integer pageNo,
			@RequestParam(required = false) String  type) {
		if(pageNo == null) {
			pageNo=1;
		}
		PageVo pageVo = new PageVo();
		
		if(type==null||type.equals("all")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, photostoryReportDao.getCount());
			model.addAttribute("reportList",photostoryReportService.getList(pageNo));
		}else if(type.equals("Y")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, photostoryReportDao.getYCount());
			model.addAttribute("reportList",photostoryReportService.getYList(pageNo));
		}else if(type.equals("N")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, photostoryReportDao.getNCount());
			model.addAttribute("reportList",photostoryReportService.getNList(pageNo));
		}
		model.addAttribute("page",pageVo);
		model.addAttribute("type",type);
		return "admin/photostory";
	} 
	// 관리자 페이지
	@RequestMapping("/member")
	public String member(Model model,
			@RequestParam(required = false) Integer pageNo,
			@RequestParam(required = false) String  type) {
		if(pageNo == null) {
			pageNo=1;
		}
		PageVo pageVo = new PageVo();
		

		if(type==null||type.equals("all")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, memberDao.getCount());
			model.addAttribute("memberList",memberDao.list(pageVo));
		}else if(type.equals("Y")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, memberDao.getBlockCount());
			model.addAttribute("memberList",memberDao.blockList(pageVo));
		}else if(type.equals("N")) {
			pageVo=pageVo.getPageVariable(pageNo, 10, memberDao.getUnBlockCount());
			model.addAttribute("memberList",memberDao.unblockList(pageVo));
		}
		model.addAttribute("type",type);
		model.addAttribute("page",pageVo);
		return "admin/member";
	} 
	
	// 관리자 페이지
	@RequestMapping("/report_detail")
	public String detail(Model model,
			@RequestParam(required = false) int memberNo) {
		model.addAttribute("reportPList",photostoryReportDao.getMemberPList(memberNo));
		model.addAttribute("reportCList",commentReportDao.getMemberPList(memberNo));
		return "admin/report_detail";
	} 
}
