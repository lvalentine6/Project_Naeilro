<%@page import="com.kh.finale.entity.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>

/* function readImage(input) {
    if(input.files && input.files[0]) {
        const reader = new FileReader()
        reader.onload = e => {
            const previewImage = document.querySelector(".upload_img")
            previewImage.src = e.target.result
        }
        reader.readAsDataURL(input.files[0])
    }
}
$(function(){
	$(".input_img").change(function(e){
		console.dir(e.target)
		readImage(e.target)
	})
}) */

$(function(){
	$(".follow-btn").click(function(){
		if(${memberNo==null }){
			alert("로그인후 이용해주세요");
			return
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/memberprocess/insert_follow",
			data : {
				followTo : ${memberDto.memberNo},
			},
			method:"GET",
		})
		.done(function(){
			location.reload();
		})
		.fail(function(){
		})
	});
	
	$(".unfollow-btn").click(function(){
		
		$.ajax({
			url:"${pageContext.request.contextPath}/memberprocess/delete_follow",
			data : {
				followTo : ${memberDto.memberNo},
			},
			method:"GET",
		})
		.done(function(){
			location.reload();
		})
		.fail(function(){
		})
	});
})
</script>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="col-lg-3 offset-lg-1">
				<label for="memberProfile"> 
					<img class='upload_img my-3 user_profile_lg user_profile' src="profileImage?memberId=${memberDto.memberId}"> 
					<input class="input_img" type="file" accept=".png, .jpg, .gif" id="memberProfile" name="memberProfile" style="display: none" disabled/>
				</label>
			</div>
			<div class="col-lg-7">
				<div class="row my-3 align-items-center">
					<div class="col-4" style="font-size: 2rem">${memberDto.memberNick}</div>
					
					<div class="col-4">
					<c:choose>
						<c:when test="${memberDto.memberNo==memberNo}">
							<a class="btn btn-outline-secondary" href="editProfile" role="button">프로필 편집</a>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${isFollow }">
									<div class="row justify-content-between">
										<a class="btn btn-outline-secondary" role="button">메세지</a>
										
										<a class="btn btn-outline-secondary " role="button" href="#" id="dropdownMenuLink2" data-toggle="dropdown">팔로우 <i class="fas fa-check"></i></a>
										
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink2">
											<a class="dropdown-item unfollow-btn text-danger" >팔로우 취소</a>
											<a class="dropdown-item " >취소</a> 
										</div>
									</div>
								</c:when>
								<c:otherwise>
									<div class="row justify-content-between">
										<a class="btn btn-primary follow-btn" role="button">팔로우</a>
									</div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					</div>
					
					<div class="col-4">
					<c:choose>
						<c:when test="${memberDto.memberNo==memberNo}">
							<div class="dropdown">
								<a href="#" role="button" id="dropdownMenuLink"
									data-toggle="dropdown"><i class="fas fa-cog fa-2x"></i></a>
	
								<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<a class="dropdown-item" href="findPw">비밀번호 변경</a>
									<a class="dropdown-item" href="#">문제 신고</a> 
									<a class="dropdown-item" href="logout">로그아웃</a> 
									<a class="dropdown-item text-danger confirm-link" data-message="정말 탈퇴하시겠습니까?" href="exit">회원 탈퇴</a> 
								</div>
							</div>
						</c:when>
					</c:choose>
					</div>
					
				</div>
				<div class="row mb-3">
					<div class="col-4">
						게시글 <strong>0</strong>
					</div>
					<div class="col-4">
						팔로워 <strong>${countFollower }</strong>
					</div>
					<div class="col-4">
						팔로잉 <strong>${countFollowing }</strong>
					</div>
				</div>
				<div class="row">
					<div class="col-12">${memberDto.memberIntro}</div>
				</div>

			</div>
		</div>
		<hr class="my-5">
		<div class="container-lg ">
			<div class="row justify-content-center ">
				<div class=" col-lg-8 offset-lg-2 mx-2">
					<div class='border row align-items-center'>
						<div class="col-1">
							<img class="my-2 user_profile_sm user_profile"
								src="${pageContext.request.contextPath}/image/default_user_profile.jpg">
						</div>
						<div class="col-3 ">
							<a class="font-weight-bold text-nowrap"
								href="${pageContext.request.contextPath}/member/${photostoryListDto.memberNick}">${photostoryListDto.memberNick}글작성자
								닉네임</a>
						</div>
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
							<i class="fa-heart fa-lg like-btn far"
								data-photostoryNo="${photostoryListDto.photostoryNo}"></i>
						</div>
						<div class="col-1">
							<a
								href="${pageContext.request.contextPath}/photostory/detail?photostoryNo=${photostoryListDto.photostoryNo}">
								<i class="far fa-comment fa-lg"></i>
							</a>
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
							<strong>${photostoryListDto.memberNick}글작성자 닉네임</strong>
							&nbsp;&nbsp; ${photostoryListDto.photostoryContent}
						</div>
					</div>
					<div class='row align-items-center border-left border-right mb-1'>
						<div class="col-12 ">
							<a class="text-black-50 font-weight-bold text-sm"
								href="${pageContext.request.contextPath}/photostory/detail?photostoryNo=${photostoryListDto.photostoryNo}">
								댓글 ${photostoryListDto.photostoryCommentCount}개 모두 보기 </a>
						</div>
					</div>
					<div class='row align-items-center border-left border-right mb-1'>
						<c:forEach var="commentList" items="${recentCommentList}">
							<c:forEach var="photostoryCommentListDto" items="${commentList}">
								<div class="col-12 text-sm">
									<a
										href="${pageContext.request.contextPath}/member/${photostoryCommentListDto.photostoryCommentMemberNick}">
										<strong>${photostoryCommentListDto.photostoryCommentMemberNick}</strong>
									</a> &nbsp;&nbsp;
									${photostoryCommentListDto.photostoryCommentContent}
								</div>
							</c:forEach>
						</c:forEach>
					</div>
					<div
						class='row align-items-center border-left border-right border-bottom pb-3'>
						<div
							class="col-12 text-black-50 font-weight-bold text-right text-sm ">${photostoryListDto.getPastDateString()}</div>
					</div>
					<div
						class='row align-items-center border-left border-right border-bottom mb-3 py-2'>
						<div class="col-9">
							<input type="text" class="form-control border-0"
								placeholder="댓글 달기 . . .">
						</div>
						<div class="col-3 text-right">
							<button type="button"
								class="btn btn-outline-primary text-nowrap coment-btn"
								data-photostoryNo="${photostoryListDto.photostoryNo}">게시</button>
						</div>
					</div>
				</div>
			</div>
		</div>



		<div class="container-lg ">
			<div class="row justify-content-center ">
				<div class=" col-lg-8 offset-lg-2 mx-2">
					<div class='border row align-items-center'>
						<div class="col-1">
							<img class="my-2 user_profile_sm user_profile"
								src="${pageContext.request.contextPath}/image/default_user_profile.jpg">
						</div>
						<div class="col-3 ">
							<a class="font-weight-bold text-nowrap"
								href="${pageContext.request.contextPath}/member/${photostoryListDto.memberNick}">${photostoryListDto.memberNick}글작성자
								닉네임</a>
						</div>
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
								<c:when test="${photostoryListDto.isLike}">
									<i class="fa-heart fa-lg like-btn fas like" data-photostoryNo="${photostoryListDto.photostoryNo}"></i>
								</c:when>
								<c:otherwise>
									<i class="fa-heart fa-lg like-btn far" data-photostoryNo="${photostoryListDto.photostoryNo}"></i> 
								</c:otherwise>
							</c:choose> --%>
							<i class="fa-heart fa-lg like-btn far"
								data-photostoryNo="${photostoryListDto.photostoryNo}"></i>
						</div>
						<div class="col-1">
							<a
								href="${pageContext.request.contextPath}/photostory/detail?photostoryNo=${photostoryListDto.photostoryNo}">
								<i class="far fa-comment fa-lg"></i>
							</a>
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
							<strong>${photostoryListDto.memberNick}글작성자 닉네임</strong>
							&nbsp;&nbsp; ${photostoryListDto.photostoryContent}
						</div>
					</div>
					<div class='row align-items-center border-left border-right mb-1'>
						<div class="col-12 ">
							<a class="text-black-50 font-weight-bold text-sm"
								href="${pageContext.request.contextPath}/photostory/detail?photostoryNo=${photostoryListDto.photostoryNo}">
								댓글 ${photostoryListDto.photostoryCommentCount}개 모두 보기 </a>
						</div>
					</div>
					<div class='row align-items-center border-left border-right mb-1'>
						<c:forEach var="commentList" items="${recentCommentList}">
							<c:forEach var="photostoryCommentListDto" items="${commentList}">
								<div class="col-12 text-sm">
									<a
										href="${pageContext.request.contextPath}/member/${photostoryCommentListDto.photostoryCommentMemberNick}">
										<strong>${photostoryCommentListDto.photostoryCommentMemberNick}</strong>
									</a> &nbsp;&nbsp;
									${photostoryCommentListDto.photostoryCommentContent}
								</div>
							</c:forEach>
						</c:forEach>
					</div>
					<div
						class='row align-items-center border-left border-right border-bottom pb-3'>
						<div
							class="col-12 text-black-50 font-weight-bold text-right text-sm ">${photostoryListDto.getPastDateString()}</div>
					</div>
					<div
						class='row align-items-center border-left border-right border-bottom mb-3 py-2'>
						<div class="col-9">
							<input type="text" class="form-control border-0"
								placeholder="댓글 달기 . . .">
						</div>
						<div class="col-3 text-right">
							<button type="button"
								class="btn btn-outline-primary text-nowrap coment-btn"
								data-photostoryNo="${photostoryListDto.photostoryNo}">게시</button>
						</div>
					</div>
				</div>
			</div>
		</div>




	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>