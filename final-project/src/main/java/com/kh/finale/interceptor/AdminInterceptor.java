package com.kh.finale.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.finale.constant.MemberGradeConstant;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.member.MemberDao;

import lombok.extern.slf4j.Slf4j;

// 관리자 기능 접근 차단 인터셉터

@Slf4j
public class AdminInterceptor implements HandlerInterceptor {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Integer memberNo = (Integer) request.getSession().getAttribute("memberNo");
		
		MemberDto memberDto = memberDao.findInfo(memberNo);
		int memberGrade = memberDto.getMemberGrade();
		
		// 관리자가 아닐 경우
		if (memberGrade != MemberGradeConstant.ADMIN) {
			response.sendError(401);
			log.debug("인터셉터: AdminInterceptor 차단");
			
			return false;
		}
		
		return true;
	}
}
