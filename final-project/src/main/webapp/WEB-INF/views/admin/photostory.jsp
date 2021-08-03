<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<script>
function report_modal(e){
	$("#report_member").val($(e).data('member'))
	$("#report_story").val($(e).data('story'))
	$("#report_no").val($(e).data('report'))
	$("#report_reason").val($('#report_reason_'+$(e).data('report')).text())
	$("#report_content").val($(e).data('content'))
}
function delete_comment(e){
	if (!window.confirm("게시글을 삭제합니다") ){ 
		e.preventDefault()
	}
	let storyNo = $("#report_story").val()
	let reportNo = $("#report_no").val()
	let memberNo = $("#report_member").val()
	let reportDay = $("#report_day").val()
	let reportReason = $("#report_reason").val()
	let reportContent = $("#report_content").val()
	/* 유저 정지처리 , 리포트 확인 처리 */
	if(reportDay>0){
		$.ajax({
		url:"${pageContext.request.contextPath}/member_block/r_block",
		data : {
			blockPeriod : reportDay,
			memberNo : memberNo,
			blockContent : reportContent,
			blockReason : reportReason,
			type : 'story',
			reportNo : storyNo
		},
		method:"POST",
		})
		.done(function(){
	
		})
		.fail(function(){
	
		})
	}
	let comment = '[ 관리자에 의해 삭제된 글입니다. ]';
	$.ajax({
		url:"${pageContext.request.contextPath}/process/edit_story",
		data : {
			photostoryNo : storyNo,
			photostoryContent : comment,
			memberNo : memberNo,
		},
		method:"POST",
	})
	.done(function(){
		$(".content_"+storyNo).text(comment)
		console.log($(".img_"+storyNo))
		console.log(".img_"+storyNo)
		$(".img_"+storyNo).attr("src", "${pageContext.request.contextPath}/image/delete_img.jpg");
		
		$("#report_confimr_"+reportNo).text("Y")
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
			url:"${pageContext.request.contextPath}/report_rest/get_story",
			data : {
				reportNo : reportNo
			},
			method:"POST",
			dataType: 'json',
		})
		.done(function(json){
  			let template = $("#story-tpl").html();
			template = template.replaceAll("{{nick}}",json.story.memberNick)
			template = template.replaceAll("{{content}}",json.story.photostoryContent)
			template = template.replaceAll("{{date}}",json.story.pastDateString)
			template = template.replaceAll("{{memberNo}}",json.story.memberNo)
			template = template.replaceAll("{{reportNo}}",reportNo)					
			template = template.replaceAll("{{storyNo}}",json.story.photostoryNo)
			
			$("#in_"+reportNo).append(template);
			
			for(let i = 0 ; i<json.imgList.length;i++){
				let img_template;
				if(i==0){
					img_template = $("#img-tpl-first").html()
				}else{
					img_template = $("#img-tpl").html()
				}
				img_template=img_template.replaceAll("{{photoNo}}",json.imgList[i].photostoryPhotoNo)
				img_template=img_template.replaceAll("{{storyNo}}",json.story.photostoryNo)
				$(".carousel-inner_"+reportNo).append(img_template)
			}
			$("#in_"+reportNo).addClass("load_complete")
		})
		.fail(function(){
		})
	})
	
	
	
	/* report 삭제 버튼 */
	
	$(".report_delete_btn").click(function(){
		let reportNo = $(this).data('report');
		if (!window.confirm("신고 내역을 삭제합니다") ){ 
			e.preventDefault()
		}
		
		$.ajax({
			url:"${pageContext.request.contextPath}/report_rest/delete_p_report",
			data : {
				reportNo : reportNo,
			},
			method:"POST",
		})
		.done(function(){
			$(".report_container_"+reportNo).remove();
		})
		.fail(function(){

		})
	})
})
</script>
<script type="text/template" id="img-tpl-first">
	<div class="carousel-item active">
		<img class="w-100 d-block border img_{{storyNo}}" src="${pageContext.request.contextPath}/photostory/photo/{{photoNo}}" />
	</div>
</script>
<script type="text/template" id="img-tpl">
	<div class="carousel-item">
		<img class="w-100 d-block border img_{{storyNo}}" src="${pageContext.request.contextPath}/photostory/photo/{{photoNo}}" />
	</div>
</script>
<script type="text/template" id="story-tpl">
				<div class="row justify-content-center story_container_{{storyNo}}">
					<div class=" col-lg-8 offset-lg-2 mx-2">
						<div class='border row align-items-center'>
							<div class="col-1">
						<img class="my-2 user_profile_sm user_profile"
								src="${pageContext.request.contextPath}/member/profile/profileImage?memberNo={{memberNo}}"
					onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'">
							</div>
							<div class="col-3 ">
								<a class="font-weight-bold text-nowrap"
									href="${pageContext.request.contextPath}/member/{{nick}}">{{nick}}</a>
							</div>
							<div class="col-1 offset-7 text-right">
								<i class="fas fa-ellipsis-h"></i>
							</div>
						</div>
						
						<div id="carouselExampleControls_{{reportNo}}" class="carousel slide row align-items-center" data-ride="carousel">
						  <div class="carousel-inner carousel-inner_{{reportNo}}">


						  </div>
						  <a class="carousel-control-prev" href="#carouselExampleControls_{{reportNo}}" role="button" data-slide="prev">
						    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
						    <span class="sr-only">Previous</span>
						  </a>
						  <a class="carousel-control-next" href="#carouselExampleControls_{{reportNo}}" role="button" data-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="sr-only">Next</span>
						  </a>
						</div>
						
						<div class='row align-items-center border-left border-right'>
							<div class="col-1 py-2">
								<i class="fa-heart fa-lg like-btn far"
									data-photostoryNo="{{storyNo}}"></i>
							</div>
							<div class="col-1">
								<a
									href="${pageContext.request.contextPath}/photostory/detail?photostoryNo={{storyNo}}">
									<i class="far fa-comment fa-lg"></i>
								</a>
							</div>
							<div class="col-10"></div>
						</div>
						<div class='row align-items-center border-left border-right'>
						</div>
				<div class='row align-items-center border-left border-right pb-1'>
					<div class="col-12 text-sm">
						<a href="${pageContext.request.contextPath}/member/profile/{{nick}}">
						<strong>{{nick}}</strong>
						</a>
					</div>
				</div>
				<div class='row align-items-center border-left border-right pb-1'>
					<div class="col-12 text-sm">
						<pre class="content_{{storyNo}}">{{content}}</pre>
					</div>
				</div>
						<div
							class='row align-items-center border-left border-right border-bottom pb-3'>
							<div
								class="col-12 text-black-50 font-weight-bold text-right text-sm ">{{date}}</div>
						</div>
					</div>
					<div class="col-12 text-right my-3">
						<button type="button" class="btn btn-danger btn-sm storyNo_delete_btn" data-toggle="modal" data-target="#report_modal" onclick="report_modal(this)" data-content="{{content}}"  data-story="{{storyNo}}" data-report="{{reportNo}}" data-member="{{memberNo}}">게시글 삭제</button>
					</div>
				</div>
</script>
<main>
<div class="container-lg">
	<div class="row">
		<div class="jumbotron col-lg-10 offset-lg-1">
		<h3 class="display-5">스토리 신고 내역</h3>
	</div>
		<div class="col-lg-10 offset-lg-1">
				<form class="row" action="">
				<div class="col-2 justify-content-center py-3 px-0 text-nowrap align-items-center d-flex"><strong>글번호</strong></div>
				<div class="col-5 justify-content-center py-3 px-0 text-nowrap align-items-center d-flex"><strong>신고사유</strong></div>
				<div class="col-2 text-nowrap py-3 px-0 align-items-center d-flex">정지여부</div>
				<input type="hidden" value="${page.pageNo}">
				<div class="col-2 justify-content-center py-3 px-0 text-nowrap align-items-center d-flex">
					<select class="custom-select" name="type">
					<c:choose>
						<c:when test='${type=="Y" }'>
							<option  value="all">모두보기</option>
							<option value="N">처리대기</option>
							<option selected value="Y">처리완료</option>
						</c:when>
						<c:when test='${type=="N" }'>
							<option  value="all">모두보기</option>
							<option selected value="N">처리대기</option>
							<option value="Y">처리완료</option>
						</c:when>
						<c:otherwise>
							<option selected value="all">모두보기</option>
							<option value="N">처리대기</option>
							<option value="Y">처리완료</option>
						</c:otherwise>
					</c:choose>

					</select>
				</div>
				<div class="col-1 justify-content-center py-3 px-0 text-nowrap align-items-center d-flex">
					<button type="submit" class="btn btn-primary btn-sm">보기</button>
				</div>
				</form>
		</div>
	</div>
	<div class="row">
		<div class="accordion col-lg-10 offset-lg-1">
		<c:forEach items="${reportList}" var="listItem">
		  <div class="card report_container_${listItem.reportNo}">
		    <div class="card-header row" >
		    	<div class="col-2 d-flex align-items-center">${listItem.no}</div>
		    	<div class="col-5 d-flex align-items-center" id="report_reason_${listItem.reportNo}"><span>${listItem.reason}</span></div>
		    	
		    	<div class="col-1 d-flex align-items-center justify-content-center" id="report_confimr_${listItem.reportNo}">${listItem.reportConfirm}</div>
		    	
		    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">
		    		<button class="btn btn-outline-primary  collapsed detail_btn" type="button" data-toggle="collapse" data-report="${listItem.reportNo}" data-target="#item_${listItem.reportNo}">
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
		    
      	      <div id="in_${listItem.reportNo}" class="card-body container-lg">

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


<!-- 신고 모달 -->
<div class="modal fade" id="report_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-danger" id="exampleModalScrollableTitle">게시글 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body report-val">
       <input id="report_story" type="hidden">
       <input id="report_member" type="hidden">
       <input id="report_no" type="hidden">
       <input id="report_content" type="hidden">
       <input id="report_reason" type="hidden">

       <div class="row">
    		<div class="col-6"><a href="#none">유저 정지</a></div>
    		<div class="input-group mb-3 col-6">
			  <input type="number" min="0" class="form-control" value="0" id="report_day">
			  <div class="input-group-append">
			    <span class="input-group-text" >일</span>
			  </div>
			</div>
       </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary r-c-btn" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-danger r-c-btn" data-dismiss="modal" onclick="delete_comment(this)">게시글 삭제</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>