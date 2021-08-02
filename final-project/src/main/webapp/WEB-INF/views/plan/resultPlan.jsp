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
	width: 65px;
	text-align: center;
    border: 2px solid;
    border-color: lightgray;
    border-radius: 20px;
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
	}
	.hrr {
	margin-top: 1px;
	margin-bottom: 20px;
	}

</style>
<script>
	$(function(){
		
		/* 지도 : 작성자 (정 계진)*/
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(36.812028526492455, 127.87021053246508), // #. 지도의 중심좌표
	        level: 14, // #. 지도의 확대 레벨
	        draggable: false
	    };
		
		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		
		// #. 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [];
		
		var list = [${list}];
		// console.log (list);
		
		for(var i=0; i < list.length; i++){
			if(list[i])
		}
		// EX. 1일차 1번째 장소 & 2일차 1번째 장소 & 3일차 1번째 장소 ...
		
		// 1일차 1번째 좌표
		
		// 마커 이미지의 이미지 주소입니다
		var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
		
		for (var i = 0; i < positions.length; i ++) {
		    
		    // 마커 이미지의 이미지 크기 입니다
		    var imageSize = new kakao.maps.Size(24, 35); 
		    
		    // 마커 이미지를 생성합니다    
		    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
		    
		    // 마커를 생성합니다
		    var marker = new kakao.maps.Marker({
		        map: map, // 마커를 표시할 지도
		        position: positions[i].latlng, // 마커를 표시할 위치
		        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
		        image : markerImage // 마커 이미지 
		    });
		    
		    addMarker(marker);
		}
		
		function addMarker(marker){
			
			// 지정할 마커를 생성해준다
			 var marker = new kakao.maps.Marker({
		        map: marker.getMap(), // 마커를 표시할 지도
		        position: marker.getPosition(), // 마커를 표시할 위치
		        title : marker.getTitle(), // 마커의 타이틀
		        image : marker.getImage() // 마커 이미지 
		    });
			
		}
		
		/* 지도 : 작성자 (정 계진)*/
		
		planSelectService();
		//name();
		
		function planSelectService(){
			
			var ResultPlanVO = [];
			ResultPlanVO = ${list};
			
			// 데이터 정렬
			ResultPlanVO.sort(function(a, b)  {
				  return a.dailyOrder - b.dailyOrder;
			});
			
			// 변수 설정
			var plannerName = ResultPlanVO[0].plannerName
			
			var dailyStayDate = ResultPlanVO[0].dailyStayDate
			$("#planName").text(plannerName);
			$("#date").text(dailyStayDate + "일간의 여행");
			
			
			// 하루 계획표 템플릿 출력 준비
 				var template = $("#result-template").html();
				template = template.replace("{dr}", ResultPlanVO[0].dailyOrder)
				template = template.replace("{dailyNo}", ResultPlanVO[0].dailyNo)
				template = template.replace("{index}", ResultPlanVO[0].dailyOrder)
				$("#result-container").append(template);
			
			  for(var i = 0; i < ResultPlanVO.length - 1; i++) {
				if(ResultPlanVO[i].dailyOrder != ResultPlanVO[i+1].dailyOrder) {
					var template = $("#result-template").html();
					template = template.replace("{dr}", ResultPlanVO[i+1].dailyOrder)
					template = template.replace("{dailyNo}", ResultPlanVO[i+1].dailyNo)
					template = template.replace("{index}", ResultPlanVO[i+1].dailyOrder)
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
				template2 = template2.replace("{dailyplanTransfer}", ResultPlanVO[i].dailyplanTransfer)
				
				$('.box').eq(ResultPlanVO[i].dailyOrder - 1).append(template2);
			 }
		}
	});
</script>
<script type="text/template" id="result-template">
	<!-- 하루 계획표 출력 템플릿 -->
	<div data-index={index}>
	<label class="rt-do">&ensp;{dr} 일차</label>
	<hr class="hrr" style="background-color: lightgray;">
	<div class="box">
	</div>
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
</script>
<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-12 offset-lg-0.5">
				<div class="row my-3 align-items-center">
					<div class="col-3" style="font-size: 1.5rem">
					<span id ="planName"></span>
					</div>
					<div class="col-4">
						<div class="dropdown">
							<a href="#" role="button" id="dropdownMenuLink"
								data-toggle="dropdown"><i class="fas fa-cog fa-1g"></i></a>
							<div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
								<a class="dropdown-item" href="#">플래너 수정</a> <a
									class="dropdown-item" href="#">플래너 삭제</a>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div id="map" style="width:100%;height:350px;"></div>
					<div id ="result-image-template" class="col-4 align-items-center" style="font-size: 1.5rem">
						포토 스토리 연동
					<%-- <img src="${pageContext.request.contextPath}/plan/resultPlan/image?"> --%>
					</div>
				</div>
			</div>
			<div class="col-12">
					<div>
					<b><span id = "date" style="font-size: 22px; color: rgb(66,133,244);" ></span></b>
					</div>
					<br>
				<div>
				</div>
				<div id="result-container"></div>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>