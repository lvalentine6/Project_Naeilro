<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<main>


	<div class="container">
		<div class="row">
			<div class="jumbotron col-6 offset-3">
				<h3 class="display-5">로그인</h3>
			</div>
			<div class="col-6 offset-3 text-center">
				<form action="" method="post" class="sign_up_form encrypt-form">
					<div class="form-row mb-3">
						<label for="memberId">아이디</label> <input type="text"
							class="form-control " id="memberId" name="memberId" required>
					</div>
					<div class="form-row mb-3">
						<label for="memberPw">비밀번호</label> <input type="password"
							class="form-control " id="memberPw" name="memberPw" required>
					</div>
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