<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플래너</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60b30d68f4da16b4a316665d189e702f&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		
		// 콜백 함수 : 지도 생성 및 결과 출력
		function showMapFunc(key1, key2, lat, lng) {
			// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
			
			// #. 지도 전체 레벨 선출력
			var lat = 35.95;
			var lng = 128.25;
				
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
		        level: 7 // 지도의 확대 레벨
		    };
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
	
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();
			
			// 키워드 검색 완료 시 호출되는 콜백함수 입니다
			function placesSearchCB (data, status, pagination) {
	    		if (status === kakao.maps.services.Status.OK) {
	
	        	// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        	// LatLngBounds 객체에 좌표를 추가합니다
	        	var bounds = new kakao.maps.LatLngBounds();
	
	        	for (var i=0; i<data.length; i++) {
	            	displayMarker(data[i]);    
	            	bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        	}       
	
	        	// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	        	map.setBounds(bounds);
	    		} 
			}
			
			// 지도에 마커를 표시하는 함수입니다
			function displayMarker(place) {
			    
			    // 마커를 생성하고 지도에 표시합니다
			    var marker = new kakao.maps.Marker({
			        map: map,
			        position: new kakao.maps.LatLng(place.y, place.x) 
			    });
	
			    // 마커에 클릭이벤트를 등록합니다
			    kakao.maps.event.addListener(marker, 'click', function() {
					
			        
			        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			        infowindow.setContent(
			        	'<div style="padding:5px;font-size:12px;">' + place.place_name + 
			        		'<form>' +
			        			'<input type="hidden" name="placeName" value=' + key1 + '/>' +
			        			'<input type="hidden" name="placeType" value=' + key2 + '/>' +
			        			// 위도 & 경도 처리 여부 예정
			        			'<button id="getLatLng">선택</button>' + 
			        		'</form>' +
			        	'</div>');
			        infowindow.open(map, marker);
			     	
			        // AJAX 실행 시점 (매우 중요!)
					$("#getLatLng").click(function(){
						
						// ?. 이게 왜 무조건 있어야 되지...?
						var position = marker.getPosition();
							
						// 위도 & 경도 : NUMBER > STRING 형변환
						var getLat = String(position.getLat());
						var getLng = String(position.getLng());
						
						console.log(typeof getLat);
						console.log(typeof getLng);
						
						// 지명(key1) & 유형(key2) : STRING
						console.log(key1);
						console.log(key2);
						
						// AJAX
						$.ajax({
							url:"${pageContext.request.contextPath}/data/place",
							type: "post",
							data: {
								
							},
							success: function(resp){
								
							}
						});
						
					});
			        
			    });
			}
			
			// 검색 클릭 시, 이벤트 실행
			$("#find").click(function(){
				
				// 키워드 값 객체를 생성 
				var input = key1 + key2 + $("#keyword").val();
				
				// 키워드로 장소를 검색합니다
				ps.keywordSearch(input, placesSearchCB); 
			});	
			
		};
		
		// 글로벌 변수 : 지명
		var busan = $("#busan").val();
		var andong = $("#andong").val();
		
		// 글로벌 변수 : 유형
		var hotel =$("#hotel").val();
		var tour = $("#tour").val();
		
		
		// 1-1. 장소 지명
		$("#busan").click(function(){
			$("#andong").removeAttr("style");
			$(this).attr('style', 'border:1px solid');
			
			// 2-1. 장소 유형 : 호텔
			$("#hotel").click(function(){
				$("#tour").removeAttr("style");
				$(this).attr('style', 'border:1px solid');
				
				// 지역변수 - 중심좌표 : 위도 & 경도
				var lat = 35.1379222;
				var lng = 129.05562775;
				
				// 결과 출력
				showMapFunc(busan, hotel, lat, lng);
			});
			
			// 2-2. 장소 유형 : 관광지
			$("#tour").click(function(){
				$("#hotel").removeAttr("style");
				$(this).attr('style', 'border:1px solid');
				
				// 중심좌표 : 위도 + 경도
				var lat = 35.1379222;
				var lng = 129.05562775;
				
				showMapFunc(busan, tour, lat, lng);
			});
			
		// 부산 로직 끝
		});
	
		// 1-1. 장소 지명
		$("#andong").click(function(){
			$("#busan").removeAttr("style");
			$(this).attr('style', 'border:1px solid');
			
			// 2-1. 장소 유형 : 호텔
			$("#hotel").click(function(){
				$("#tour").removeAttr("style");
				$(this).attr('style', 'border:1px solid');
				
				// 중심좌표 : 위도 + 경도
				var lat = 35.1379222;
				var lng = 128.716667;
				
				showMapFunc(andong, hotel, lat, lng);
				
				// AJAX로 데이터 전송 (예정)			
			});
			
			// 2-2. 장소 유형 : 관광지
			$("#tour").click(function(){
				$("#hotel").removeAttr("style");
				$(this).attr('style', 'border:1px solid');
				
				// 중심좌표 : 위도 + 경도
				var lat = 35.1379222;
				var lng = 128.716667;
				
				showMapFunc(andong, tour, lat, lng);
				
				// AJAX로 데이터 전송 (예정)
				
			});
		// 안동 로직 끝
		});
		
	// 제이쿼리 끝
	});
		
</script>
</head>
<body>
	<!-- DB 전송-->
	
	<!-- #. 검색 키워드로 API를 통해 검색 결과 출력 (대충 완료) -->
	<div id="div1">
		<h4>지역을 선택해주세요</h4>
		<input type="image" class="search1"  id="busan" src="https://via.placeholder.com/100x100.jpg?text=BUSAN" value="부산 ">
		<input type="image" class="search1"  id="andong" src="https://via.placeholder.com/100x100.jpg?text=ANDONG" value="안동 ">
	</div>
	
	<div id="div2">
		<h4>유형 선택해주세요</h4>
		<input type="image" class="search2" id="hotel" src="https://via.placeholder.com/100x100.jpg?text=HOTEL" value=" ">
		<input type="image" class="search2" id="tour" name="placeType" src="https://via.placeholder.com/100x100.jpg?text=TOUR " value=" ">
	</div>
	
	<!-- 지도 검색창  -->
	<div id="div3" style="width: 300px; heigth:300px;">
		<input type="text" id="keyword" required="required">
		<button id="find">검색</button>
	</div>
	
	
	<!-- 3-1. 검색한 장소를 선택하면 마커 표시(완료)
	
	 및 DB에 장소 - 통합계획표 - 하루계획표 - 하루순서 테이블에 등록  -->
	
	<!-- 3-2. 마커 표시한 장소를 삭제하면 하루계획표 - 장소 - (장소계획 : 자동삭제) 테이블에 삭제 -->
	
	<!-- #. 이 과정 반복 -->
	
	<div id="map" style="width:100%;height:350px;"></div>
</body>
</html>