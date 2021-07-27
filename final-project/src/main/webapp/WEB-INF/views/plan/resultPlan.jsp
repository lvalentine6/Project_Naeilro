<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-12 offset-lg-0.5">
				<div class="row my-3 align-items-center">
					<div class="col-3" style="font-size: 1.5rem"><b>플래너 제목</b></div>
					<div class="col-4">
						<div class="dropdown">
							<a href="#" role="button" id="dropdownMenuLink"
								data-toggle="dropdown"><i class="fas fa-cog fa-1g"></i></a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<a class="dropdown-item" href="#">플래너 수정</a> <a
									class="dropdown-item" href="#">플래너 삭제</a>
							</div>
						</div>
					</div>
				</div>
					<div class="row">
					<img class="img-responsive left-block" alt="더미" src="${pageContext.request.contextPath}/image/default_user_profile.jpg">
						<div class="col-4 align-items-center" style="font-size: 1.5rem" >포토 스토리 연동</div>
					</div>
			</div>
				<div class="col-12">
					<h3>여행 계획 출력</h3>
						<div>
						<h4>1 일차</h4>
						</div>
						<div>
						<h4>2 일차</h4>
						</div>
						<div>
						<h4>3 일차</h4>
						</div>
				</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>