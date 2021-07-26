package com.kh.finale.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

/**
 * 비회원의 회원 기능 접근 차단 인터셉터
 * @author swjk78
 */
@Slf4j
public class MemberLoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Integer memberNo = (Integer) request.getSession().getAttribute("memberNo");
		
		// 비로그인 상태일 때 처리
		if (memberNo == null) {
			// 어느 페이지로 보낼지, 보낸 후 어떤 알림창을 띄울 것인지 미정
			response.sendRedirect(request.getContextPath() + "/member/login");
			log.debug("인터셉터: MemberLoginInterceptor 차단");
			
			return false;
		}

		return true;
	}
}
