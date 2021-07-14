<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>

let regex = /^[0-9a-zA-Z]{4,12}$/;

$(function() {
	$('#memberPw').blur(function() {
		if (regex.test($(this).val())) {
			pw = true;
			$(this).addClass("is-valid");
			$(this).removeClass("is-invalid");
		} else {
			pw = false;
			$(this).removeClass("is-valid");
			$(this).addClass("is-invalid");
		}
	})
	$('#memberPw2').blur(function() {
		if ($(this).val() == $("#memberPw").val()) {
			$(this).addClass("is-valid");
			$(this).removeClass("is-invalid");
		} else {
			$(this).removeClass("is-valid");
			$(this).addClass("is-invalid");
		}
	})

	/* form submit 전송 검사 */
	$('.submit_btn').click(function(e) {
		if (!pw) {
			e.preventDefault();
			$('#memberPw').focus();
			return;
		}
		if ($('#memberPw').val() != $('#memberPw2').val()) {
			e.preventDefault();
			$('#memberPw2').focus();
			return;
		}
	})
})
</script>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">비밀번호 변경</h3>
			</div>
			<div class="col-lg-6 offset-lg-3 text-center">
				<form action="edit" method="post"
					class="sign_up_form encrypt-form">
					<div class="form-row mb-3">
						<label for="memberId">아이디</label> <input type="text"
							class="form-control find-pw" id="memberId" name="memberName"
							disabled required value="${param.memberId}">
					</div>
					<div class="form-row mb-3">
						<label for="memberPw">새 비밀번호</label> <input type="password"
							class="form-control " id="memberPw" name="memberPw" required>
						<small id="emailHelp" class="form-text text-muted">4~12자의
							영문 소문자, 대문자, 숫자만 사용 가능합니다.</small>
					</div>
					<div class="form-row mb-3">
						<label for="memberPw2">새 비밀번호 확인</label> <input type="password"
							class="form-control " id="memberPw2" name="memberPw2" required>
					</div>
					<div class="form-row mb-5 justify-content-around">
						<button class="btn btn-primary submit_btn btn-block auth-next-btn"
							type="submit">변경하기</button>
					</div>

				</form>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>