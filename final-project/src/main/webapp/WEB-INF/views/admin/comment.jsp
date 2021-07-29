<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<main>
	<div class="accordion">
	
	  <div class="card">
	    <div class="card-header row" >
	    	<div class="col-8 d-flex align-items-center">신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유</div>
	    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">
	    		<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#item_1">
	          		자세히
	        	</button>
	    	</div>
	    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">삭제</div>
	    </div>
	    <div id="item_1" class="collapse">
	      <div class="card-body row align-items-center border-left border-right pb-1 text-wrap">
			<div class="col-12 text-sm text-break">
				<img class="my-2 user_profile_sm user_profile" src="${pageContext.request.contextPath}/image/default_user_profile.jpg">
				&nbsp;
				<a href="#">
					<strong>유저닉네임</strong>
				</a>
				&nbsp;
				2021.07.23
				<div>
				댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용 댓글내용댓글내용댓글내용댓글내용 댓글내용댓글내용댓글내용
				</div>
			</div>
	      </div>
	    </div>
	  </div>
	
	  <div class="card">
	    <div class="card-header row" >
	    	<div class="col-8 d-flex align-items-center">신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유</div>
	    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">
	    		<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#item_2">
	          		자세히
	        	</button>
	    	</div>
	    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">삭제</div>
	    </div>
	    <div id="item_2" class="collapse">
	      <div class="card-body container-lg">
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
							&nbsp;&nbsp; 글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용 글내용글내용글내용글내용글내용글내용글내용글내용글내용글내용
						</div>
					</div>
					<div
						class='row align-items-center border-left border-right border-bottom pb-3'>
						<div
							class="col-12 text-black-50 font-weight-bold text-right text-sm ">40일 전</div>
					</div>
				</div>
			</div>
	      </div>
	    </div>
	  </div>
	
	  <div class="card">
	    <div class="card-header row" >
	    	<div class="col-8 d-flex align-items-center">신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유신고사유</div>
	    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">
	    		<button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#item_3">
	          		자세히
	        	</button>
	    	</div>
	    	<div class="col-2 d-flex align-items-center text-nowrap justify-content-center">삭제</div>
	    </div>
	    <div id="item_3" class="collapse">
	      <div class="card-body">
	      		댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용댓글내용
	      </div>
	    </div>
	  </div>
	
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>