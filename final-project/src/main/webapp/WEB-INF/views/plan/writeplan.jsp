<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>플래너</title>
<style>
	/* 맵 비활성화 - 등록하면 활성화 용도 */
	#map{
		opacity: 0.6;
		pointer-events: none;
	}
</style>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60b30d68f4da16b4a316665d189e702f&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
<script>
	$(function(){
		
		/* 전역변수 : 등록 시 필요한 정보 */
		
		// 통합계획표 테이블
		var plannerName;
		
		// 하루계획표 테이블 
		var plannerNo; 
		var dailyStayDate;
		var dailyOrder;
		
		// 장소 테이블
		var placeName; 
		var placeType; 
		var placeLatitude; 
		var placeLongitude; 
		
		// 장소계획 테이블
		var dailyplanPlaceOrder;
		var dailyplanTransfer
		
		/* 비활성화 */
		$("#search").hide();
		$("#daily-title").hide();
		
		$("#plan-insert-container").hide();
		
		/* 체크박스 중복 불가 */
		function check(){
			// 검색창
			$(".type").click(function(){
				if($(this).prop('checked')){
					$('.type').prop('checked', false);
					$(this).prop('checked', true);
				}
			});
		}
		
		check(); 
		
		/* 통합계획표 */
		// DB 전송 데이터 준비 : 통합계획표 - 이름 설정
		$("#planner-name").on("input", function(){
			plannerName = $("#planner-name").val();
			$("input[name=plannerName]").attr("value", plannerName);
		});
		
		$("#planner-map-find").click(function(){
			// 맵 비활성화 및 초기화
			$("#map").css('pointer-events', 'none');
			$("#map").css('opacity', '0.6');
			createMap();
			
			// 제어
			$(".list-daily").remove();
			
			if($("input[name=plannerName]").val() == "" || $("input[name=plannerStartDate]").val() == "" || $("input[name=plannerEndDate]") == ""){
				alert("계획표를 제대로 입력해주세요!");
				return;
			}
			
			// 데이터 입력값 설정 완료 시
			
			// + 숙박일수 설정 및 하루계획표 템플릿 생성
			dailyStayDate  = ((new Date($("input[name=plannerEndDate]").val()).getTime() - new Date($("input[name=plannerStartDate]").val()).getTime()) / 1000 / 60 / 60 / 24);
			$("input[name=dailyStayDate]").attr("value", dailyStayDate);
			dailyTemplate(dailyStayDate);
			
			$("#planner-map-find").hide();
			$("#planner-insert-button").attr("type", "submit");
		});
		
		//날짜 선택
		$('#demo').daterangepicker({ 
			"locale": { 
				"format": "YYYY-MM-DD", 
				"separator": " ~ ", 
				"applyLabel": "확인", 
				"cancelLabel": "취소", 
				"fromLabel": "From", 
				"toLabel": "To", 
				"customRangeLabel": "Custom", 
				"weekLabel": "W", 
				"daysOfWeek": ["월", "화", "수", "목", "금", "토", "일"], 
				"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"], 
				"firstDay": 1 
				}, 
				"minDate": new Date(),
				"startDate": new Date(), 
				"endDate": new Date(), 
				"drops": "auto" }, function (start, end, label) { 
					console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')'); 
				
				// DB 전송 데이터 준비 : 통합계획표 - 날짜 설정
				$("input[name=plannerStartDate]").attr('value', start.format('YYYY-MM-DD'));
				$("input[name=plannerEndDate]").attr('value', end.format('YYYY-MM-DD'));
		});
		/* 통합계획표 */
		
		/* 하루계획표 */
		function dailyTemplate(dailyStayDate){
			
			for(var i=0; i < dailyStayDate; i++){
				var template = $("#user-daily-template").html();
				template = template.replace("{dailyOrder}", i+1);
				template = template.replace("{index}", i+1);
				$("#daily-list-container").append(template);
			}
			
			$(".list-open-place-select-button").click(function(){
				//this == 버튼
				var index = $(this).parents(".list-daily").data("index");
				console.log("index = " + index);
				
				// DB 전송 데이터 준비 : 하루계획표 - 순서 설정
				$("input[name=dailyOrder]").attr("value", index);
				
				//+ 맵 활성화
				$("#map").css('pointer-events', 'auto');
				$("#map").css('opacity', '1.0');
				
				// + 제어: 버튼 클릭 시 지도 초기화
				createMap(index);
			});
			
		}
		/* 하루계획표 */
		
		//지도 초기화
		function createMap(index){
			$("#search").hide();
			
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
			    
			    addMarker(marker, index);
			}		
		}
		
		/* 지도 생성(초기) */
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
		    
		    addMarker(marker);
		}		
		
		/* 마커 제어 함수 : 하루계획 순서 */
		function addMarker(marker, index){
			
			// 지정할 마커를 생성해준다
			 var marker = new kakao.maps.Marker({
		        map: marker.getMap(), // 마커를 표시할 지도
		        position: marker.getPosition(), // 마커를 표시할 위치
		        title : marker.getTitle(), // 마커의 타이틀
		        image : marker.getImage() // 마커 이미지 
		    });
			
			// 지역 선택 시 실행되는 이벤트
			kakao.maps.event.addListener(marker, 'click', function(){
				
				// #. 최초 마커 재설정 함수 실행 후에는 지역을 고정시켜야 한다 
				placeName = marker.getTitle();
				placeType = "호텔"; // 유형 : 기본값
				
				// DB 전송 데이터 준비 : 장소 - 지명 설정
				$("input[name=placeName]").attr("value", placeName);
				// DB 전송 데이터 준비 : 장소 - 유형 설정
				$("input[name=placeType]").attr("value", placeType);
				
				// 지역 설정
				var dailyIndex = index-1;
				console.log("dailyIndex= " + dailyIndex);
				$(".list-daily").eq(dailyIndex).children(".list-daily-placeName").children("#daily-placeName").attr("value", placeName);
				
				// #.지역 CB함수 - 매개변수 : 지명 + 유형
				setMapBounds(placeName, placeType);
				
				// #. 지역 선택해야 검색창 나오게끔 표시
				$("#search").show();
			});
		} 
		
		/* 장소 검색 기능 */
		function find(){
			$("#find").click(function(){
				// #. 체크박스 설정으로 유형 값 변경
				placeType = $('input[class=type]:checked').val();  
				
				// #. 선택한 장소 유형을 출력에 대입
				$('input[name=placeType]').attr('value', placeType); 
				
				var keyword = $("#keyword").val(); 
				
				// #. 마커 재설정 CB호출 - 매개변수 : 지명, 유형, 검색어
				setMapBounds(placeName, placeType, keyword); 
			});
		}
		find();
		
		/* 지도 재설정 함수 */
		function setMapBounds(placeName, placeType, keyword){
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
			
			// #. 키워드로 장소를 검색 (최초 실행용 : empty String)
			var keyword = "";
			
			// #. 관광지에 체크박스 먼저 선택 후 지역 선택하면 알맞게 변경
			if($('input[class=type]:checked').val() == "관광지"){
				placeType = "관광지";
			}
			
			// #. 검색어가 비어있지 않으면 알맞게 세팅
			if($("#keyword") != ""){
				keyword = $("#keyword").val();
			}
			
			// #. 검색키워드 : 선택 지역 + 검색 유형 + 키워드
			ps.keywordSearch(placeName + placeType + keyword, placesSearchCB);
			
			/* 좌표 재설정 함수 */
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
			
			/* 장소 마커 표시 함수 */
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
			        		'</div>');
			        infowindow.open(map, marker);
			        
			     	// DB 전송 데이터 준비 : 장소 - 위도 설정
			        $("input[name=placeLatitude]").attr("value", place.y);
			     	// DB 전송 데이터 준비 : 장소 - 경도 설정
			        $("input[name=placeLongitude]").attr("value", place.x);
			       
			        // 장소계획
			        // 1. 템플릿을  생성한다
			        // 2. 사용자에게 장소에 대한 순서, 교통수단을 설정하게 한다
			        // 3. 설정한 값을 전송값에 설정시킨다
			        
			        var dailyIndex = $("input[name=dailyOrder]").val()-1; 
			        // N번째 하루계획표 중 마지막 자식 번호의 인덱스
			        var dailyplanIndex = $(".list-daily").eq(dailyIndex).children(":last").data("index");
			        var template = $("#user-place-dailyplan-template").html();
			        // 인덱스 등록
			        if(dailyplanIndex == null){
			        	template= template.replace("{index}", 1);
			        } else {
			        	template= template.replace("{index}", dailyplanIndex+1);
			        }
					template = template.replace("{placeName}", place.place_name);
			        // 하루계획표 인덱스 기준으로 생성
			        $(".list-daily").eq(dailyIndex).append(template);
			    });
			}
			
		} 
		
		/* 비동기 처리 영역 */
		
		/* 비동기 처리 영역 */
		
	}); // 제이쿼리
</script>
<script type="text/template" id="user-daily-template">
	<!-- 사용자용 : 하루계획표 리스트 -->
	<div class="list-daily" style="border-bottom: 1px solid" data-index="{index}">
		<div class="list-daily-order">
			<label>{dailyOrder} 일차 하루계획표</label>
		</div>
		<div class="list-daily-placeName">
			<label>지역</label>
			<input type="text" readonly id="daily-placeName">
		</div>
		<div class="list-open-place-select-button">
			<button>지역 선택</button>
		</div>
	</div>
	<!-- 사용자용 : 하루계획표 리스트 -->
</script>
<script type="text/template" id="user-place-dailyplan-template">
	<!-- 사용자용 : 장소계획 리스트 -->
	<div class="list-dailyplan" style="border-top: 1px solid" data-index="{index}"> <!-- 장소 순서 -->
		<div class="list-dailyplan-placeName">
			<label>{placeName}</label>
		</div>
		<div class="list-dailyplan-transfer">
			<label>교통수단</label>
			<select id="transfer">
				<option value="항공">항공</option>
				<option value="기차">기차</option>
				<option value="자동차" selected>자동차</option>
			</select>
		</div>
	</div>
	<!-- 사용자용 : 장소계획 리스트 -->
</script>
</head>
<body>
	<!-- 전체 컨테이너 -->
	<div id="container" style="width: 100%; height: 800px; overflow: hidden"> 
		<!-- 확인 컨테이너 -->
		<div style="width: 20%; height: 800px; border: 1px solid;float: left" id="confirm">
			<!-- 사용자 컨테이너 -->
			<div id="user-container">
				<!-- 통합계획표 입력창 -->
				<div id="planner-insert-confirm" style="border-bottom: 1px solid;">
					<div style="font-weight:bold;">통합계획표</div>
					<div class="row">
						<label>계획표 이름</label>
						<input type="text" id="planner-name"> 
					</div>
					<div class="row">
						<label>날짜선택</label>
						<input type="text" id="demo">
					</div>
					<br>
					<div class="row" id="planner-insert-button-div">
						<button id="planner-map-find">계획표 생성</button>
						<input type="hidden" id="planner-insert-button" value="계획표 생성완료">
					</div>
					<br>
				</div>
				<!-- 통합계획표 입력창 -->
				<!-- 검색창 -->
				<div id="search" style="border-bottom: 1px solid"> 
					<div style="font-weight:bold;">장소 검색창</div>
					<div class="row">
						<label>검색 유형 : </label>
						<input type="checkbox" class="type" id="hotel" value="호텔">
						<label>호텔</label>
						<input type="checkbox" class="type" id="tour" value="관광지">
						<label>관광지</label>
					</div>
					<div class="row">
						<label>검색어</label>
						<input type="text" id="keyword" required="required">
					</div>
					<div class="row">
						<button id="find">검색</button>
					</div>
				</div>
				<!-- 검색창 -->
				<!-- 하루계획표 -->
				<div id="daily-list-container"></div>
				<!-- 하루계획표 -->
				<!-- 하루계획표 입력창 -->
				<div id="daily-insert-confirm"></div>
				<!-- 하루계획표 입력창 -->
				<!-- 장소계획 입력창 -->
				<div id="dailyplan-insert-confirm"></div>
				<!-- 장소계획 입력창 -->
			</div>
			<!-- 사용자 컨테이너 -->
			<!-- 개발자 컨테이너 -->
			<div id="plan-insert-container" style="border-bottom: 1px solid; bottom-top: 1px solid">
				<label style="font-weight:bold;"> FORM 데이터 전송값 </label>
				<form id="plan-insert-form">
					<!-- 통합계획표 데이터 -->
					<div class="planner-insert-confirm">
						<div class="planner-insert-row">
							<label>통합계획표 이름</label>
							<input type="text" name="plannerName" required readonly>
						</div>
						<div class="planner-insert-row">
							<label>통합계획표 출발일</label>
							<input type="text" name="plannerStartDate" required readonly>
						</div>
						<div class="planner-insert-row">
							<label>통합계획표 도착일</label>
							<input type="text" name="plannerEndDate" required readonly>
						</div>
					</div>
					<!-- 통합계획표 데이터 -->
					<!-- 하루계획표 데이터 -->
					<div class="daily-insert-row">
						<label>숙박일수</label>
						<input type="text" name="dailyStayDate"  required readonly>
					</div>
					<div class="daily-insert-row">
						<label>하루계획 순서</label>
						<input type="text" name="dailyOrder" required readonly>
					</div>
					<!-- 하루계획표 데이터 -->
					<!-- 장소 데이터 -->
					<div class="place-insert-row">
						<label>장소 위도</label>
						<input type="text" name="placeLatitude" required readonly>
					</div>
					<div class="place-insert-row">
						<label>장소 경도</label>
						<input type="text" name="placeLongitude" required readonly>
					</div>
					<div class="place-insert-row">
						<label>장소 지명</label>
						<input type="text" name="placeName" required readonly>
					</div>
					<div class="place-insert-row">
						<label>장소 유형</label>
						<input type="text" name="placeType" required readonly>
					</div>
					<!-- 장소 데이터 -->
					<!-- 장소계획 데이터 -->
					<div class="dailyplan-insert-row">
						<label>장소 순서</label>
						<input type="text" name="dailyplanPlaceOrder" required readonly>
					</div>
					<div class="dailyplan-insert-row">
						<label>장소 교통수단</label>
						<input type="text" name="dailyplanTransfer" required readonly>
					</div>
					<!-- 장소계획 데이터 -->
				</form>
				<br>
			</div>
			<!-- 개발자 컨테이너 -->
		</div>
		<!-- 확인 컨테이너 -->
		<!-- 지도 -->
		<div id="map" style="width: 75%; height: 800px; float: right"></div>
		<!-- 지도 -->
	</div>
	<!-- 전체 컨테이너 -->
</body>
</html>