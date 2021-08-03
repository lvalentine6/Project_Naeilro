<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<c:set var="root" value="${pageContext.request.contextPath}"></c:set>
	<c:set var="isLogin" value="${not empty memberNo}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>NAEILRO</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css"
    integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
<link rel="stylesheet" href="../css/layout.css"/>
<style>
	*{
		box-sizing: border-box;
	}
/*  header 관련   */
	header{
		position: relative;
	}
	body{
		height: 200vh;
	}
	.header-img-area{
		width: 100%;
		overflow: hidden;
		position: absolute;
		z-index: -1;
	}
	.header-img{
		width:100%;
		object-fit:cover;
	}
	main{
		margin-top: 25vw;
	}
	li{
		list-style: none;
	}
	 a {color:#000;text-decoration: none; outline: none}

	 a:hover, a:active {text-decoration: none;}

	nav{
		position: fixed;
		width: 100vw;
	}
	nav ul>li{
		margin-left: 2rem;
		
	}
	.scroll{
		background-color: white;
		color:black;
	}
	.intro{
		padding-top: 22vw;
	}
	.intro h4{
		font-weight: 600;
	}
	
	/* 작성자 : 정계진 */
	.aboutDivCon {
		width: 80%;
		margin: 0 auto;
		display: flex;
		flex-direction: column;
	}
	#introDiv2 {
		margin-left: auto;
    	margin-right: auto;
    	margin-bottom: 20px;
	}
	.center .center-align {
		text-align: center;
	}
	.introDivCss {
		padding-top: 50px;
	}
	#introDiv2 h5 {
		font-size: 20px !important;
	}
	h5 {
		line-height: 110%;
		font-weight: 400;
	}
	.introducemyro {
		margin-left: auto;
    	margin-right: auto;
	    margin-top: 40px !important;
	    margin-bottom: 40px !important;
	}
	.col.s6 {
	    width: 50%;
	    margin-left: auto;
	    left: auto;
	    right: auto;
	    float: left;
	    box-sizing: border-box;
	    padding: 0 .75rem;
	    min-height: 1px;
	}
	.headercont {
		padding-bottom: 5px;
    	text-align: center;
    	margin-top: 30px;
	}
	.aboutTextDivLeft {
		width: 100%;
	    padding: 5% 0% 5%;
	    text-align: left;
	}
	.introduce h4 {
		font-size: 24px !important;
	    line-height: 110%;
	    margin: 1.52rem 0 .912rem 0;
	    font-weight: 400;
	}
	.w3-text-grey, .w3-hover-text-grey:hover, .w3-text-gray, .w3-hover-text-gray:hover {
	    color: #757575 !important;
	}
	.introimage {
	    padding-top: 55px !important;
	}
	.introimage img {
	    width: 100% !important;
	   	border-style: none;
	   	margin-top: 50px;
	}
	
		.user_profile{
		border-radius: 100%;
		object-fit:cover;
	}
	.user_profile_sm{
		width: 35px;
		height: 35px;
	}
	.user_profile_lg{
		width: 140px;
		height: 140px;
	}
	.story-photo{
		width: 100%;
		object-fit:cover;
	}
	.text-sm{
		font-size: 14px;
	}
	.like{
		color : #ed4956;
	}
	span.hashtag{
	    color:#007bff;
    }
	span.hashtag:hover{
	    cursor: pointer;
    }
</style>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60b30d68f4da16b4a316665d189e702f&libraries=services"></script>
<!-- icon -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"/>
<!-- bootstrap 이용을 위한 JS 의존성 등록 (jQuery/popper/BS) -->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
    integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous">
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js"
    integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous">
</script>
<script>
	$(function(){
		
		let open = false;
		
		$(window).resize(function(){
			console.log()
			if($( window ).width()>=992&&open){
				$(".menu-btn").click()
			}
		})
		$(window).scroll(function(){
			if($(document).scrollTop()==0 && !open){
				$('nav').addClass("bg-transparent")
				$('nav').removeClass("bg-white")
				$('.cl-text').removeClass("text-black")
				$('.cl-text').addClass("text-white")
			}else{
				$('nav').addClass("bg-white")
				$('nav').removeClass("bg-transparent")
				$('.cl-text').removeClass("text-white")
				$('.cl-text').addClass("text-black")
			}
		})
		$(".menu-btn").click(function(){
			if($(document).scrollTop()==0){
				if(open){
					$('nav').addClass("bg-transparent")
					$('nav').removeClass("bg-white")
					$('.cl-text').removeClass("text-black")
					$('.cl-text').addClass("text-white")
					open=false;
				}else{
					$('nav').addClass("bg-white")
					$('nav').removeClass("bg-transparent")
					$('.cl-text').removeClass("text-white")
					$('.cl-text').addClass("text-black")
					open=true;
				}
			}else{
				if(open){
					open=false;
				}else{
					open=true;
				}
			}
			console.log(open)
			
			
		})
		
		//포토스토리 삭제 링크 클릭 이벤트
		$('.photostory-delete-btn').click(function (e) {
			if (!confirm('정말 삭제하시겠습니까?')) {
				e.preventDefault();
			}
		});
	})
		
	
	
 <c:if test="${block!=null}">
 	$(function(){
 		$(".block_modal").click()
 	})
 </c:if>
 	
 	
 	$(function(){
		
 		$( window ).resize(function() {
 			$(".story-photo").height($('.story-photo').width()+'px')
 		});

 	})

 	$(function(){
 		$(".story-photo").height($('.story-photo').width()+'px')
 		
 		<c:forEach items="${planList}" var="plan">
 		var container = document.getElementById('map_${plan.plannerNo}'); //지도를 담을 영역의 DOM 레퍼런스
 		var options = { //지도를 생성할 때 필요한 기본 옵션
 			center: new kakao.maps.LatLng(${plan.placeLatitude}, ${plan.placeLongitude}), //지도의 중심좌표.
 			draggable: false,
 			level: 10 //지도의 레벨(확대, 축소 정도)
 		};
 		
 		

 		var map = new kakao.maps.Map(container, options);
 		var markerPosition  = new kakao.maps.LatLng(${plan.placeLatitude}, ${plan.placeLongitude}); 

 		// 마커를 생성합니다
 		var marker = new kakao.maps.Marker({
 		    position: markerPosition
 		});

 		// 마커가 지도 위에 표시되도록 설정합니다
 		marker.setMap(map);
 		</c:forEach>

 	})
</script>

<script type="text/javascript">

function like_click(e){
	let like_btn = $(e);
	console.log(like_btn)
	if(${memberNo==null }){
		alert("로그인후 이용해주세요");
		return
	}
		/* 좋아요 삭제 */
	if ($(e).hasClass("like")) {
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
}

function comment_click(e){
if(${memberNo==null }){
	alert("로그인후 이용해주세요");
	return
}
let comment = $(e).parent().prev().children().val();
let comment_div = $(e).parent().prev().children();
let curEl = $(e);
if(!comment){
	return;
}
let photostoryNo = $(e).attr("data-photostoryNo");
$.ajax({
	url:"${pageContext.request.contextPath}/process/insert_comment",
	data : {
		photostoryNo : photostoryNo,
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
	template = template.replaceAll("{{pno}}",photostoryNo)					
	
	$(curEl).parent().parent().prev().prev().prepend(template)
	$('.comment_content_form_'+result).hide()
	comment_count =$(".comment-count").html()*1 + 1
	$(".comment-count").text(comment_count)
	comment_div.val("")
})
.fail(function(){
	console.log('fail');
})
}

function comment_edit_btn_1_click(e){
	$(e).parent().parent().next().hide()
	$(e).parent().parent().next().next().show()
}
function comment_cancel_btn_click(e){
	$(e).parent().parent().parent().parent().hide()
	$(e).parent().parent().parent().parent().prev().show()
}

function comment_edit_btn_click(e){
	let commentNo = $(e).data('no')
	let comment = $(e).parent().prev().val();
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

function comment_delete_btn_click(e){
	let commentNo = $(e).data('no')
	let photostoryNo2 = $(e).data('pno')
	console.log(photostoryNo2)
	if (!window.confirm("정말 삭제하시겠습니까?")){ 
		e.preventDefault()
	}
	$.ajax({
		url:"${pageContext.request.contextPath}/process/delete_comment",
		data : {
			photostoryCommentNo : commentNo,
			photostoryNo : photostoryNo2,
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

$(function(){
	$(".comment_content_form").hide();
})

$(function(){
	/* 댓글 삭제 */
	$('.comment_delete_btn').click(delete_comment)
})


function delete_comment(no,pno){
let commentNo = $(this).data('no')
let photostoryNo2 = $(this).data('pno')
if(!commentNo){
	commentNo=no
}
if(!photostoryNo2){
	photostoryNo2=pno
}
console.log(photostoryNo2)
if (!window.confirm("정말 삭제하시겠습니까?")){ 
	e.preventDefault()
}
$.ajax({
	url:"${pageContext.request.contextPath}/process/delete_comment",
	data : {
		photostoryCommentNo : commentNo,
		photostoryNo : photostoryNo2,
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


function f_follow_btn_click(e){
if(${memberNo==null }){
	alert("로그인후 이용해주세요");
	return
}
let memberNo = $(e).data('memberno');
$.ajax({
	url:"${pageContext.request.contextPath}/memberprocess/insert_follow",
	data : {
		followTo : memberNo,
	},
	method:"GET",
})
.done(function(){
	$('.f-unfollow-btn-'+memberNo).removeClass('d-none')
	$('.f-follow-btn-'+memberNo).addClass('d-none')
})
.fail(function(){
})
}

function f_unfollow_btn_click(e){
let memberNo = $(e).data('memberno');
console.log(memberNo)
$.ajax({
	url:"${pageContext.request.contextPath}/memberprocess/delete_follow",
	data : {
		followTo : memberNo,
	},
	method:"GET",
})
.done(function(){
	$('.f-unfollow-btn-'+memberNo).addClass('d-none')
	$('.f-follow-btn-'+memberNo).removeClass('d-none')
	
})
.fail(function(){
})
}
/* 신고처리 */

function report_btn_click(e){
if($(e).data('storyno')){
	$("#report_no").val($(e).data('storyno'))
	$("#report_type").val('story')
}else{
	$("#report_no").val($(e).data('commentno'))
	$("#report_type").val('comment')
}

$(".report-confirm").hide()
$(".report-val").show()
}



<c:if test="${memberNo==null}">
function report_reason_v_click(e){
 if(${memberNo==null}){
		alert("로그인후 이용해주세요");
		$(".r-c-btn").click()
		e.preventDefault;
		return
	}
	}
</c:if>
<c:if test="${memberNo!=null}">
	function report_reason_v_click(e){
		let no = $("#report_no").val()
	let reason = $(e).text()
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
	}
</c:if>


$(function(){
	$(".dropdown-toggle").focus(function(){
			$(".dropdown_f_menu").show()
			$(".dropdown_f_menu").addClass('show')
			$(".dropdown_f_menu").removeClass('hide')
	})
	$(".dropdown-toggle").click(function(){
		if($(".dropdown_f_menu").hasClass("show")){
			$(".dropdown_f_menu").hide()
			$(".dropdown_f_menu").addClass('hide')
			$(".dropdown_f_menu").removeClass('show')
		}else{

		}
	})

})

$(function(){
	$(".search_bar").on('input',function(){
		$(".dropdown_f_menu").empty()
		$(".dropdown_f_menu").show()
		$(".dropdown_f_menu").addClass('show')
		$(".dropdown_f_menu").removeClass('hide')
		let keyword = $(this).val()
		$.ajax({
			url:"${pageContext.request.contextPath}/process/search",
			data : {
				keyword : keyword
			},
			method:"GET",
			dataType: 'json',
		})
		.done(function(json){
			if(keyword[0]=="#"){
				
				for(let i=0;i<json.tagPreview.length;i++){
					let temp = $("#preview-tag").html()
					temp=temp.replaceAll("{{keyword}}",json.tagPreview[i].hashtagTag)
					temp=temp.replaceAll("{{count}}",json.tagPreview[i].count)
					$(".dropdown_f_menu").append(temp);
				}
				for(let i=0;i<json.memberPreview.length;i++){
					let temp = $("#preview-user").html()
					temp=temp.replaceAll("{{name}}",json.memberPreview[i].memberName)
					temp=temp.replaceAll("{{nick}}",json.memberPreview[i].memberNick)
					temp=temp.replaceAll("{{memberNo}}",json.memberPreview[i].memberNo)
					$(".dropdown_f_menu").append(temp);
				}
			}else{
				for(let i=0;i<json.memberPreview.length;i++){
					let temp = $("#preview-user").html()
					temp=temp.replaceAll("{{name}}",json.memberPreview[i].memberName)
					temp=temp.replaceAll("{{nick}}",json.memberPreview[i].memberNick)
					temp=temp.replaceAll("{{memberNo}}",json.memberPreview[i].memberNo)
					$(".dropdown_f_menu").append(temp);
				}
				for(let i=0;i<json.tagPreview.length;i++){
					let temp = $("#preview-tag").html()
					temp=temp.replaceAll("{{keyword}}",json.tagPreview[i].hashtagTag)
					temp=temp.replaceAll("{{count}}",json.tagPreview[i].count)
					$(".dropdown_f_menu").append(temp);
				}
			}
			console.log(json)
		})
		.fail(function(){
			console.log('실패')
		})
	})
	
	
	$(".hashtag").click(function(){
		console.log()
		text=$(this).text().replaceAll(/\s/g,'');
		$('.search_bar').val(text)
		$('.search_form').submit();
	})
})
function go_user_page(nick){
	location.href="${pageContext.request.contextPath}/member/profile/"+nick
}
function go_page(k){
	text=k.replaceAll(/\s/g,'');
	$('.search_bar').val(text)
	$('.search_form').submit();
}

</script>

<script type="text/template" id="preview-user">
	<div class="dropdown-item row d-flex align-items-center" onclick="go_user_page('{{nick}}')">
		<div class="col-2 "><img class="my-2 user_profile_sm user_profile"
		src="${pageContext.request.contextPath}/member/profile/profileImage?memberNo={{memberNo}}"
		onerror="this.src='${pageContext.request.contextPath}/image/default_user_profile.jpg'"></div>
		<div class="col-4">{{nick}}</div>
		<div class="col-1 offset-3">{{name}}</div>
	</div>	
</script>
<script type="text/template" id="preview-tag">
	<div class="dropdown-item py-2 row d-flex align-items-center" onclick="go_page('{{keyword}}')">
		<div class="col-2 "><i class="fas fa-hashtag fa-2x"></i></div>
		<div class="col-4">{{keyword}}</div>
		<div class="col-1 offset-3">게시물 {{count}}</div>
	</div>
</script>
<script type="text/template" id="comment-tpl">
						<div class="col-11 text-sm text-break" id="comment_1_{{no}}" >
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
											data-no="{{no}}" data-pno="{{pno}}" onclick="comment_delete_btn_click(this)" 
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
</head>
<body>
	<header>
		<div class="header-img-area">
			<img class="header-img" src="image/bgimg.webp">
		</div>
		
		<nav class="navbar navbar-expand-lg px-lg-5 navbar-light bg-transparent  shadow-sm fixed-top">
		  <a class="navbar-brand text-white cl-text" href="${root}">NAEILRO</a>
		  <button class="navbar-toggler border-0 menu-btn" type="button" data-toggle="collapse" data-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="text-white  cl-text">
		    	<i class="fas fa-bars "></i>
		    </span>
		  </button>
		  <div class="collapse navbar-collapse text-right" id="navbarText">
		    <ul class="navbar-nav mr-auto text-right pr-3">
<!-- 		      <li class="nav-item"> -->
<!-- 		        <a class="nav-link d-inline-block text-white cl-text" href="#">여행지</a> -->
<!-- 		      </li> -->
		      <li class="nav-item">
		        <a class="nav-link d-inline-block text-white cl-text" href="${root}/photostory">스토리</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link d-inline-block text-white cl-text" href="${root}/plan">일정</a>
		      </li>
		      <li class="nav-item">
		        <a class="nav-link d-inline-block text-white cl-text" href="#">이용방법</a>
		      </li>
		    </ul>
		    <span class="navbar-text text-right pr-3">
		      <c:choose>
		      <c:when test="${isLogin && memberDto.memberGrade == 1}">
					<a class="mr-3 text-white cl-text" href="${root}/member/logout">로그아웃</a>
					<a class="mr-3 text-white cl-text" href="${root}/admin/">관리자페이지</a>
					</c:when>
					<c:when test="${isLogin}">
						<a class="mr-3 text-white cl-text" href="${root}/member/logout">로그아웃</a>
						<a class="text-white cl-text" href="${root}/member/profile/${memberDto.memberNick}">마이페이지</a>
					</c:when>
					<c:otherwise>
						<a class="mr-3 text-white cl-text"  href="${root}/member/login">로그인</a>
						<a class="text-white cl-text"  href="${root}/member/join">회원가입</a>
					</c:otherwise>
				</c:choose>
		    </span>
		  </div>
		</nav>
		
		<div class="container-lg">
			<div class="intro">
				<h4 class="text-center">나만의 여행 플래너 NAEILRO!<br> 쉽고 빠르게 여행을 계획하세요.</h4>	
			</div>
			<div class="d-flex justify-content-center">
				<button type="button" class="btn btn-primary btn-lg mt-2">시작하기</button> 
			</div>
		</div>
	</header>
	
	<main>
		<div class="container-lg">
			<div class="row">
				<h1 class="my-5">다른 여행자들 플래너</h1>
			</div>
			<div class="row">
			<c:forEach items="${planList}" var="plan">
				<div class="col-4 px-0 pr-1 mb-2">
				<div class="card w-100 story-photo">
				<div id="map_${plan.plannerNo}"class="w-100 h-75 card-img-top"></div>
				  <div class="card-body">
				    <p class="card-text"><a href="${pageContext.request.contextPath}/plan/resultPlan?plannerNo=${plan.plannerNo}">${plan.plannerName }</a></p>
				  </div>
				</div>
		    	</div>
		    </c:forEach>
			</div>	
			
			
			<div class="row">
				<h1 class="my-5">스토리</h1>
			</div>
			
			
	<c:forEach var="photostoryListDto" items="${photostoryList}">
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
							<a class="font-weight-bold text-nowrap"
								href="${pageContext.request.contextPath}/member/profile/${photostoryListDto.memberNick}">${photostoryListDto.memberNick}
							</a>
						</div>
						<div class="col-1 offset-7 text-right">
							<a href="#" role="button" id="dropdownMenuLink"
									data-toggle="dropdown"><i class="fas fa-ellipsis-h"></i></a>
									
								<c:choose>
									<c:when test="${photostoryListDto.memberNo==memberNo}">
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<a class="dropdown-item text-danger photostory-delete-btn" 
											href="${pageContext.request.contextPath}/photostory/delete?photostoryNo=${photostoryListDto.photostoryNo}&home">삭제</a> 
											<a class="dropdown-item " 
											href="${pageContext.request.contextPath}/photostory/edit?photostoryNo=${photostoryListDto.photostoryNo}">수정</a> 
											<a class="dropdown-item" >취소</a> 
										</div>
									</c:when>
									<c:otherwise>
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<a class="dropdown-item text-danger report-btn" onclick="report_btn_click(this)" data-storyno="${photostoryListDto.photostoryNo}" data-toggle="modal" data-target="#report_modal">게시글 신고</a> 
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
									<i class="fa-heart fa-lg like-btn fas like" onclick="like_click(this)" data-photostoryNo="${photostoryListDto.photostoryNo}"></i>
								</c:when>
								<c:otherwise>
									<i class="fa-heart fa-lg like-btn far" onclick="like_click(this)" data-photostoryNo="${photostoryListDto.photostoryNo}"></i> 
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
								      		<div class="offset-2 col-4 text-right f-unfollow-btn-${followingList.member.memberNo}"><button class="btn btn-outline-secondary f-unfollow-btn f-unfollow-btn " onclick="f_unfollow_btn_click(this)" data-memberNo='${followingList.member.memberNo}'>팔로우 <i class="fas fa-check"></i></button></div>
								      		<div class="offset-2 col-4 text-right d-none f-follow-btn-${followingList.member.memberNo}"><button class="btn btn-primary f-follow-btn " onclick="f_follow_btn_click(this)" data-memberNo='${followingList.member.memberNo}'>팔로우</button></div>
						      			</c:when>
						      			<c:otherwise >
						      				<c:choose>
								      			<c:when test="${followingList.member.memberNo==memberNo}">
								      				
								      			</c:when>
								      			<c:otherwise>
										      		<div class="offset-2 col-4 text-right d-none f-unfollow-btn-${followingList.member.memberNo}"><button class="btn btn-outline-secondary f-unfollow-btn f-unfollow-btn " onclick="f_unfollow_btn_click(this)" data-memberNo='${followingList.member.memberNo}'>팔로우 <i class="fas fa-check"></i></button></div>
										      		<div class="offset-2 col-4 text-right f-follow-btn-${followingList.member.memberNo}"><button class="btn btn-primary f-follow-btn " onclick="f_follow_btn_click(this)" data-memberNo='${followingList.member.memberNo}'>팔로우</button></div>
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
							${photostoryListDto.photostoryContent}
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
											data-pno="${photostoryListDto.photostoryPhotoNo}"
											onclick="comment_delete_btn_click(this)"
											>삭제</a> 
											<a class="dropdown-item comment_edit_btn_1" onclick="comment_edit_btn_1_click(this)"
											>수정</a> 
											<a class="dropdown-item" >취소</a> 
										</div>
									</c:when>
									<c:otherwise>
										<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
											<a class="dropdown-item text-danger report-btn" onclick="report_btn_click(this)" data-commentno="${photostoryCommentListDto.photostoryCommentNo}" href="#" data-toggle="modal" data-target="#report_modal">댓글 신고</a> 
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
								    <button class="btn btn-outline-primary comment_edit_btn" onclick="comment_edit_btn_click(this)" id="comment_edit_id_${photostoryCommentListDto.photostoryCommentNo}" type="button" data-no="${photostoryCommentListDto.photostoryCommentNo}">수정</button>
								    <button class="btn btn-outline-secondary comment_cancel_btn" onclick="comment_cancel_btn_click(this)" type="button">취소</button>
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
								data-photostoryNo="${photostoryListDto.photostoryNo}" onclick="comment_click(this)">게시</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
			<div id="aboutDiv" class="row aboutDivCon"  style="background-color: #fdfdfd">
					<div id="introDiv2">
						<div class="center introDivCss" style="text-align: center">
							<h5>쉽고 간편한 일정 플래너 <b>내일로(NAEILRO)</b></h5>
							<br>
							<h5 style="line-height: 200%;color:#757575">여행 일정 짜는 평균시간은 10시간, 이제 5분만에 해결하세요</h5>
						</div>
						<section id="about2">
							<article id="about">
								<div class="introduce">
									<div class="col s6">
										<div class="headercont">
											<div class="scrollspy"></div>
											<div class="aboutTextDivLeft">
												<h4>누구나 할 수 있는</h4>
												<h4><b>간편한 일정 작성</b></h4>
												<br>
												<h5 class="w3-text-grey">여행 일자, 숙소,<br><br>가고 싶은 장소만<br><br>선택해서 담으면 되는<br><br>간편하고 편리한 일정 작성</h5>
											</div>
										</div>
									</div>
									<div class="col s6 introimage" style="text-align: left;">
                            			<img style="" src="image/intro1.jpg" alt="introimage">
                        			</div>
								</div>
							</article>
						</section>
					</div>
			</div>
		</div>
	</main>
	
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
    		<div class="col-12"><a class="d-block report_reason_v" onclick="report_reason_v_click(this)" href="#none">스팸</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" onclick="report_reason_v_click(this)" href="#none">혐오 발언 또는 상징</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" onclick="report_reason_v_click(this)" href="#none">폭력 또는 위험한 단체</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" onclick="report_reason_v_click(this)" href="#none">불법 또는 규제 상품 판매</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" onclick="report_reason_v_click(this)" href="#none">따돌림 또는 괴롭힘</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" onclick="report_reason_v_click(this)" href="#none">지적 재산권 침해</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" onclick="report_reason_v_click(this)" href="#none">사기 또는 거짓</a></div>
       </div>
       <hr>
       <div class="row">
    		<div class="col-12"><a class="d-block report_reason_v" onclick="report_reason_v_click(this)" href="#none">마음에 들지 않습니다</a></div>
       </div>
      </div>
      
       <input id="report_no" type="hidden">
       <input id="report_type" type="hidden">
       
		<div class="modal-body report-confirm">
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
	
	
	<form class="w-100 search_form d-none" action="${pageContext.request.contextPath}/photostory" method="GET">
		  <div class="form-group input-group mb-3 dropdown">
			  <input type="text" value="${searchKeyword}" class="form-control dropdown-toggle search_bar" name="searchKeyword" placeholder="검색어를 입력해주세요 . . ." >
			    <div class="dropdown-menu dropdown_f_menu w-100" aria-labelledby="dropdownMenuButton">

				  </div>
			  <div class="input-group-append">
			    <button class="btn btn-outline-secondary" type="submit">검색</button>
			  </div>
		  </div>
	</form>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	