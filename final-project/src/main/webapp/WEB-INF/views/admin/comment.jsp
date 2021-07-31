<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<script>
function delete_comment(c_no,m_no){
	if (!window.confirm("댓글을 삭제합니다") ){ 
		e.preventDefault()
	}
	let commentNo = c_no
	let memberNo = m_no
	let comment = '[ 관리자에 의해 삭제된 댓글입니다. ]';
	console.log(comment)
	console.log(commentNo)
	$.ajax({
		url:"${pageContext.request.contextPath}/process/update_comment_admin",
		data : {
			photostoryCommentNo : commentNo,
			photostoryCommentContent : comment,
			memberNo : m_no,
		},
		method:"POST",
	})
	.done(function(){
		$(".comment_"+commentNo).text(comment)
	})
	.fail(function(){

	})
}
$(function(){
	$(".detail_btn").click(function(){
		let reportNo = $(this).data("report")
		if($("#in_"+reportNo).hasClass("load_complete")){
			return;
		}
		$.ajax({
			url:"${pageContext.request.contextPath}/report_rest/get_comment",
			data : {
				reportNo : reportNo
			},
			method:"POST",
			dataType: 'json',
		})
		.done(function(json){
			let template = $("#comment-tpl").html();
			template = template.replaceAll("{{nick}}",json.photostoryCommentMemberNick)
			template = template.replaceAll("{{comment}}",json.photostoryCommentContent)
			template = template.replaceAll("{{date}}",json.pastDateString)
			template = template.replaceAll("{{memberNo}}",json.memberNo)
			template = template.replaceAll("{{reportNo}}",reportNo)					
			template = template.replaceAll("{{commentNo}}",json.photostoryCommentNo)					
			
			$("#in_"+reportNo).append(template);
			$("#in_"+reportNo).addClass("load_complete")
		})
		.fail(function(){
		})
	})
})
</script>

<script type="text/template" id="comment-tpl">
<div class="col-12 text-sm text-break">
	<img class="my-2 user_profile_sm user_profile"
		src="${pageContext.request.contextPath}/member/profile/profileImage?memberNo={{memberNo}}"
		onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
	&nbsp;
		<a href="#">
			<strong>{{nick}}</strong>
		</a>
		&nbsp;
			{{date}}
		<div class="comment_{{commentNo}}">
			{{comment}}
		</div>
</div>
<div class="col-12 text-right my-3">
	<button type="button" class="btn btn-danger btn-sm" onclick="delete_comment({{commentNo}},{{memberNo}})">게시글 삭제</button>
	<button type="button" class="btn btn-danger btn-sm" onclick="ban_user({{memberNo}})">유저정지</button>
</div>
</script>
<main>
<div class="container-lg">
	<div class="row">
		<div class="jumbotron col-lg-10 offset-lg-1">
		<h3 class="display-5">댓글 신고 내역</h3>
	</div>
		<div class="col-lg-10 offset-lg-1">
			<div class="row">
				<div class="col-2 text-center p-3 text-nowrap"><strong>신고자</strong></div>
				<div class="col-6 text-center p-3 text-nowrap"><strong>신고사유</strong></div>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="accordion col-lg-10 offset-lg-1">
		<c:forEach items="${reportList}" var="listItem">
		  <div class="card">
		    <div class="card-header row" >
		    	<div class="col-2 d-flex align-items-center">${listItem.memberNick}</div>
		    	<div class="col-6 d-flex align-items-center">${listItem.reason}</div>
		    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">
		    		<button class="btn btn-link collapsed detail_btn" type="button" data-toggle="collapse" data-report="${listItem.reportNo}" data-target="#item_${listItem.reportNo}">
		          		자세히
		        	</button>
		    	</div>
		    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">
					<button class="btn btn-outline-danger  report_delete_btn" data-report="${listItem.reportNo}">
		          		삭제
		        	</button>
				</div>
		    </div>
		    <div id="item_${listItem.reportNo}" class="collapse">
		      <div id="in_${listItem.reportNo}" class="card-body row align-items-center border-left border-right pb-1 text-wrap">


		      </div>
		    </div>
		  </div>
		</c:forEach>
		</div>
	</div>
</div>
		<div class="mt-4">
		  <ul class="pagination justify-content-center">
		  	<c:if test="${page.pageNo>page.pageSize}">
			    <li class="page-item">
			      <a class="page-link" href="?pageNo=${page.startBlock-1}" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			</c:if>
		    <c:forEach var="p" begin="${page.startBlock}" end="${page.endBlock}">
		    	<c:if test="${p==page.pageNo}">
				    <li class="page-item active"><a class="page-link active" href="?pageNo=${p}">${p}</a></li>
		    	</c:if>
		    	<c:if test="${p!=page.pageNo}">
				    <li class="page-item"><a class="page-link active" href="?pageNo=${p}">${p}</a></li>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${ (page.lastBlock-page.pageSize) > page.startBlock}">
			    <li class="page-item">
			      <a class="page-link" href="?pageNo=${page.endBlock+1}" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
		    </c:if>

		  </ul>
		</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>