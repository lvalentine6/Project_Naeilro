<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">회원가입이 완료되었습니다.</h3>
				<span>NAEILRO에 오신 것을 환영합니다.</span>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-6 offset-lg-3">
				<button class="btn btn-primary submit_btn btn-block"  type="button">여행 계획 시작하기</button>
				<button class="btn btn-secondary cancel-btn btn-block" type="button">이용방법 알아보기</button>
				<button class="btn btn-secondary cancel-btn btn-block" type="button">메인페이지로 돌아가기</button>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>