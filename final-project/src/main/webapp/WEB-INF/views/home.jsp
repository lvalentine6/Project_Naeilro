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
</style>
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
		
	
	
 <c:if test="${block!=null}">
 	$(function(){
 		$(".block_modal").click()
 	})
 </c:if>
 	
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
		        <a class="nav-link d-inline-block text-white cl-text" href="#">일정</a>
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
				<h1>다른 여행자들 플래너</h1>
				      	${block.BlockContent}
      	${block.BlockEndDate}
      	${block.BlockStartDate}
      	${block.BlockReason}
				<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			</div>
			<div class="row">
				<h1>스토리</h1>
				<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			</div>
			<div class="row">
				<h1>이용방법</h1>
				<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			</div>
		</div>
	</main>
	
	
<button type="button" class="btn btn-primary d-none block_modal" data-toggle="modal"  data-target="#block_modal">

</button>

<!-- Modal -->
<div class="modal fade" id="block_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">회원정지로 이용이 제한됩니다.</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body row">
      	${block.BlockContent}
      	${block.BlockEndDate}
      	${block.BlockStartDate}
      	${block.BlockReason}
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	