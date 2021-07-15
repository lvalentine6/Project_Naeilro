<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script>
	$(function() {
		
		$(".comment-icon-btn").click(function(){
			$(".comment-input").focus();
		})
		/* 좋아요 버튼 */
		$(".like-btn").each(function() {
			$(this).click(function() {
				let like_btn = $(this);
				console.log(like_btn)
				if(${memberNo==null }){
					alert("로그인후 이용해주세요");
				}
					/* 좋아요 삭제 */
				if ($(this).hasClass("like")) {
					$.ajax({
						url:"${pageContext.request.contextPath}/process/delete_like",
						data : {
							photostoryNo : $(like_btn).attr("data-photostoryNo"),
						},
						method:"GET",
					})
					.done(function(){
						console.log("좋아요")
						$(like_btn).removeClass("like")
						$(like_btn).removeClass("fas")
						$(like_btn).addClass("far")
						let curval = $(like_btn).parent().parent().next().children().children().text() * 1;
						$(like_btn).parent().parent().next().children().children().text(curval-1)
					})
					.fail(function(){
						
					})
					
				} else {
					/* 좋아요 추가 */
					$.ajax({
						url:"${pageContext.request.contextPath}/process/insert_like",
						data : {
							photostoryNo : $(like_btn).attr("data-photostoryNo"),
						},
						method:"GET",
					})
					.done(function(){
						console.log("좋아요")
						$(like_btn).removeClass("far")
						$(like_btn).addClass("like")
						$(like_btn).addClass("fas")
						
						let curval = $(like_btn).parent().parent().next().children().children().text() * 1;
						$(like_btn).parent().parent().next().children().children().text(curval+1)
					})
					.fail(function(){
					})
					
				}
			})
		})
		
		$(".coment-btn").each(function(){
			$(this).click(function(){
				let comment = $(this).parent().prev().children().val();
				let comment_div = $(this).parent().prev().children();
				let curEl = $(this);
				if(!comment){
					return;
				}
				
				console.log(comment);
				$.ajax({
					url:"${pageContext.request.contextPath}/process/insert_comment",
					data : {
						photostoryNo : $(this).attr("data-photostoryNo"),
						photostoryCommentContent : comment
					},
					method:"POST",
				})
				.done(function(){
					let template = $("#comment-tpl").html();
					template = template.replace("{{userId}}","${memberNick }")
					template = template.replace("{{comment}}",comment)
					$(curEl).parent().parent().prev().prev().append(template)
					comment_div.val("")
					console.log(curEl);
				})
				.fail(function(){
					console.log('fail');
				})
			})
		})
	})
</script>
<script type="text/template" id="comment-tpl">
	<div class="col-12 text-sm">
		<strong>{{userId}}</strong>
&nbsp;&nbsp;
{{comment}}
	</div>
</script>
<main>
	<div class="container-lg ">
		<div class="row justify-content-center ">
			<div class=" col-lg-8 offset-lg-2 mx-2">
				<div class='border row align-items-center'>
					<div class="col-1">
						<img class="my-2 user_profile_sm user_profile"
							src="${pageContext.request.contextPath}/image/default_user_profile.jpg">
					</div>
					<div class="col-3 "><a class="font-weight-bold text-nowrap" href="${pageContext.request.contextPath}/member/${photostoryListDto.memberNick}">${photostoryListDto.memberNick}글작성자
						닉네임</a></div>
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
						<i class="far fa-comment fa-lg comment-icon-btn"></i>
					</div>
					<div class="col-10"></div>
				</div>
				<div class='row align-items-center border-left border-right'>
					<div class="col-12 text-sm mb-1">
						좋아요 <span> ${photostoryListDto.photostoryLikeCount}</span>
					</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 text-sm">
						<strong>${photostoryTotalListDto.memberNick}글작성자 닉네임</strong>
						&nbsp;&nbsp;
						${photostoryListDto.photostoryContent}
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
					<c:forEach var="photostoryCommentListDto"
						items="${photostoryCommentList}">
						<div class="col-12 text-sm">
							<a href="${pageContext.request.contextPath}/member/${photostoryCommentListDto.photostoryCommentMemberNick}">
							<strong>${photostoryCommentListDto.photostoryCommentMemberNick}</strong>
							</a>
							&nbsp;&nbsp;
							${photostoryCommentListDto.photostoryCommentContent}
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
					<div class="col-9">
						<input type="text" class="form-control border-0 comment-input"
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
</main>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>