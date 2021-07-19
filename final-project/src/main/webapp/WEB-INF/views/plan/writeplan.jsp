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
		
		/* 날짜 선택 */
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
					
				$("input[name=plannerStartDate]").attr('value', start.format('YYYY-MM-DD'));
				$("input[name=plannerEndDate]").attr('value', end.format('YYYY-MM-DD'));
		});
		
		/* 전역변수 : 등록 시 필요한 정보 */
		
		// 장소 테이블
		var placeName; 
		var placeType; 
		var placeLatitude; 
		var placeLongitude; 
		
		// 하루계획표 테이블 
		var plannerNo; 
		var dailyStayDate;
		var dailyOrder;
		
		// 장소계획 테이블
		var dailyplanPlaceOrder;
		var dailyplanTransfer
		
		/* 비활성화 */
		$("#search").hide();
		$("#plan-insert-confirm").hide();
		
		/* 지도 생성 */
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
		
		/* 마커 제어 함수 */
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
				
				// #. 지역 선택해야 검색창 나오게끔 표시
				$("#search").show();
				
				// #. 선택 지역 입력 FORM에 등록
				$("input[name=placeName]").attr("value", placeName);
				$("input[name=placeType]").attr("value", placeType);
			});
		} 
		
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
			        
			        /* **등록 기능 수행 시점** */
			        
			        // 등록 값 세팅 
		        	console.log("등록 전 세팅 및 확인");
			        
			        $("input[name=placeLatitude]").attr("value", marker.getPosition().getLat());
			        $("input[name=placeLongitude]").attr("value", marker.getPosition().getLng());
		        	
		        	console.log("숙박 예정일은 " + $("input[name=dailyStayDate]").val() + "일 입니다");
		        	
		        	$("input[name=dailyOrder]").attr("value", 1); // 최초등록 : 처음 계획표를 작성할 경우 (하루 계획을 변경 시 숙박일수, 하루계획 순서 수정창을 통해 수정기능 구현 예정)
		        	console.log("현재 계획하고 있는 하루계획표는 " + $("input[name=dailyOrder]").val() + "일차 입니다");
		        	
		        	if($("input[name=dailyplanPlaceOrder]").val() >= 1){ // 등록 완료된 장소 순서가 설정되어 있는 경우...
		        		var placeNewOrder = parseInt($("input[name=dailyplanPlaceOrder]").val())+1;
				        $("input[name=dailyplanPlaceOrder]").attr("value", placeNewOrder); // (순서가 중복되지 않도록) 기존 순서의 다음 번호로 값을 변경한다
		        	} else {
		        		$("input[name=dailyplanPlaceOrder]").attr("value", 1); // 최초 등록일 경우 장소 순서를 1로 고정
		        	}
		        	console.log("등록할 장소 순서 : "+$("input[name=dailyplanPlaceOrder]").val());
			        
			        $("input[name=dailyplanTransfer]").attr("value", "자동차"); // 최초등록 : 처음 계획표를 작성할 경우 (리스트 조회를 통한 출력 창에서 체크박스 형태로 수정기능 구현 예정)
			        console.log("등록할 장소로 이동할 교통 수단은 " +  $("input[name=dailyplanTransfer]").val() + " 입니다");
			     	// 등록 값 세팅 
			     	
     				console.log("등록 실행");
		        	
			        // 비동기 처리 : 등록 기능 (구현완료)
		        	planInsertService();
			    });
			} 
		} 
		
		/* 비동기 처리 영역 */
		
		// DB : 통합 계획표 등록 & 공유그룹 등록 (완료)
		$("#planner-insert-button").click(function(){
			// 비동기 처리 : 통합계획표 작성
			$.ajax({
				url:"${pageContext.request.contextPath}/plan/data/plannerInsert"	,
				type: "post",
				data: $("#planner-insert").serialize(), // + 공유그룹도 한 번에 다 넣기
				success: function(resp){
						/* 함수 매개변수용 */
						plannerNo = resp;
						dailyStayDate  = ((new Date($("input[name=plannerEndDate]").val()).getTime() - new Date($("input[name=plannerStartDate]").val()).getTime()) / 1000 / 60 / 60 / 24);
						
						$("input[name=plannerNo]").attr("value", plannerNo);
						$("input[name=dailyStayDate]").attr("value", dailyStayDate);
						/* 함수 매개변수용 */
						
						// 작성이 확인되면 등록내용 고정 (변경 예정)
						$("input[name=plannerName]").attr("disabled", true);
						$("#demo").attr("disabled", true);
						$("#planner-insert-button-div").hide();
						
						// 맵 활성화
						$("#map").css('pointer-events', 'auto');
						$("#map").css('opacity', '1.0');
				}	
			});
		});
		
		// DB : 장소 & 하루계획 & 장소계획 등록 (완료)
		function planInsertService(){
			$.ajax({
				url:"${pageContext.request.contextPath}/plan/data/planInsertService",
				type:"post",
				data:$("#plan-insert-form").serialize(),
				success:function(){
					console.log("등록 완료");
					console.log("");
					
					/*등록 성공 시 출력 내용 */
					if($(".list-daily").length == 0){
						dailyListService(); // 하루계획표 N일차 출력
					}
				},
				error:function(){
					console.log("등록 실패");
				}
			});
		};
		
		// DB : 등록 정보 리스트 출력 :  하루계획표
		function dailyListService(){
			$.ajax({
				url:"${pageContext.request.contextPath}/plan/data/dailyListService",
				type:"get",
				dataType:"json",
				data:  {
					plannerNo: $("input[name=plannerNo]").val()
				},
				success:function(resp){
					for(var i=0; i < resp.length; i++){
						var template = $("#list-daily-template").html();
						template = template.replace("{{dailyOrder}}", resp[i].dailyOrder);
						$("#daily-list-confirm").append(template);
					}
					console.log("출력 완료");
				},
				error:function(){
					console.log("출력 실패");
				}
			});
		}
		/* 비동기 처리 영역 */
		
	}); // 제이쿼리
</script>
<script type="text/template" id="list-place-template">
	<!-- 선택 장소 출력 리스트 -->
	<div class="list-place">
		<div class="row-list-place">
			교통 수단 : {{transfer}}
		</div>
		<div class="row-list-place">
			장소 이름 : {{placeName}}
		</div>
		<div class="row-list-place">
			숙박 일수 : {{stayDate}}
		</div>
		<div class="row-list-place">
			장소 순서 : {{placeOrder}}
		</div>
	</div>
	<!-- 선택 장소 출력 리스트 -->
</script>
<script type="text/template" id="list-daily-template">
	<!-- 테스트용 : 하루계획표 리스트 -->
	<div class="list-daily" style="border-bottom: 1px solid">
		<div class="row-list-daily">
			{{dailyOrder}} 일차 계획 계획표
		</div>
		<div class="row-list-daily">
			<button id="list-dailyplan-template">▼</button>
		</div>
	</div>
	<!-- 테스트용 : 하루계획표 리스트 -->
</script>
</head>
<body>
	<!-- 전체 컨테이너 -->
	<div id="container" style="width: 100%; height: 800px; overflow: hidden"> 
		<!-- 사용자 컨테이너 -->
		<div style="width: 20%; height: 800px; border: 1px solid;float: left" id="confirm"> 
			<!-- 통합계획표 입력창 -->
			<div id="planner-insert-confirm" style="border-bottom: 1px solid;">
				<!-- 통합계획표 FORM -->
				<form id="planner-insert" autocomplete="off">
					<div style="font-weight:bold;">통합계획표</div>
					<div class="row">
						<label>계획표 이름</label>
						<input type="text" name="plannerName" required="required"> 
					</div>
					<div class="row">
						<label>날짜선택</label>
						<input type="text" id="demo">
					</div>
					<br>
					<input type="hidden" name="plannerStartDate"  required="required">
					<input type="hidden" name="plannerEndDate" required="required"> 
				</form>
				<!-- 통합계획표 FORM -->
				<div class="row" id="planner-insert-button-div">
					<button id="planner-insert-button">계획표 생성</button>
				</div>
				<br>
			</div>
			<!-- 통합계획표 입력창 -->
			<!-- 검색창 -->
			<div id="search" style="border-bottom: 1px solid"> 
				<div style="font-weight:bold;">장소 검색창</div><br>
				<div class="row">
					<label>검색 유형 : </label><br><br>
					<input type="checkbox" class="type" id="hotel" value="호텔">
					<label>호텔</label>
					<input type="checkbox" class="type" id="tour" value="관광지">
					<label>관광지</label>
				</div>
				<br>
				<div class="row">
					<label>검색어</label>
					<input type="text" id="keyword" required="required">
				</div>
				<br>
				<div class="row">
					<button id="find">검색</button>
				</div>
				<br>
			</div>
			<!-- 검색창 -->
			<!-- 출력 창 : 하루 계획표 기준 장소 등록내용 출력 -->
			<div id="daily-list-confirm" style="border-bottom: 1px solid">
				<h3>하루계획표</h3>
			</div>
			<!-- 출력 창 : 하루 계획표 기준 장소 등록내용 출력 -->
			<!-- 등록 완료 : 지역 출력창 -->
			<div id="place-name-confirm"></div>
			<!-- 등록 완료 : 지역 출력창 -->
			<!-- 개발자 컨테이너 : 등록 -->
			<div id="plan-insert-confirm">
				<!-- 계획 등록 FORM -->
				<form id="plan-insert-form">
					<div><h4>개발영역 : 계획등록 전송</h4></div>				
					<!-- 하루 계획표 -->
					<input type="text" name="plannerNo" required readonly placeholder="통합계획표 번호">
					<input type="text" name="dailyStayDate" required readonly placeholder="숙박일수">
					<input type="text" name="dailyOrder" required readonly placeholder="하루계획표 순서">
					<!-- 하루 계획표 -->
					<!-- 장소계획 -->
					<input type="text" name="dailyplanPlaceOrder" required readonly placeholder="장소 순서">
					<input type="text" name="dailyplanTransfer" required readonly placeholder="교통수단">
					<!-- 장소계획 -->
					<!-- 장소 -->
					<input type="text" name="placeLatitude" required readonly placeholder="장소 위도">
					<input type="text" name="placeLongitude" required readonly placeholder="장소 경도">
					<input type="text" name="placeName" required readonly placeholder="장소 지역">
					<input type="text" name="placeType" required readonly placeholder="장소 유형">
					<!-- 장소 -->
				</form>
				<!-- 계획 등록 FORM -->
			</div>
			<!-- 개발자 컨테이너 : 등록 -->
		</div> 
		<!-- 사용자 컨테이너 -->
		<div id="map" style="width: 75%; height: 800px; float: right"></div>
	</div>
	<!-- 전체 컨테이너 -->
</body>
</html>