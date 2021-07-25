<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function() {

		/* 좋아요 버튼 */
		$(".like-btn").each(function() {
			$(this).click(function() {
				let like_btn = $(this);
				console.log(like_btn)
				if(${memberNo==null }){
					alert("로그인후 이용해주세요");
					return
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
				if(${memberNo==null }){
					alert("로그인후 이용해주세요");
					return
				}
				let comment = $(this).parent().prev().children().val();
				let comment_div = $(this).parent().prev().children();
				let curEl = $(this);
				if(!comment){
					return;
				}
				
				$.ajax({
					url:"${pageContext.request.contextPath}/process/insert_comment",
					data : {
						photostoryNo : $(this).attr("data-photostoryNo"),
						photostoryCommentContent : comment
					},
					method:"POST",
				})
				.done(function(result){
					let template = $("#comment-tpl").html();
					template = template.replaceAll("{{userId}}","${memberDto.memberNick}")
					template = template.replaceAll("{{comment}}",comment)
					template = template.replaceAll("{{no}}",result)
					template = template.replaceAll("{{memberNo}}","${memberNo}")
					
					$(curEl).parent().parent().prev().prev().prepend(template)
					$('.comment_content_form_'+result).hide()
					comment_count =$(".comment-count").html()*1 + 1
					$(".comment-count").text(comment_count)
					comment_div.val("")
				})
				.fail(function(){
					console.log('fail');
				})
			})
		})
		
		let pageNo = 1;
		let oneTime = true;
		
		$(window).scroll(function(){
			if($(document).scrollTop()>=$("main").height()*0.8&&oneTime){
				oneTime = false;
				pageNo+=1;				
				$.ajax({
					url:"${pageContext.request.contextPath}/photostory",
					data : {
						pageNo : pageNo,
					},
					method:"GET",
					dataType : "html"
				})
				.done(function(html){
					oneTime=true;
					$('.comment_content_form').hide();
				})
				.fail(function(){

				})
				
			}
		})
		
		
	})
	
	$(function(){
		$(".comment_content_form").hide();
		$(".comment_edit_btn_1").click(function(){
			$(this).parent().parent().next().hide()
			$(this).parent().parent().next().next().show()
		})
		
		$(".comment_cancel_btn").click(function(){
			$(this).parent().parent().parent().parent().hide()
			$(this).parent().parent().parent().parent().prev().show()
		})
		
		$(".comment_edit_btn").click(function(){
			let commentNo = $(this).data('no')
			let comment = $(this).parent().prev().val();
			console.log(comment)
			console.log(commentNo)
			$.ajax({
				url:"${pageContext.request.contextPath}/process/update_comment",
				data : {
					photostoryCommentNo : commentNo,
					photostoryCommentContent : comment,
				},
				method:"POST",
			})
			.done(function(){
				$("#comment_3_"+commentNo).html(comment).show()
				$('.comment_content_form_'+commentNo).hide()
				$("#comment_3_"+commentNo).show()
			})
			.fail(function(){

			})
		})
	})
	
	$(function(){
		/* 댓글 삭제 */
		$('.comment_delete_btn').click(delete_comment)
	})
	
function delete_comment(no){
	let commentNo = $(this).data('no')
	console.log()
	if(!commentNo){
		commentNo=no
	}
	if (!window.confirm("정말 삭제하시겠습니까?")){ 
		e.preventDefault()
	}
	$.ajax({
		url:"${pageContext.request.contextPath}/process/delete_comment",
		data : {
			photostoryCommentNo : commentNo,
		},
		method:"POST",
	})
	.done(function(){
		$("#comment_3_"+commentNo).remove()
		$("#comment_2_"+commentNo).remove()
		$("#comment_1_"+commentNo).remove()
	})
	.fail(function(){

	})
}
function show_form(no){
	$("#comment_3_"+no).hide()
	$('.comment_content_form_'+no).show()
}
function hide_form(no){
	$("#comment_3_"+no).show()
	$('.comment_content_form_'+no).hide()
}
function edit_comment(no){
	let commentNo = no
	let comment = $('#comment_edit_id_'+no).parent().prev().val();
	console.log(comment)
	console.log(commentNo)
	$.ajax({
		url:"${pageContext.request.contextPath}/process/update_comment",
		data : {
			photostoryCommentNo : commentNo,
			photostoryCommentContent : comment,
		},
		method:"POST",
	})
	.done(function(){
		$("#comment_3_"+commentNo).html(comment).show()
		$('.comment_content_form_'+commentNo).hide()
		$("#comment_3_"+commentNo).show()
	})
	.fail(function(){

	})
}
	
	
</script>
<script type="text/template" id="comment-tpl">
						<div class="col-11 text-sm text-break" id="comment_1_{{no}}">
							<img class="my-2 user_profile_sm user_profile"
								src="${pageContext.request.contextPath}/member/profileImage?memberNo={{memberNo}}"
					onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
							&nbsp;
							<a href="${pageContext.request.contextPath}/member/{{userId}}">
							<strong>{{userId}}</strong>
							</a>
							&nbsp;
							방금전
						</div>
						<div class="col-1" id="comment_2_{{no}}">
							<a href="#" role="button" id="dropdownMenuLink"
									data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i></a>
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<a class="dropdown-item text-danger comment_delete_btn"
											data-no="{{no}}" onclick="delete_comment({{no}})" 
											>삭제</a> 
											<a class="dropdown-item comment_edit_btn_1" data-no="{{no}}" 
											onclick="show_form({{no}})"
											>수정</a> 
											<a class="dropdown-item" >취소</a> 
										</div>
						</div>
						<div class="col-12  text-sm text-break" id="comment_3_{{no}}">
						{{comment}}
						</div>
						<div class="col-12 text-sm text-break comment_content_form comment_content_form_{{no}}">
							<form class="w-100">
								<div class="input-group">
								  <input type="text" class="form-control" value="{{comment}}">`
								  <div class="input-group-append" id="button-addon4">
								    <button class="btn btn-outline-primary comment_edit_btn" onclick="edit_comment({{no}})" id="comment_edit_id_{{no}}" type="button" data-no="{{no}}">수정</button>
								    <button class="btn btn-outline-secondary comment_cancel_btn" onclick="hide_form({{no}})" type="button">취소</button>
								  </div>
								</div>
							</form>
						</div>
</script>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="input-group mb-3 col-lg-8 offset-lg-2">
				<form class="w-100">
					  <div class="form-group input-group mb-3">
						  <input type="text" class="form-control" placeholder="검색어를 입력해주세요 . . ." >
						  <div class="input-group-append">
						    <button class="btn btn-outline-secondary" type="button" >검색</button>
						  </div>
					  </div>
				</form>
			</div>
		</div>
	</div>
	<div class="story-container">
	<c:forEach var="photostoryListDto" items="${photostoryList}">
		<div class="container-lg ">
			<div class="row justify-content-center ">
				<div class=" col-lg-8 offset-lg-2 mx-2">
					<div class='border row align-items-center'>
						<div class="col-1">
							<img class="my-2 user_profile_sm user_profile"
								src="${pageContext.request.contextPath}/member/profileImage?memberNo=${photostoryListDto.memberNo}"
					onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
						</div>
						<div class="col-3 ">
							<a class="font-weight-bold text-nowrap"
								href="${pageContext.request.contextPath}/member/${photostoryListDto.memberNick}">${photostoryListDto.memberNick}
							</a>
						</div>
						<div class="col-1 offset-7 text-right">
							<a href="#" role="button" id="dropdownMenuLink"
									data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i></a>
									
								<c:choose>
									<c:when test="${photostoryListDto.memberNo==memberNo}">
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<a class="dropdown-item text-danger" 
											href="${pageContext.request.contextPath}/photostory/delete?photostoryNo=${photostoryListDto.photostoryNo}">삭제</a> 
											<a class="dropdown-item " 
											href="${pageContext.request.contextPath}/photostory/edit?photostoryNo=${photostoryListDto.photostoryNo}">수정</a> 
											<a class="dropdown-item" >취소</a> 
										</div>
									</c:when>
									<c:otherwise>
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<a class="dropdown-item text-danger" href="/finale/report/pReport">게시글 신고</a> 
											<a class="dropdown-item" >취소</a> 
										</div>
									</c:otherwise>
								</c:choose>
								
						</div>
					</div>
					<div class=' row align-items-center'>
					
						<c:if test="${not empty photostoryListDto.photostoryPhotoNo}">
						   <img class="w-100 border"
						      src="${pageContext.request.contextPath}/photostory/photo/${photostoryListDto.photostoryPhotoNo}" />
						</c:if>

							
					</div>
					<div class='row align-items-center border-left border-right'>
						<div class="col-1 py-2">
							 <c:choose>
								<c:when test="${photostoryListDto.isLike}">
									<i class="fa-heart fa-lg like-btn fas like" data-photostoryNo="${photostoryListDto.photostoryNo}"></i>
								</c:when>
								<c:otherwise>
									<i class="fa-heart fa-lg like-btn far" data-photostoryNo="${photostoryListDto.photostoryNo}"></i> 
								</c:otherwise>
							</c:choose> 
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
					<div class='row align-items-center border-left border-right pb-1'>
						<div class="col-12 text-sm">
							<a href="${pageContext.request.contextPath}/member/${photostoryListDto.memberNick}">
							<strong>${photostoryListDto.memberNick}</strong>
							</a>
						</div>
					</div>
					<div class='row align-items-center border-left border-right pb-1'>
						<div class="col-12 text-sm">
							<pre>${photostoryListDto.photostoryContent}</pre>
						</div>
					</div>
					<div class='row align-items-center border-left border-right pb-1'>
						<div class="col-12 ">
							<a class="text-black-50 font-weight-bold text-sm"
								href="${pageContext.request.contextPath}/photostory/detail?photostoryNo=${photostoryListDto.photostoryNo}">
								댓글 <span class="comment-count">${photostoryListDto.photostoryCommentCount}</span>개 모두 보기 </a>
						</div>
					</div>
					<div class='row align-items-center border-left border-right pb-1 text-wrap'>
						<c:forEach var="photostoryCommentListDto" items="${photostoryListDto.photostoryCommentList}">
						<div class="col-11 text-sm text-break" id="comment_1_${photostoryCommentListDto.photostoryCommentNo}">
							<img class="my-2 user_profile_sm user_profile" src="${pageContext.request.contextPath}/member/profileImage?memberNo=${photostoryCommentListDto.memberNo}"
					onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
							&nbsp;
							<a href="${pageContext.request.contextPath}/member/${photostoryCommentListDto.photostoryCommentMemberNick}">
							<strong>${photostoryCommentListDto.photostoryCommentMemberNick}</strong>
							</a>
							&nbsp;
							${photostoryCommentListDto.getPastDateString()}
						</div>
						<div class="col-1" id="comment_2_${photostoryCommentListDto.photostoryCommentNo}">
							<a href="#" role="button" id="dropdownMenuLink"
									data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i></a>
								<c:choose>
									<c:when test="${photostoryCommentListDto.photostoryCommentMemberNick==memberContextNick}">
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<a class="dropdown-item text-danger comment_delete_btn"
											data-no="${photostoryCommentListDto.photostoryCommentNo}" 
											>삭제</a> 
											<a class="dropdown-item comment_edit_btn_1" 
											>수정</a> 
											<a class="dropdown-item" >취소</a> 
										</div>
									</c:when>
									<c:otherwise>
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<a class="dropdown-item text-danger" href="#">댓글 신고</a> 
											<a class="dropdown-item" >취소</a> 
										</div>
									</c:otherwise>
								</c:choose>
						</div>
						<div class="col-12 text-sm text-break comment_content_val" id="comment_3_${photostoryCommentListDto.photostoryCommentNo}">
						${photostoryCommentListDto.photostoryCommentContent}
						</div>
						<div class="col-12 text-sm text-break comment_content_form comment_content_form_${photostoryCommentListDto.photostoryCommentNo}">
							<form class="w-100">
								<div class="input-group">
								  <input type="text" class="form-control" value="${photostoryCommentListDto.photostoryCommentContent}">`
								  <div class="input-group-append" id="button-addon4">
								    <button class="btn btn-outline-primary comment_edit_btn" id="comment_edit_id_${photostoryCommentListDto.photostoryCommentNo}" type="button" data-no="${photostoryCommentListDto.photostoryCommentNo}">수정</button>
								    <button class="btn btn-outline-secondary comment_cancel_btn" type="button">취소</button>
								  </div>
								</div>
							</form>
						</div>
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
	</c:forEach>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


