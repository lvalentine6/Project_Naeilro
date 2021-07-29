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
						$(like_btn).removeClass("like")
						$(like_btn).removeClass("fas")
						$(like_btn).addClass("far")
						let curval = $(like_btn).parent().parent().next().children().children().find('.count_val').text()*1
						$(like_btn).parent().parent().next().children().children().find('.count_val').text(curval-1)
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
						$(like_btn).removeClass("far")
						$(like_btn).addClass("like")
						$(like_btn).addClass("fas")
						let curval = $(like_btn).parent().parent().next().children().children().find('.count_val').text()*1
						$(like_btn).parent().parent().next().children().children().find('.count_val').text(curval+1)
					})
					.fail(function(){
					})
					
				}
			})
		})
		
		$(".coment-btn").each(function(){
			$(this).click(function(){
				if(${memberNo==null}){
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
	})
	$(function(){
		$(".comment_content_form").hide()
		
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


/* 신고처리 */
$(function(){
	$(".report-btn").click(function(e){
		
		
		if($(this).data('storyno')){
			$("#report_no").val($(this).data('storyno'))
			$("#report_type").val('story')
		}else{
			$("#report_no").val($(this).data('commentno'))
			$("#report_type").val('comment')
		}
		$(".report-confirm").hide()
		$(".report-val").show()
	})
 <c:if test="${memberNo==null}">
 $(".report_reason_v").click(function(){
	 if(${memberNo==null}){
			alert("로그인후 이용해주세요");
			$(".r-c-btn").click()
			e.preventDefault;
			return
		}
 })
</c:if>
 <c:if test="${memberNo!=null}">
	$(".report_reason_v").click(function(){
		let no = $("#report_no").val()
		let reason = $(this).text()
		/* 댓글신고 */
		if($("#report_type").val()=='comment'){
			$.ajax({
				url:"${pageContext.request.contextPath}/report_rest/c_report",
				data : {
					memberNo : ${memberNo},
					photostoryCommentNo : no,
					cReportReason : reason,
				},
				method:"POST",
			})
			.done(function(){
				$(".report-confirm").show()
				$(".report-val").hide()
			})
			.fail(function(){
			})
			
		/* 스토리신고 */
		}else{
			$.ajax({
				url:"${pageContext.request.contextPath}/report_rest/p_report",
				data : {
					memberNo : ${memberNo},
					photostoryNo : no,
					pReportReason : reason
				},
				method:"POST",
			})
			.done(function(){
				$(".report-confirm").show()
				$(".report-val").hide()
			})
			.fail(function(){
			})
		}
	})
	</c:if>
})
</script>
<script type="text/template" id="comment-tpl">
						<div class="col-11 text-sm text-break" id="comment_1_{{no}}">
							<img class="my-2 user_profile_sm user_profile"
								src="${pageContext.request.contextPath}/member/profile/profileImage?memberNo={{memberNo}}"
					onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
							&nbsp;
							<a href="${pageContext.request.contextPath}/member/profile/{{userId}}">
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
	<div class="container-lg ">
		<div class="row justify-content-center ">
			<div class=" col-lg-8 offset-lg-2 mx-2">
				<div class='border row align-items-center'>
					<div class="col-1">
						<img class="my-2 user_profile_sm user_profile"
								src="${pageContext.request.contextPath}/member/profile/profileImage?memberNo=${photostoryListDto.memberNo}"
					onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
					</div>
					<div class="col-3 ">
						<a class="font-weight-bold text-nowrap" href="${pageContext.request.contextPath}/member/profile/${photostoryListDto.memberNick}">${photostoryListDto.memberNick}
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
										<a class="dropdown-item text-danger report-btn" data-storyno="${photostoryListDto.photostoryNo}" data-toggle="modal" data-target="#report_modal">게시글 신고</a>
										<a class="dropdown-item" >취소</a> 
									</div>
								</c:otherwise>
							</c:choose>
					</div>
				</div>
					
				<div id="carouselExampleControls" class="carousel slide row align-items-center" data-ride="carousel">
				  <div class="carousel-inner">
				    <c:forEach var="photostoryPhotoDto" items="${photostoryPhotoList}" varStatus="status">
				    <c:choose>
				    	<c:when test="${status.first}">
						    <div class="carousel-item active">
						       <img class="w-100 d-block border" src="${pageContext.request.contextPath}/photostory/photo/${photostoryPhotoDto.photostoryPhotoNo}" />
						    </div>
				    	</c:when>
				    	<c:otherwise>
						    <div class="carousel-item">
						       <img class="w-100 d-block border" src="${pageContext.request.contextPath}/photostory/photo/${photostoryPhotoDto.photostoryPhotoNo}" />
						    </div>
				    	</c:otherwise>
				    </c:choose>
				     </c:forEach>
				  </div>
				  <a class="carousel-control-prev" href="#carouselExampleControls" role="button" data-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="sr-only">Previous</span>
				  </a>
				  <a class="carousel-control-next" href="#carouselExampleControls" role="button" data-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="sr-only">Next</span>
				  </a>
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
						<i class="far fa-comment fa-lg comment-icon-btn"></i>
					</div>
					<div class="col-10"></div>
				</div>
				<div class='row align-items-center border-left border-right'>
					<div class="col-12 text-sm pb-1">
						<a class="nav-link d-inline p-0" data-toggle="modal" data-target="#like_list_${photostoryListDto.photostoryNo}"  href="#">
							좋아요 <span class="count_val"> ${photostoryListDto.photostoryLikeCount}</span>
							</a>
							
							<!-- Modal -->
						<div class="modal fade" id="like_list_${photostoryListDto.photostoryNo}" tabindex="-1" role="dialog" aria-hidden="true">
						  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="exampleModalScrollableTitle">좋아요</h5>
						        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
						          <span aria-hidden="true">&times;</span>
						        </button>
						      </div>
						      <div class="modal-body">
						      	<c:forEach items="${photostoryListDto.photostoryLikeMemberList}" var="followingList" varStatus="status">
						      	<div class='row align-items-center'>
						      		<div class="col-2 text-center">
						      			<img class="pr-0 user_profile_sm user_profile" src="${pageContext.request.contextPath}/member/profile/profileImage?memberNo=${followingList.member.memberNo}"
										onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
						      		</div>
						      		<div class="pl-0 col-4"><a href="${pageContext.request.contextPath}/member/profile/${followingList.member.memberNick }">${followingList.member.memberNick }</a></div>
						      		
						      		<c:choose>
						      			<c:when test="${followingList.isFollow()}">
								      		<div class="offset-2 col-4 text-right f-unfollow-btn-${followingList.member.memberNo}"><button class="btn btn-outline-secondary f-unfollow-btn f-unfollow-btn " data-memberNo='${followingList.member.memberNo}'>팔로우 <i class="fas fa-check"></i></button></div>
								      		<div class="offset-2 col-4 text-right d-none f-follow-btn-${followingList.member.memberNo}"><button class="btn btn-primary f-follow-btn " data-memberNo='${followingList.member.memberNo}'>팔로우</button></div>
						      			</c:when>
						      			<c:otherwise >
						      				<c:choose>
								      			<c:when test="${followingList.member.memberNo==memberNo}">
								      				
								      			</c:when>
								      			<c:otherwise>
										      		<div class="offset-2 col-4 text-right d-none f-unfollow-btn-${followingList.member.memberNo}"><button class="btn btn-outline-secondary f-unfollow-btn f-unfollow-btn " data-memberNo='${followingList.member.memberNo}'>팔로우 <i class="fas fa-check"></i></button></div>
										      		<div class="offset-2 col-4 text-right f-follow-btn-${followingList.member.memberNo}"><button class="btn btn-primary f-follow-btn " data-memberNo='${followingList.member.memberNo}'>팔로우</button></div>
								      			</c:otherwise>
								      		</c:choose>
						      			</c:otherwise>
						      		</c:choose>
						      	</div>
						      	<c:if test="${!status.last}">
						      		<hr>
						      	</c:if>
						      </c:forEach>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
						      </div>
						    </div>
						  </div>
						</div>
					</div>
				</div>
				<div class='row align-items-center border-left border-right pb-1'>
					<div class="col-12 text-sm">
						<a href="${pageContext.request.contextPath}/member/profile/${photostoryListDto.memberNick}">
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
						<a class="text-black-50 font-weight-bold text-sm">
							댓글 <span class="comment-count">${photostoryListDto.photostoryCommentCount}</span>개</a>
					</div>
				</div>
				<div class='row align-items-center border-left border-right pb-1'>
					<c:forEach var="photostoryCommentListDto" items="${photostoryCommentList}">
						<div class="col-11 text-sm text-break" id="comment_1_${photostoryCommentListDto.photostoryCommentNo}">
							<img class="my-2 user_profile_sm user_profile" src="${pageContext.request.contextPath}/member/profile/profileImage?memberNo=${photostoryCommentListDto.memberNo}"
					onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
							&nbsp;
							<a href="${pageContext.request.contextPath}/member/profile/${photostoryCommentListDto.photostoryCommentMemberNick}">
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
											<a class="dropdown-item text-danger report-btn" data-commentno="${photostoryCommentListDto.photostoryCommentNo}" href="#" data-toggle="modal" data-target="#report_modal">댓글 신고</a>
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
<!-- 신고 모달 -->
<div class="modal fade" id="report_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-danger" id="exampleModalScrollableTitle">신고</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      
      
      
      <div class="modal-body report-val">
       <input id="report_no" type="hidden">
       <input id="report_type" type="hidden">
       <div class="row">
    		<div class="col-12 "><strong>이 게시물을 신고하는 이유</strong></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" href="#none">스팸</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" href="#none">혐오 발언 또는 상징</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" href="#none">폭력 또는 위험한 단체</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" href="#none">불법 또는 규제 상품 판매</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" href="#none">따돌림 또는 괴롭힘</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" href="#none">지적 재산권 침해</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" href="#none">사기 또는 거짓</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" href="#none">마음에 들지 않습니다</a></div>
       </div>
      </div>
      
      
		<div class="modal-body report-confirm">
       <input id="report_no" type="hidden">
       <input id="report_type" type="hidden">
       <div class="row">
    		<div class="col-12 "><strong>신고처리 되었습니다.</strong></div>
       </div>
      </div>
      
      
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary r-c-btn" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>