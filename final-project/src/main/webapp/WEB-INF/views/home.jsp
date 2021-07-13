<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
		$(window).scroll(function(){
			if($(document).scrollTop()==0){
				$('nav').removeClass("scroll shadow-sm");
				$('nav ul a').addClass("text-white");
				$('nav h1').addClass("text-white");
				$('nav ul a').removeClass("text-black");
			}else{
				$('nav').addClass("scroll shadow-sm");
				$('nav ul a').removeClass("text-white");
				$('nav h1').removeClass("text-white");
				$('nav ul a').addClass("text-black");
			}
		})
	})
</script>
</head>
<body>
	<header >
		<div class="header-img-area">
			<img class="header-img" src="image/bgimg.webp">
		</div>
		<nav>
			<div class="container">
				<div class="row">
					<div class="col-2">
						<h1 class="h-100 text-white">LOGO</h1>
					</div>
					<div class="col">
						<ul class="d-flex align-items-center h-100 font-weight-bold text-white">
							<li><a class="text-white" href="#">여행지</a></li>
							<li><a class="text-white" href="#">일정</a></li>
							<li><a class="text-white" href="#">스토리</a></li>
							<li><a class="text-white" href="#">이용방법</a></li>
						</ul>
					</div>
					<div class="col">
						<ul class="d-flex justify-content-end align-items-center h-100 font-weight-bold text-white">
							<li><a class="text-white" href="login">로그인</a></li>
							<li><a class="text-white" href="member/join">회원가입</a></li>
						</ul>
					</div>
				</div>
			</div>
		</nav>
		<div class="container">
			<div class="intro">
				<h4 class="text-center">나만의 여행 플래너 LOGO!<br> 쉽고 빠르게 여행을 계획하세요.</h4>	
			</div>
			<div class="d-flex justify-content-center">
				<button type="button" class="btn btn-primary btn-lg mt-2">시작하기</button>
			</div>
		</div>
	</header>
	
	<main>
		<div class="container">
			<div class="row">
				<h1>다른 여행자들 플래너</h1>
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
	<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
	