<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<main>
	<div class="container-lg ">
		<div class="row justify-content-center ">
			<div class=" col-lg-8 offset-lg-2 mx-2">
				<div class='border row align-items-center'>
					<div class="col-1">
						<img class="my-2 user_profile_sm user_profile"
							src="${pageContext.request.contextPath}/image/default_user_profile.jpg">
					</div>
					<div class="col-3 font-weight-bold text-nowrap">${photostoryListDto.memberNick}글작성자
						닉네임</div>
					<div class="col-1 offset-7 text-right">
						<i class="fas fa-ellipsis-h"></i>
					</div>
				</div>
				<div class=' row align-items-center'>
					<img class="w-100 border"
						src="${pageContext.request.contextPath}/image/bgimg.webp" />
				</div>
				<div class='row align-items-center border-left border-right'>
					<div class="col-1 py-2">
						<%-- <c:choose>
								<c:when test="${photostoryTotalListDto.isLike}">
									<i class="fa-heart fa-lg like-btn fas like" data-photostoryNo="${photostoryTotalListDto.photostoryNo}"></i>
								</c:when>
								<c:otherwise>
									<i class="fa-heart fa-lg like-btn far" data-photostoryNo="${photostoryTotalListDto.photostoryNo}"></i> 
								</c:otherwise>
							</c:choose> --%>
						<i class="fa-heart fa-lg like-btn far"
							data-photostoryNo="${photostoryListDto.photostoryNo}"></i>
					</div>
					<div class="col-1">
							<i class="far fa-comment fa-lg"></i>
					</div>
					<div class="col-10"></div>
				</div>
				<div class='row align-items-center border-left border-right'>
					<div class="col-12 text-sm">
						좋아요 <span> ${photostoryListDto.photostoryLikeCount}</span>
					</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 text-sm">
						<strong>${photostoryTotalListDto.memberNick}글작성자 닉네임</strong>&nbsp;&nbsp;${photostoryListDto.photostoryContent}
					</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 ">
						<a class="text-black-50 font-weight-bold text-sm"
							href="${pageContext.request.contextPath}/photostory/detail?photostoryNo=${photostoryTotalListDto.photostoryNo}">
							댓글 ${photostoryTotalListDto.photostoryCommentCount}개 모두 보기 </a>
					</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
				<c:forEach var="photostoryCommentListDto" items="${photostoryCommentList}">
					<div class="col-12 text-sm">
						<strong>${photostoryCommentListDto.photostoryCommentMemberNick}</strong>&nbsp;&nbsp;${photostoryCommentListDto.photostoryCommentContent}
					</div>
				</c:forEach>
				</div>
				<div
					class='row align-items-center border-left border-right border-bottom pb-3'>
					<div
						class="col-12 text-black-50 font-weight-bold text-right text-sm ">${photostoryListDto.getPhotostoryDateString()}</div>
				</div>
				<div
					class='row align-items-center border-left border-right border-bottom mb-3 py-2'>
					<div class="col-10">
						<input type="text" class="form-control border-0"
							placeholder="댓글 달기 . . .">
					</div>
					<div class="col-2 text-right">
						<button type="button"
							class="btn btn-outline-primary text-nowrap coment-btn"
							data-photostoryNo="${photostoryListDto.photostoryNo}">게시</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	내용: ${photostoryListDto.photostoryContent} <br> 작성날짜:
	${photostoryListDto.getPhotostoryDateString()} <br> 닉네임:
	${photostoryListDto.memberNick} <br> 댓글수:
	${photostoryListDto.photostoryCommentCount} <br> 좋아요수:
	${photostoryListDto.photostoryLikeCount} <br>
	<br>
	<c:forEach var="photostoryCommentListDto"
		items="${photostoryCommentList}">
		댓글작성자닉: ${photostoryCommentListDto.photostoryCommentMemberNick}
	<br>
		댓글내용: ${photostoryCommentListDto.photostoryCommentContent}
	<br>
		댓글작성날짜: ${photostoryCommentListDto.getPhotostoryCommentDateString()}
	<br>
		<br>
	</c:forEach>
</main>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>