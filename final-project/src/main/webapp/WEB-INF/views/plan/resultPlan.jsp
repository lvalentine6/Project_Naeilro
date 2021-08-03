<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60b30d68f4da16b4a316665d189e702f&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	input:focus {
	outline:none;
	}
	.result-input{
	border: none;
	width: 80px;
	text-align: center;
	
	}
	.rt-do{
	font-size: 17px;
	margin: none;
	}
	.result-input-p{
	width: 200px;
	text-align: center;
    border: 2px solid;
    border-color: lightgray;
    border-radius: 20px;
    margin-bottom: 1rem;
	}
	.result-input-t{
	width: 65px;
	text-align: center;
	border-bottom: none;
	border-left: none;
	border-right: none;
	border-top: 1px dashed;
	border-color:rgb(66,133,244);
	margin-left: 20px;
	margin-right: 20px;
	margin-bottom: 1rem;
	}
	.hrr {
	margin-top: 1px;
	margin-bottom: 20px;
	}
	.story-photo{
	margin-rignt: 0.5rem;
	margin-top: 0.5rem;
	}

</style>
<script>
	$(function(){
		
		$(".story-photo").height($('.story-photo').width()+'px')
		
		$( window ).resize(function() {
			$(".story-photo").height($('.story-photo').width()+'px')
		});
		
		
		planSelectService();
		
		function planSelectService(){
			
			var ResultPlanVO = [];
			ResultPlanVO = ${jlist};

			// 데이터 정렬
			ResultPlanVO.sort(function(a, b)  {
				  return a.dailyOrder - b.dailyOrder;
			});
			
			// 변수 설정
			var plannerName = ResultPlanVO[0].plannerName
			
			var dailyStayDate = ResultPlanVO[0].dailyStayDate
			$("#planName").text(plannerName);
			$("#plannerNo").attr("value", ResultPlanVO[0].plannerNo);
			$("#date").text(dailyStayDate + "일간의 여행");
			
			
			// 하루 계획표 템플릿 출력 준비
 				var template = $("#result-template").html();
				template = template.replace("{dr}", ResultPlanVO[0].dailyOrder)
				template = template.replace("{dailyNo}", ResultPlanVO[0].dailyNo)
				template = template.replace("{index}", ResultPlanVO[0].dailyOrder)
				template = template.replace("{place-region}", ResultPlanVO[0].placeRegion)
				$("#result-container").append(template);
			
			  for(var i = 0; i < ResultPlanVO.length - 1; i++) {
				if(ResultPlanVO[i].dailyOrder != ResultPlanVO[i+1].dailyOrder) {
					var template = $("#result-template").html();
					template = template.replace("{dr}", ResultPlanVO[i+1].dailyOrder)
					template = template.replace("{dailyNo}", ResultPlanVO[i+1].dailyNo)
					template = template.replace("{index}", ResultPlanVO[i+1].dailyOrder)
					template = template.replace("{place-region}", ResultPlanVO[i+1].placeRegion)
					$("#result-container").append(template);
				}
			 } 
			
			// 재정렬
			ResultPlanVO.sort(function(a, b)  {
				 return a.dailyplanPlaceOrder - b.dailyplanPlaceOrder;
			});
			  
			// 여행 계획 템플릿 데이터 삽입
			 for(var i = 0; i < ResultPlanVO.length; i++) {
				var template2 = $("#plan-template").html();
				template2 = template2.replace("{placeNo}", ResultPlanVO[i].placeNo)
				template2 = template2.replace("{placeName}", ResultPlanVO[i].placeName)
				template2 = template2.replace("{dailyplanPlaceOrder}", ResultPlanVO[i].dailyplanPlaceOrder)
				template2 = template2.replace("{plannerOpen}", ResultPlanVO[i].plannerOpen)
				template2 = template2.replace("{memberNo}", ResultPlanVO[i].memberNo)
				template2 = template2.replace("{dailyNo}", ResultPlanVO[i].dailyNo)
				template2 = template2.replace("{dailyStayDate}", ResultPlanVO[i].dailyStayDate)
				template2 = template2.replace("{dailyOrder}", ResultPlanVO[i].dailyOrder)
				template2 = template2.replace("{placeNo}", ResultPlanVO[i].placeNo)
				template2 = template2.replace("{placeLatitude}", ResultPlanVO[i].placeLatitude)
				template2 = template2.replace("{placeLongitude}", ResultPlanVO[i].placeLongitude)
				template2 = template2.replace("{placeType}", ResultPlanVO[i].placeType)
				template2 = template2.replace("{placeRegion}", ResultPlanVO[i].placeRegion)
				template2 = template2.replace("{dailyplanTransfer}", ResultPlanVO[i].dailyplanTransfer)
				$('.box').eq(ResultPlanVO[i].dailyOrder - 1).append(template2);
			 }
		}
		
		/* 지도 : 작성자 (정 계진)*/
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(35.95494673287157, 130.58040669607263), // #. 지도의 중심좌표
	        level: 20, // #. 지도의 확대 레벨
	        //draggable: false
	    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// #. 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [
		    {
		        title: '제주도', 
		        latlng: new kakao.maps.LatLng(33.511111, 126.492778)
		    },
		    {
		        title: '부산', 
		        latlng: new kakao.maps.LatLng(35.114992, 129.042089)
		    },
		    {
		    	title: '안동',
		    	latlng: new kakao.maps.LatLng(36.566667, 128.716667)
		    },
		    {
		    	title: '서울',
		    	latlng: new kakao.maps.LatLng(37.566667, 126.978056)
		    },
		    {
		    	title: '강릉',
		    	latlng: new kakao.maps.LatLng(37.75, 128.9)
		    },
		    {
		    	title: '대구',
		    	latlng: new kakao.maps.LatLng(35.871389, 128.601389)
		    },
		    {
		    	title: '경주',
		    	latlng: new kakao.maps.LatLng(36.856043, 129.224953)
		    },
		    {
		    	title: '춘천',
		    	latlng: new kakao.maps.LatLng(37.884797, 127.716908)
		    },
		    {
		    	title: '인천',
		    	latlng: new kakao.maps.LatLng(37.456111, 126.705278)
		    },
		    {
		    	title: '전주',
		    	latlng: new kakao.maps.LatLng(35.821944, 127.148889)
		    },
		    {
		    	title: '여수',
		    	latlng: new kakao.maps.LatLng(34.760374, 127.662222)
		    },
		    {
		    	title: '대전',
		    	latlng: new kakao.maps.LatLng(36.350833, 127.385)
		    },
		    {
		    	title: '광주',
		    	latlng: new kakao.maps.LatLng(35.159444, 126.8525)
		    }
		];
		
		var list = ${jlist};
		
		var linePath = [];
		// EX. 1일차 1번째 장소 & 2일차 1번째 장소 & 3일차 1번째 장소 ...
		for(var i=0; i < list[0].dailyStayDate; i++){
			
			var placeRegion = $('.box').eq(i).find('input[name=placeRegion]').val();
			
			console.log("지명 : " + placeRegion);
			
			for(var j=0; j < positions.length; j++){
				if(positions[j].title == placeRegion){
					
					linePath.push(positions[i].latlng);
					
					var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
					
					var imageSize = new kakao.maps.Size(24, 35); 
					
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
					
					var marker = new kakao.maps.Marker({
						map: map,
				    	position: positions[i].latlng,
				    	image : markerImage
					});
					// 지도에 표시할 선을 생성합니다
					var polyline = new kakao.maps.Polyline({
					    path: linePath, // 선을 구성하는 좌표배열 입니다
					    strokeWeight: 5, // 선의 두께 입니다
					    strokeColor: '#000000', // 선의 색깔입니다
					    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
					    strokeStyle: 'solid' // 선의 스타일입니다
					});
					
					// 지도에 선을 표시합니다 
					polyline.setMap(map);
				}
			}
		}
		/* 지도 : 작성자 (정 계진)*/
		
		// 플래너 삭제 링크 클릭 이벤트
		$('.planner-delete-btn').click(function (e) {
			if (!confirm('정말 삭제하시겠습니까?')) {
				e.preventDefault();
			}
		});
	});
</script>
<script type="text/template" id="result-template">
	<!-- 하루 계획표 출력 템플릿 -->
	<div data-index={index}>
		<label class="rt-do">&ensp;{dr} 일차 : {place-region}</label>
		<hr class="hrr" style="background-color: lightgray;">
		<div class="box"></div>
	</div>
	<br>
</script>
<script type="text/template" id="plan-template">
	<!-- 여행 계획 출력 템플릿 -->
	<input class="result-input" type="hidden" name="plannerNo" value={plannerNo} readonly>
	<input class="result-input" type="hidden" name="plannerOpen" value={plannerOpen} readonly>
    <input class="result-input" type="hidden" name="plannerName" value={plannerName} readonly>
    <input class="result-input" type="hidden" name="memberNo" value={memberNo} readonly>
    <input class="result-input" type="hidden" name="dailyNo" value={dailyNo} readonly>
	<input class="result-input" type="hidden" name="dailyplanPlaceOrder" value={dailyplanPlaceOrder} readonly>
    <input class="result-input" type="hidden" name="dailyStayDate" value={dailyStayDate} readonly> 
    <input class="result-input" type="hidden" name="dailyOrder" value={dailyOrder} readonly>
    <input class="result-input" type="hidden" name="placeNo" value={placeNo} readonly>
    <input class="result-input" type="hidden" name="placeLatitude" value={placeLatitude} readonly>
    <input class="result-input" type="hidden" name="placeLongitude" value={placeLongitude} readonly>
    <input class="result-input-t" type="text" name="dailyplanTransfer" value={dailyplanTransfer} readonly style="font-size: 16px;">
    <input class="result-input-p" type="text" name="placeName" value={placeName} readonly style="font-size: 19px;">
    <input class="result-input" type="hidden" name="placeType" value={placeType} readonly>
	<input class="result-input" type="hidden" name="placeRegion" value={placeRegion} readonly>
</script>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-12 offset-lg-0.5 pt-4">
				<div class="row my-3 align-items-center">
					<div class="col-3" style="font-size: 1.5rem">
					<h1 id ="planName"></h1>
					<input type="hidden" id="plannerNo">
					</div>
					<div class="col-4">
						<div class="dropdown">
							<a href="#" role="button" id="dropdownMenuLink"
								data-toggle="dropdown"><i class="fas fa-cog fa-1g"></i></a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<a class="dropdown-item" href="${pageContext.request.contextPath}/plan/editplan?plannerNo=${param.plannerNo}" >플래너 수정</a> 
								<a class="dropdown-item planner-delete-btn" href="${pageContext.request.contextPath}/plan/deleteplan?plannerNo=${param.plannerNo}" >플래너 삭제</a>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div id="map" style="width:100%;height:350px;"></div>

				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-12">
					<div>
					<b><span id = "date" style="font-size: 22px; color: rgb(66,133,244);" ></span></b>
					</div>
					<br>
					<div>
					</div>
					<div id="result-container">
					</div>
				</div>
			</div>
		<div class="row">			
			<div class="col-12 d-flex align-items-center">
				<b><span style="font-size: 22px; color: rgb(66,133,244); margin-right: 1rem; margin-bottom: 2rem" >포토스토리</span></b>
				<a class="btn btn-outline-primary btn-sm" id="p_w_btn" href="${pageContext.request.contextPath}/photostory/write?plannerNo=${param.plannerNo}" role="button">글쓰기</a>
			</div>
		</div>
		<div class="row">
				<c:forEach items="${photoStroyList}" var="photoStory">
					<div class="col-4 align-items-center" style="font-size: 1.5rem">
							<c:if test="${not empty photoStory.photostoryPhotoNo}">
							   <a href="${pageContext.request.contextPath}/photostory/detail?photostoryNo=${photoStory.photostoryNo}"><img class="w-100 story-photo" src="${pageContext.request.contextPath}/photostory/photo/${photoStory.photostoryPhotoNo}" /></a>
							</c:if>
					</div>
				</c:forEach>
			</div>
		</div>

</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>