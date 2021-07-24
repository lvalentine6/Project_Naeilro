package com.kh.finale.controller.report;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.finale.entity.report.CommentReportDto;

@Controller
@RequestMapping("/report")
public class ReportController {
	
//	@Autowired
//	CommentReportDto commentReportDto;
	
	// 포토스토리 신고
	@GetMapping("/pReport")
	public String pReaport() {
		return "report/pReport";
	}
	
	// 포토스토리 신고 등록
	@PostMapping("/pReport") 
	public CommentReportDto pReport() {
		return null;
	}
	
	// 댓글 신고
	@GetMapping("/cReport")
	public String cReport() {
		return "report/cReport";
	}
}
