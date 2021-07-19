<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function(){
		
		/* 인증번호 발송 버튼 클릭 이벤트 */
		$(".cert-btn").click(function(){
			alert("인증번호를 이메일로 발송 하였습니다.")
			let memberId = $('#memberId').val();
			let memberEmail=$('#memberEmail').val();
			if(!memberId){
				$('#memberId').focus();
				return;
			}
			if(!memberEmail){
				$('#memberEmail').focus();
				return;
			}
			$.ajax({
				url:"sendAuthEmail",
				data : {
					memberId : memberId,
					memberEmail : memberEmail,
				},
				method:"POST",
				dataType : "json"
			})
			.done(function(){
				$("#authNo").attr("disabled",false)
				$("#authNo").focus();
				$(".auth-next-btn").attr("disabled",false)
				$(".cert-btn").attr("disabled",true)
				$('#memberId').attr("disabled",true)
				$('#memberEmail').attr("disabled",true)
				var timer = setInterval(function(){
					var sec = $(".auth_time").attr("data-time");
					$(".auth_time").attr("data-time",sec-1);
					$(".auth_time").text(sec);
					if(sec<=0){
						clearInterval(timer)
					}
				},1000)
			})
			.fail(function(){
				alert("입력한 정보와 일치하는 회원정보가 없습니다.")

			})
		})
		
		/* 다음 버튼 클릭 이벤트 */
		$(".auth-next-btn").click(function(){
			let memberEmail=$('#memberEmail').val();
			let authNo=$('#authNo').val();
			$.ajax({
				url:"${pageContext.request.contextPath}/member/checkAuthEmail",
				data : {
					authNo : authNo,
					memberEmail : memberEmail,
				},
				method:"POST",
			})
			.done(function(){
				let memberId = $('#memberId').val();
				window.location.replace("${pageContext.request.contextPath}/member/changePw?authNo="+authNo);
			})
			.fail(function(){
				if($(".auth_time").attr("data-time")<=0){
					alert("유효시간이 지났습니다.")
					return
				}
				alert("인증번호를 확인해주세요.")
			})
		})
	})
</script>

<main>
	<div class="container-lg">
		<div class="sendAuthEmail">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">본인 인증</h3>
			</div>
			<div class="col-lg-6 offset-lg-3 text-center">
				<form action="sendAuthEmail" method="post" class="sign_up_form encrypt-form">
					<div class="form-row mb-3">
						<label for="memberId">아이디</label> <input type="text"
							class="form-control find-pw" id="memberId" name="memberName"
							required>
					</div>
					<div class="form-row">
						<label for="memberEmail text-left">이메일</label>
					</div>
					<div class="form-row mb-3 input-group">
						<input type="text" class="form-control" name="memberEmail"
							id="memberEmail" aria-describedby="auth-btn">
						<div class="input-group-append">
							<button class="btn btn-outline-secondary cert-btn" type="button"
								id="auth-btn">인증번호 발송</button>
						</div>
					</div>
					<div class="form-row mb-3">
						<label for="authNo">인증번호 <span class="mx-2 text-sm text-danger auth_time" data-time='300'></span></label> <input type="text"
							class="form-control find-pw" id="authNo" name="authNo" required
							disabled>
					</div>
					<div class="form-row mb-5 justify-content-around">
						<button class="btn btn-primary submit_btn btn-block auth-next-btn"
							type="button" disabled>다음</button>
						<button class="btn btn-secondary cancel-back-btn btn-block"
							type="button">취소</button>
					</div>

				</form>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>