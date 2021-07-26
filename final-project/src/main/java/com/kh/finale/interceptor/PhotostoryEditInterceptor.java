package com.kh.finale.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.finale.constant.MemberGradeConstant;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.entity.photostory.PhotostoryListDto;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.repository.photostory.PhotostoryListDao;

/**
 * 포토스토리 편집 차단 인터셉터
 * @author swjk78
 */
public class PhotostoryEditInterceptor implements HandlerInterceptor {

	@Autowired
	private MemberDao memberDao;
	
	@Autowired
	private PhotostoryListDao photostoryListDao;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Integer memberNo = (Integer) request.getSession().getAttribute("memberNo");
		
		MemberDto memberDto = memberDao.findInfo(memberNo);
		int memberGrade = memberDto.getMemberGrade();
		
		// 관리자가 아닐 경우
		// 관리자가 회원들의 포토스토리 수정/삭제를 할 수 있는지 여부 미정
		if (memberGrade != MemberGradeConstant.ADMIN) {
			// 타인이 포토스토리 수정/삭제를 시도할 경우
			int photostoryNo = Integer.parseInt(request.getParameter("photostoryNo"));
			PhotostoryListDto photostoryListDto = photostoryListDao.get(photostoryNo);
			
			// 존재하지 않는 글일 경우
			if (photostoryListDto == null) {
				// 존재하지 않는 글이란 에러 페이지로 리다이렉트?
				response.sendRedirect(request.getContextPath() + "/photostory");
				
				return false;
			}
			
			// 타인의 글일 경우
			int writerNo = photostoryListDto.getMemberNo();
			if (writerNo != memberNo) {
				// 403이 맞나?
				response.sendError(403);
				
				return false;
			}
		}
		
		return true;
	}
}
