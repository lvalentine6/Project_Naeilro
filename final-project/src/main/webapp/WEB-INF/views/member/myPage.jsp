<%@page import="com.kh.finale.entity.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>


$(function(){
	$(".story-photo").height($('.story-photo').width()+'px')
	
	$(".follow-btn").click(function(){
		if(${memberNo==null }){
			alert("로그인후 이용해주세요");
			return
		}
		$(".input_img").change(function(e){
			readImage(e.target)
		})
	})
	
	$( window ).resize(function() {
		$(".story-photo").height($('.story-photo').width()+'px')
	});
	
	
	let pageNo = 1;
	let oneTime = true;
	
	$(window).scroll(function(){
		if($(document).scrollTop()>=$("main").height()*0.5&&oneTime){
			oneTime = false;
			pageNo+=1;				
			$.ajax({
				url:"${pageContext.request.contextPath}/member/profile/${profileMemberDto.memberNick}",
				data : {
					pageNo : pageNo,
				},
				method:"GET",
				dataType : "html"
			})
			.done(function(html){
				oneTime=true;
				$(".mypage_photostory .row").append($(html)[31].querySelector(".mypage_photostory").children[0].children)
				$('.comment_content_form').hide();
				pageNo+=1;
			})
			.fail(function(){

			})
			
		}
	})
})

		

</script>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="col-lg-3 offset-lg-1">
				<label for="memberProfile">
					<img class='upload_img my-3 user_profile_lg user_profile' src="${pageContext.request.contextPath}/member/profile/profileImage?memberNo=${profileMemberDto.memberNo}"
					onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'"> 
					<input class="input_img" type="file" accept=".png, .jpg, .gif" id="memberProfile" name="memberProfile" style="display: none" disabled/>
				</label>
			</div>
			<div class="col-lg-7">
				<div class="row my-3 align-items-center">
					<div class="col-4" style="font-size: 2rem">${profileMemberDto.memberNick}</div>
					
					<div class="col-4">
					<c:choose>
						<c:when test="${profileMemberDto.memberNo==memberNo}">
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
						<c:when test="${profileMemberDto.memberNo==memberNo}">
							<div class="dropdown">
								<a href="#" role="button" id="dropdownMenuLink"
									data-toggle="dropdown"><i class="fas fa-cog fa-2x"></i></a>
	
								<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
									<a class="dropdown-item" href="${pageContext.request.contextPath}/member/findPw">비밀번호 변경</a>
									<a class="dropdown-item" href="#">문제 신고</a> 
									<a class="dropdown-item" href="${pageContext.request.contextPath}/member/logout">로그아웃</a> 
									<a class="dropdown-item text-danger confirm-link" data-message="정말 탈퇴하시겠습니까?" href="${pageContext.request.contextPath}/member/exit">회원 탈퇴</a> 
								</div>
							</div>
						</c:when>
					</c:choose>
					</div>
					
				</div>
				<div class="row">
					<div class="col-12">${profileMemberDto.memberIntro}</div>
				</div>

				<div class="row mb-3">
				</div>
			</div>
		</div>
		<div class="container-lg mb-2 pr-0">
			<div class="row w-100">
				<ul class="nav nav-tabs w-100">
					  <li class="nav-item w-25 text-center">
					    <a class="nav-link active" href="#">게시글 <strong>${countPhotostory}</strong></a>
					  </li>
					  <li class="nav-item w-25 text-center">
					    <a class="nav-link" href="#">플래너 <strong>0</strong></a>
					  </li>
					  <li class="nav-item w-25 text-center">
					    <a class="nav-link" href="#">팔로워 <strong>${countFollower }</strong></a>
					  </li>
					  <li class="nav-item w-25 text-center">
					    <a class="nav-link" href="#">팔로잉 <strong>${countFollowing }</strong></a>
					  </li>
					</ul>
			</div>
		</div>
		
		<div class="container-lg mypage_photostory">
			<div class="row">
				<c:forEach items="${photostoryList}" var="photostoryListDto">
					<c:if test="${not empty photostoryListDto.photostoryPhotoNo}">
					<div class="col-4 col-lg-3 px-0 pr-1 mb-1">
						   <img class="w-100 story-photo"
						      src="${pageContext.request.contextPath}/photostory/photo/${photostoryListDto.photostoryPhotoNo}" />
			    	</div>
					</c:if>
				</c:forEach>
			</div>		
		</div>

	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>