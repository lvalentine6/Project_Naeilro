package com.kh.finale.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import lombok.extern.slf4j.Slf4j;

/**
 * 회원가입 후 플래너 인터셉터
 * @author 이승로
 */
public class PlannerLoginInterceptor implements HandlerInterceptor {
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Integer memberNo = (Integer) request.getSession().getAttribute("memberNo");
		
		// 비로그인 상태일 때 처리
		if (memberNo == null) {
			response.sendRedirect(request.getContextPath() + "/member/login");
//			response.sendRedirect(response.getContentType() + "/writeplan");
			return false;
		}
		return true;
	}
}
