<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<main>
		<c:forEach var="photostoryDto" items="${list}">
	<div class="container-lg ">
		<div class="row justify-content-center ">
			<div class=" col-lg-8 offset-lg-2 mx-2">
				<div class='border row align-items-center'>
					<div class="col-1"><img class="my-2 user_profile_sm user_profile" src="${pageContext.request.contextPath}/image/default_user_profile.jpg"></div>
					<div class="col-3 font-weight-bold">user_test_id</div>
					<div class="col-1 offset-7 text-right"><i class="fas fa-ellipsis-h"></i></div>
				</div>
				<div class=' row align-items-center'>
					<img class="w-100 border" src="${pageContext.request.contextPath}/image/bgimg.webp"/>
				</div>
				<div class='row align-items-center border-left border-right'>
					<div class="col-1  py-2"><i class="far fa-heart fa-lg"></i></div>
					<div class="col-1"><i class="far fa-comment fa-lg"></i></div>
					<div class="col-10"></div>
				</div>
				<div class='row align-items-center border-left border-right'>
					<div class="col-12 text-sm">좋아요 11111111</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 text-sm"><strong>user_test_id</strong>&nbsp;&nbsp;${photostoryDto.photostoryContent} 아무글 아무글아무글아무글 아무글아무글 아무글아무글아무글아무글 아무글아무글아무글아무글</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 text-black-50 font-weight-bold text-sm">댓글 122개 모두 보기</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 text-sm"><strong>user_test_id2</strong>&nbsp;&nbsp;아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글</div>
					<div class="col-12 text-sm"><strong>user_test_id3</strong>&nbsp;&nbsp;아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글</div>
					<div class="col-12 text-sm"><strong>user_test_id4</strong>&nbsp;&nbsp;아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글</div>
				</div>
				<div class='row align-items-center border-left border-right border-bottom pb-3'>
					<div class="col-12 text-black-50 font-weight-bold text-right text-sm ">2일 전</div>
				</div>
				<div class='row align-items-center border-left border-right border-bottom mb-3 py-2'>
					<div class="col-10"><input type="text" class="form-control border-0" placeholder="댓글 달기..."></div>
					<div class="col-2 text-right"><button type="button" class="btn btn-outline-primary text-nowrap">게시</button></div>
				</div>
			</div>
		</div>
	</div>
		</c:forEach>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


