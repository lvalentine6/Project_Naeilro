package com.kh.finale.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

/**
 * 비회원 기능 접근 차단 인터셉터
 * @author swjk78
 */
public class MemberLogoutInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Integer memberNo = (Integer) request.getSession().getAttribute("memberNo");
		
		// 로그인 상태일 경우 처리
		if (memberNo != null) {
			// 어느 페이지로 보낼지, 보낸 후 어떤 알림창을 띄울 것인지 미정
			response.sendRedirect(request.getContextPath());
			
			return false;
		}
		
		return true;
	}
}
