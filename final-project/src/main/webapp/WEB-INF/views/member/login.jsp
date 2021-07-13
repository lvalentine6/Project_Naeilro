<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<main>


	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">로그인</h3>
			</div>
			<div class="col-lg-6 offset-lg-3 text-center">
				<form action="login" method="post" class="sign_up_form encrypt-form">
					<div class="form-row mb-3">
						<label for="memberId">아이디</label> <input type="text"
							class="form-control " id="memberId" name="memberId" required>
					</div>
					<div class="form-row mb-3">
						<label for="memberPw">비밀번호</label> <input type="password"
							class="form-control " id="memberPw" name="memberPw" required>
					</div>
					<c:if test="${param.error!=null}">
					<div class="mb-3 text-danger">
						아이디 또는 비밀번호가 일치하지 않습니다
					</div>
					</c:if>
					<div class="form-row mb-5 justify-content-around">
						<button class="btn btn-primary submit_btn btn-block" type="submit">로그인</button>
						<button class="btn btn-secondary cancel-btn btn-block" type="button">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>