<%@page import="com.kh.finale.entity.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">아이디 찾기</h3>
			</div>
			<div class="col-lg-6 offset-lg-3 text-center">
				<form action="findId" method="post" class="sign_up_form encrypt-form">
					<div class="form-row mb-3">
						<label for="memberName">이름</label> <input type="text"
							class="form-control find-id" id="memberName" name="memberName"
							required value="${memberDto.memberName}">
					</div>
					<div class="form-row mb-3">
						<label for="memberEmail">이메일</label> <input type="email"
							class="form-control find-id" id="memberEmail" name="memberEmail"
							required value="${memberDto.memberEmail}">
					</div>
					<c:choose>
						<c:when
							test="${memberDto.memberName!=null&&memberDto.memberEmail!=null}">
							<c:choose>
								<c:when test="${memberDto.memberId!=null }">
									<script>
										$(function() {
											$(".find-id").each(
													function(el, index) {
														$(this).attr(
																'disabled',
																true);
													});
										})
									</script>
									<div class="form-row mb-3">
										<label for="memberId">아이디</label> <input type="text"
											class="form-control find-id" id="memberId" name="memberId"
											required value="${memberDto.memberId}">
									</div>
									<div class="form-row mb-5 justify-content-around">
										<a class="btn btn-primary btn-block"
											href="${pageContext.request.contextPath}/member/login"
											role="button">로그인</a>
										<a class="btn btn-secondary btn-block"
											href="${pageContext.request.contextPath}/member/findPw"
											role="button">비밀번호 찾기</a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="mb-3 text-danger">입력한 값과 일치하는 회원정보가 없습니다.</div>
									<div class="form-row mb-5 justify-content-around">
										<button class="btn btn-primary submit_btn btn-block"
											type="submit">찾기</button>
										<button class="btn btn-secondary cancel-back-btn btn-block"
											type="button">취소</button>
									</div>
								</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<div class="form-row mb-5 justify-content-around">
								<button class="btn btn-primary submit_btn btn-block"
									type="submit">찾기</button>
								<button class="btn btn-secondary cancel-back-btn btn-block"
									type="button">취소</button>
							</div>
						</c:otherwise>
					</c:choose>

				</form>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>