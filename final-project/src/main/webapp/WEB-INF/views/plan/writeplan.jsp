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
		
		// # : 지역은 유동적으로 변경되므로 전역변수로 설정하여 활용
		var placeName; // 지명
		var placeType; // 유형
		var placeLatitude; // 위도
		var placeLongitude; // 경도
		
		// #. 세부 검색창 & 등록 창 우선 미출력
		$("#search").hide();
		$("#placeInsert").hide();
		
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
	    mapOption = { 
	        center: new kakao.maps.LatLng(34.442373196846404, 128.10680344968128), // #. 지도의 중심좌표
	        level: 13 // #. 지도의 확대 레벨
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
		    
		    // #. 콜백함수
		    addMarker(marker);
		}		
		
		// #. 마커에 클릭이벤트를 등록합니다
		function addMarker(marker){
			
			// 지정할 마커를 생성해준다
			 var marker = new kakao.maps.Marker({
		        map: marker.getMap(), // 마커를 표시할 지도
		        position: marker.getPosition(), // 마커를 표시할 위치
		        title : marker.getTitle(), // 마커의 타이틀
		        image : marker.getImage() // 마커 이미지 
		    });
			
			// 지역 선택 시 실행되는 이벤트
			kakao.maps.event.addListener(marker, 'click', function(){
				
				// #. 최초 마커 재설정 함수 실행 후에는 지역을 고정시켜야 한다 ★
				placeName = marker.getTitle();
				placeType = "호텔"; // 유형 : 기본값
				
				// #.지역 CB함수 - 매개변수 : 지명 + 유형
				setMapBounds(placeName, placeType);
				
				
				// #. 지역 선택해야 세부 설정 나오게끔 표시
				$("#search").show();
			}); 
			
		} // 콜백함수 : addMarker
		
		/* 07/13 해야 할 일 
		
			1. 체크박스 클릭 시, 체크박스 값을 기준으로 마커 재설정 구현하기 (완료)
			
			2. 지역 선택하기 전에는 검색창 & 체크박스가 표시되지 않다가 지역을 선택하면 세부 검색창이 나오게끔 구현하기
			
			3. PLACE 정보 출력 확인 후, JSON 형태로 AJAX 비동기 등록 처리 수행하기
		*/
		
		// #. 체크박스 하나만 하도록 조정
		function check(){

			$(".type").click(function(){
				if($(this).prop('checked')){
					$('.type').prop('checked', false);
					$(this).prop('checked', true);
				}
			});
		}
		
		check(); // #. 전역 CB함수 : 항상 체크 중복 여부 확인
		
		$("#find").click(function(){
			
			$("#placeInsert").hide();
			
			placeType = $('input[class=type]:checked').val();  // #. 체크박스 설정으로 유형 값 변경
			
			$('input[name=placeType]').attr('value', placeType); 
			
			var keyword = $("#keyword").val(); // #. 검색어 값

			setMapBounds(placeName, placeType, keyword); // #. 마커 재설정 CB호출 - 매개변수 : 지명, 유형, 검색어
			
		});
		
		// 콜백함수에 매개변수 대입 : placeName + placeType + keyword
		function setMapBounds(placeName, placeType, keyword){
			
			// #. 이벤트 실행 전 매개변수 확인
			console.log(placeName);
			console.log(placeType);
			console.log(keyword);
			
			// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
			var infowindow = new kakao.maps.InfoWindow({zIndex:1});
			
			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng(marker.getPosition().getLat(), marker.getPosition().getLng()), // #. 지도의 중심좌표
		        level: 6 // 지도의 확대 레벨
		    };
			
			// 지도를 생성합니다    
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			
			// 장소 검색 객체를 생성합니다
			var ps = new kakao.maps.services.Places();
			
			// #. 키워드로 장소를 검색합니다 (최초 실행용 : empty String)
			var keyword = "";
			
			// #. 관광지에 체크박스 먼저 선택 후 지역 선택하면 알맞게 변경
			if($('input[class=type]:checked').val() == "관광지"){
				placeType = "관광지";
			}
			
			// #. 검색어가 비어있지 않으면 알맞게 세팅
			if($("#keyword") != ""){
				keyword = $("#keyword").val();
			}
			
			// ★ 검색키워드 : 선택 지역 + 검색 유형 + 키워드
			ps.keywordSearch(placeName + placeType + keyword, placesSearchCB);
			
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
			    	$("#placeInsert").show();
			        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			        infowindow.setContent(
			        		'<div style="padding:5px;font-size:12px;">' + 
			        			place.place_name + 
			        		'</div>');
			        infowindow.open(map, marker);
			        
				    $("input[name=placeLatitude]").attr('value', marker.getPosition().getLat()); // 위도 좌표
				    $("input[name=placeLongitude]").attr('value', marker.getPosition().getLng()); // 경도 좌표
				    $("input[name=placeName]").attr('value', placeName);
				    $("input[name=placeType]").attr('value', placeType);
				    
				    console.log($("input[name=placeLatitude]").val());
				    console.log($("input[name=placeLongitude]").val());
				    console.log(placeName);
				    console.log(placeType);

			    });
				
			} // 콜백함수 : 마커 표시(displayMarker)
			
		} // 콜백함수 : 마커 재설정(setMapBounds)
			
		/*************************/
		
		/* 비동기 실행 파트 */
		
		// 1. 장소 등록
		
		// #. 장소 등록 : AJAX 구문
		function placeInsert(){
			
			// AJAX : 장소 등록 - 비동기 요청 코드 작성
			$.ajax({
				url: "${pageContext.request.contextPath}/data/plan/placeInsert",
				type: "post",
			});
			
		}
		
		function plannerInsert(){
			
			// AJAX : 계획표 등록 - 비동기 요청 코드 작성
			
		}
		
	}); // 제이쿼리
</script>
</head>
<body>
	<div id="container" style="width: 100%; height: 800px; overflow: hidden">
		<div style="width: 20%; height: 800px; border: 1px solid;float: left" id="search">
			<input type="checkbox" class="type" id="hotel" value="호텔"><label>호텔</label>
			<input type="checkbox" class="type" id="tour" value="관광지"><label>관광지</label>
			<input type="text" id="keyword" required="required">
			<button id="find">검색</button>
			<div>
				<form id="placeInsert" style="border: 0.5px;">
					<hr>
					<label>장소 등록 비동기 데이터</label><br><br>
					<label>숙박일자</label><br><br>
					<input type="date" id="startDate" name="plannerStartDate"><br><br>
					<label>종료일자</label><br><br>
					<input type="date" id="endDate" name="plannerEndDate"><br><br>
					<input type="text" class="type" name="placeType"readonly>
					<input type="text" class="name" name="placeName" readonly>
					<input type="text" class="Latitude"  name="placeLatitude" readonly>
					<input type="text" class="Loingitude"  name="placeLongitude" readonly>
					<button>등록</button>
				</form>
			</div>
			<div>
				<hr>
				<label>장소 등록 출력</label>
			</div>
		</div>
		<div id="map" style="width: 75%; height: 800px; float: right"></div>
	</div>
</body>
</html>