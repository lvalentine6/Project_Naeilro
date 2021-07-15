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
<script>
	$(function(){
		
		// #. 통합계획표 출발일 : 현재날짜부터 선택
		var today = new Date();
		$("input[name=plannerStartDate]").attr("min", today);
		
		// #. 지역은 유동적으로 변경되므로 전역변수로 설정하여 활용
		var placeName; // 지명
		var placeType; // 유형
		var placeLatitude; // 위도
		var placeLongitude; // 경도
		
		
		// #. 장소 검색창 비활성화 (완료)
		$("#search").hide();
		
		// #. 장소 선택창 비활성화
		$("#daily-selected-place").hide();
		
		// #. 장소 세부사항 선택창 비활성화
		$("#dailyplan-select-confirm").hide();
		
		// #. 하루계획표 등록창 비활성화
		$("#daily-confirm").hide();
		
		
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
				
				// #. 선택한 장소 지명을 출력에 대입
			    $("input[name=place-select-name]").attr('value', placeName);
				
			}); 
			
		} // 콜백함수 : addMarker
		
		/* 07/13 해야 할 일 
		
			1. 체크박스 클릭 시, 체크박스 값을 기준으로 마커 재설정 구현하기 (완료)
			
			2. 지역 선택하기 전에는 검색창 & 체크박스가 표시되지 않다가 지역을 선택하면 세부 검색창이 나오게끔 구현하기
			
			3. PLACE 정보 출력 확인 후, JSON 형태로 AJAX 비동기 등록 처리 수행하기
		*/
		
		// #. 체크박스 하나만 하도록 조정
		function check(){
			
			// 검색창
			$(".type").click(function(){
				if($(this).prop('checked')){
					$('.type').prop('checked', false);
					$(this).prop('checked', true);
				}
			});
			
			//교통수단
			$(".transfer").click(function(){
				if($(this).prop('checked')){
					$(".transfer").prop('checked', false);
					$(this).prop('checked', true);
				}
			});
			
		}
		
		check(); // #. 전역 CB함수 : 항상 체크 중복 여부 확인
		
		$("#find").click(function(){
			// #. 장소 선택창 비활성화
			$("#daily-selected-place").hide();
			
			// #. 장소 세부사항 선택창 비활성화
			$("#dailyplan-select-confirm").hide();
			
			// #. 하루계획표 등록창 비활성화
			$("#daily-confirm").hide();
			
			// #. 체크박스 설정으로 유형 값 변경
			placeType = $('input[class=type]:checked').val();  
			
			// #. 선택한 장소 유형을 출력에 대입
			$('input[name=place-select-type]').attr('value', placeType); 
			
			if($('input[name=place-select-latitude]') != null || $('input[name=place-select-longitude]') != null || $("#place-select-name") != null){
				$('input[name=place-select-latitude]').attr('value', ""); 
				$('input[name=place-select-longitude]').attr('value', ""); 
				$("#place-select-name").attr('value', "");
			}
			
			var keyword = $("#keyword").val(); 
			
			// #. 마커 재설정 CB호출 - 매개변수 : 지명, 유형, 검색어
			setMapBounds(placeName, placeType, keyword); 
			
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
			        
			        // 장소 선택창 활성화
			        $("#daily-selected-place").show();
			        
				    $("input[name=place-select-latitude]").attr('value', marker.getPosition().getLat()); // 위도 좌표
				    $("input[name=place-select-longitude]").attr('value', marker.getPosition().getLng()); // 경도 좌표
				    $("input[name=place-select-type]").attr('value', placeType);
				    $("#place-select-name").attr('value', place.place_name);
				    
					 // 하루 계획표 등록 창 값 대입
					$("input[name=daily-confirm-placeName]").attr('value', placeName); // 값이 비어있는 걸 확인
				 	console.log($("input[name=daily-confirm-placeName]").val())
				 	
				    // 장소 순서 & 교통 수단 활성화
					$("#dailyplan-select-confirm").show();
				    
			    });
				
			} // 콜백함수 : 마커 표시(displayMarker)
			
		} // 콜백함수 : 마커 재설정(setMapBounds)
		
		/* 07/14  */
	
		// DB : 통합 계획표 등록 + 공유그룹 등록	
		$("#planner-insert-button").click(function(){
			
			// 비동기 처리 : 통합계획표 작성
			$.ajax({
				url:"${pageContext.request.contextPath}/plan/data/plannerInsert"	,
				type: "post",
				data: $("#planner-insert").serialize(), // + 공유그룹도 한 번에 다 넣기
				success: function(resp){
					if(resp === "Y"){
						
						/* 07/15 */
						// 작성이 확인되면 등록내용 고정 (변경 예정)
						$("input[name=plannerName]").attr("disabled", true);
						$("input[name=plannerStartDate]").attr("disabled", true);
						$("input[name=plannerEndDate]").attr("disabled", true);
						$("#planner-insert-button-div").hide();
						
						// 맵 활성화
						$("#map").css('pointer-events', 'auto');
						$("#map").css('opacity', '1.0');
						
						
						// 통합계획표 번호 비동기 출력 후 대입 (구현예정)
						
					}
				}	
			});
		});
		
		// 하루 계획 선택 버튼 클릭 시 
		$("#dailyplan-select-button").click(function(){
			
			// 하루계획표 등록창 활성화
			$("#daily-confirm").show();
			
		});
		
	}); // 제이쿼리
</script>
</head>
<body>
	<!-- 전체 컨테이너 -->
	<div id="container" style="width: 100%; height: 800px; overflow: hidden"> 
		<div style="width: 20%; height: 800px; border: 1px solid;float: left" id="confirm"> <!-- 사용자 컨테이너 -->
			<!-- 통합계획표 FORM -->
			<form id="planner-insert" autocomplete="off">
				<div id="planner-insert-confirm"> <!-- 통합계획표 테이블 입력값 -->
					<div style="font-weight:bold;">통합계획표</div>
					<div class="row">
						<label>계획표 이름</label>
						<input type="text" name="plannerName" required="required"> 
					</div>
					<div class="row">
						<label>출발일</label>
						<input type="date" name="plannerStartDate" required="required" > 
					</div>
					<div class="row">
						<label>도착예정일</label>
						<input type="date" name="plannerEndDate" required="required"> 
					</div>
				</div>
			</form>
			<!-- 통합계획표 FORM -->
			<div class="row" id="planner-insert-button-div">
				<button id="planner-insert-button">계획표 생성</button>
			</div>
			<!-- 검색창 -->
			<div id="search"> 
				<hr>
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
			<hr>
			<!-- 장소 선택창 -->
			<div id="daily-selected-place">
				<div style="font-weight:bold;">선택한 장소</div>
				<!-- 장소 FORM -->
				<form action="">
					<div class="row">
					<label>장소 위도</label>
					<input type="text" name="place-select-latitude" readonly>
					</div>
					<div class="row">
						<label>장소 경도</label>
						<input type="text" name="place-select-longitude" readonly>
					</div>
					<div class="row">
						<label>장소 지명</label>
						<input type="text" name="place-select-name" readonly>
					</div>
					<div class="row">
						<label>장소 유형</label>
						<input type="text" name="place-select-type" readonly>
					</div>
					<div class="row">
						<label>장소 이름</label>
						<input type="text" id="place-select-name" readonly>
					</div>
				</form>
				<!-- 장소 FORM -->
			</div>
			<!-- 장소 세부사항 선택창 -->
			<div id="dailyplan-select-confirm">
				<div class="row">
					<label>장소 순서</label>
					<input type="number" name="dailyplan-select-order" >
				</div>
				<div class="row">
					<label>교통 수단</label>
				</div>
				<div class="row">
					<input type="checkbox" name="dailyplan-select-transfer"  class="transfer" value="기차">
					<label>기차</label>
					<input type="checkbox" name="dailyplan-select-transfer" class="transfer"  value="자동차">
					<label>자동차</label>
				</div>
				<div class="row">
					<button id="dailyplan-select-button">하루 계획 선택</button>
				</div>
			</div>
			<!-- 장소 세부사항 선택창 -->
			<!-- 하루계획표 등록 창 (DB) -->
			<div id="daily-confirm">
				<hr>
				<div style="font-weight:bold;">선택한 계획장소</div>
				<div class="row">
					<label>통합계획 번호</label>
					<input type="number"  name="daily-confirm-plannerNo" disabled="disabled">
				</div>
				<div class="row">
					<label>선택 지역</label>
					<input type="number" name="daily-confirm-placeName" readonly="readonly">
				</div>
				<div class="row">
					<label>하루계획 순서</label>
					<input type="number" name="daily-confirm-order">
				</div>
				<div class="row">
						<label>숙박일수</label>
						<input type="number" name="daily-confirm-stayDate">
				</div>
				<div class="row">
					<button>하루계획 등록</button>
				</div>
				<hr>
			</div>
			<!-- 하루계획표 등록 창 (DB) -->
		</div> 
		<div id="map" style="width: 75%; height: 800px; float: right"></div>
	</div>
	<!-- 전체 컨테이너 -->
</body>
</html>