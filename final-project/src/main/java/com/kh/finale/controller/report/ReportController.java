package com.kh.finale.controller.report;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/report")
public class ReportController {
	
	// 포토스토리 신고
	@GetMapping("/pReport")
	public String pReaport() {
		return "pReport";
	}
	
	// 댓글 신고
	@GetMapping("/cReport")
	public String cReport() {
		return "cReport";
	}
}
