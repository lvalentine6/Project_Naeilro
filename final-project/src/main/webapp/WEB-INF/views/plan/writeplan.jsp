<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플래너</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60b30d68f4da16b4a316665d189e702f&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
	$(function(){
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(34.442373196846404, 128.10680344968128), // 지도의 중심좌표
	        level: 13 // 지도의 확대 레벨
	    };

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	 
		// 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [
		    {
		        title: '제주도', 
		        latlng: new kakao.maps.LatLng(33.511111, 126.492778)
		    },
		    {
		        title: '부산', 
		        latlng: new kakao.maps.LatLng(35.114992, 129.042089)
		    }
		];
	
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
		    
		 	// 배열 확인 가능
		    // console.log(positions[i]);
		    // console.log(marker); 
		    
		    // 콜백함수
		    addMarker(marker);
		}		
		
		// 마커에 클릭이벤트를 등록합니다
		function addMarker(marker){
			
			// 지정할 마커를 생성해준다
			 var marker = new kakao.maps.Marker({
		        map: marker.getMap(), // 마커를 표시할 지도
		        position: marker.getPosition(), // 마커를 표시할 위치
		        title : marker.getTitle(), // 마커의 타이틀
		        image : marker.getImage() // 마커 이미지 
		    });
			
			kakao.maps.event.addListener(marker, 'click', function(){
				// 마커 확인 가능
				console.log(marker);
				
				// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
				var infowindow = new kakao.maps.InfoWindow({zIndex:1});
				
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
			    mapOption = {
			        center: new kakao.maps.LatLng(marker.getPosition().getLat(), marker.getPosition().getLng()), // 지도의 중심좌표
			        level: 6 // 지도의 확대 레벨
			    };
				
				// 지도를 생성합니다    
				var map = new kakao.maps.Map(mapContainer, mapOption); 
				
				// 장소 검색 객체를 생성합니다
				var ps = new kakao.maps.services.Places();
				
				// 키워드로 장소를 검색합니다 (타이틀 + 기본 값 : 키워드)
				var placeName = "호텔";
				
				if($('input[type="checkbox"]').prop('checked')){
					placeName = $('input[type="checkbox"]').prop('checked').val();
				}
				
				ps.keywordSearch(marker.getTitle() + placeName, placesSearchCB);
				
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
				    kakao.maps.event.addListener(marker, 'click', function(){
				        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
				        infowindow.setContent(
				        		'<div style="padding:5px;font-size:12px;">' + 
				        			place.place_name + 
				        			'<button id="get">선택</button>' +
				        		'</div>');
				        infowindow.open(map, marker);
				    });
				} // 콜백함수 : displayMarker
				
			}); // 콜백함수 : addListener
			
		} // 콜백함수 : addMarker
		
		/* 07/13 해야 할 일 
		
			1. 체크박스 클릭 시, 체크박스 값을 기준으로 마커 재설정 구현하기
			
			2. 지역 선택하기 전에는 검색창 & 체크박스가 표시되지 않다가 지역을 선택하면 세부 검색창이 나오게끔 구현하기
			
			3. PLACE 정보 출력 확인 후, JSON 형태로 AJAX 비동기 등록 처리 수행하기
			
		*/
		
		
	}); // 제이쿼리
</script>
</head>
<body>
	<div id="container" style="width: 100%; height: 800px; overflow: hidden">
		<div style="width: 20%; height: 800px; border: 1px solid;float: left">
			<input type="checkbox" name="placeType" id="hotel" value="호텔"><label>호텔</label>
			<input type="checkbox" name="placeType" id="tour" value="관광지"><label>관광지</label>
			<input type="text" id="keyword" required="required">
			<button id="find">검색</button>
		</div>
		<div id="map" style="width: 75%; height: 800px; float: right"></div>
	</div>
</body>
</html>