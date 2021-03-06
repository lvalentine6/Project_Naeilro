package com.kh.finale.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;

import com.kh.finale.entity.block.MemberBlockDto;
import com.kh.finale.entity.member.MemberDto;
import com.kh.finale.repository.block.MemberBlockDao;
import com.kh.finale.repository.member.MemberDao;
import com.kh.finale.service.block.MemberBlockService;

import lombok.extern.slf4j.Slf4j;

/**
 * 정지된 회원의 기능 사용 제한 인터셉터
 * @author swjk78
 *
 */
@Slf4j
public class MemberBlockInterceptor implements HandlerInterceptor {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private MemberBlockDao memberBlockDao;
	
	@Autowired
	private MemberBlockService memberBlockService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		Integer memberNo = (Integer) request.getSession().getAttribute("memberNo");
		
		MemberDto memberDto = memberDao.findInfo(memberNo);
		
		// 정지 상태일 경우 처리
		if (memberDto.getMemberState().equals("정지")) {
			// 정지 해제 체크
			boolean blockCheck = memberBlockDao.checkBlock(memberNo);
			// 정지 기간이 지났을 경우
			if (blockCheck) {
				memberBlockService.unblock(memberNo);
			}
			// 정지 기간이 지나지 않았을 경우
			else {
				// 어느 페이지로 보낼지, 보낸 후 어떤 알림창을 띄울 것인지 미정 
				MemberBlockDto memberBlockDto = memberBlockDao.getBlockInfo(memberNo);
				request.setAttribute("block", memberBlockDto);
				response.sendRedirect(request.getContextPath());

				log.debug("인터셉터: MemberBlockInterceptor 차단");
				return false;
			}
		}
		
		return true;
	}
}
