<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
	/* 맵 비활성화 - 등록하면 활성화 용도 */
	#map{
		height: 800px;
		opacity: 0.6;
		pointer-events: none;
	}
	.list-daily {
		border: 1px solid;
		margin-top: 10px;
	}
	#search {
		border: 1px solid;
		margin-top: 10px;
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
		
		// 날짜 
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
					
					var startDate = start.format('YYYY-MM-DD');
					var endDate = end.format('YYYY-MM-DD');
					
					var isEmpty = $("#plan-insert-container").is(':empty');
					
					// 이벤트 : 템플릿 생성
					$("#planner-map-find").click(function(){
						plannerTemplate(startDate, endDate);
					});
					
					// 이벤트 : 템플릿 제어
					if(!isEmpty){
						$("#plan-insert-container").empty();
						plannerTemplate(startDate, endDate);
					}
					
			});
			
		/* 통합계획표 */
		function plannerTemplate(startDate, endDate){
			$("#plan-insert-container").empty();
			
			// 맵 비활성화 및 초기화
			$("#map").css('pointer-events', 'none');
			$("#map").css('opacity', '0.6');
			createMap();
			
			// 서버 : 템플릿 생성
			var plannerTemplate = $("#planner-insert-template").html();
			$("#plan-insert-container").append(plannerTemplate);
			
			// 제목
			plannerName = $("#planner-name").val();
			$("input[name=plannerName]").attr("value", plannerName);
			$("input[name=plannerStartDate]").attr('value', startDate);
			$("input[name=plannerEndDate]").attr('value', endDate);
			
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
			
		}
		/* 통합계획표 */
		
		/* 하루계획표 */
		function dailyTemplate(dailyStayDate){
			
			for(var i=0; i < dailyStayDate; i++){
				var template = $("#user-daily-template").html();
				template = template.replace("{dailyOrder}", i+1);
				template = template.replace("{index}", i+1);
				$("#daily-list-container").append(template);
				
				// 데이터 전송 FORM
				var dailyTemplate = $("#daily-insert-template").html();
				dailyTemplate = dailyTemplate.replace("{dailyOrder}", i+1);
				dailyTemplate = dailyTemplate.replace("{dailyStayDate}", dailyStayDate);
				dailyTemplate = dailyTemplate.replace("{dailyList-index-stayDate}", i);
				dailyTemplate = dailyTemplate.replace("{dailyList-index-order}", i);
				dailyTemplate = dailyTemplate.replace("{dailyList-index-data}", i);
				$("#plan-insert-container").append(dailyTemplate);
			}
			
			// '지역 선택' 버튼 이벤트
			$(".list-open-place-select-button").click(function(){
				// 초기화
				$(".type").prop("checked", false);
				
				var dailyIndex = $(this).parents(".list-daily").data("index");
				
				// DB 전송 데이터 준비 : 하루계획표 - 순서 설정
				// $("input[name=dailyOrder]").attr("value", index);
				
				$("#map").css('pointer-events', 'auto');
				$("#map").css('opacity', '1.0');
				
				// + 제어: 버튼 클릭 시 지도 초기화
				createMap(dailyIndex);
			});
			
		}
		/* 하루계획표 */
		
		//지도 초기화 (여기다 좌표 입력 1번째)
		function createMap(dailyIndex){
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
			    
			    addMarker(marker, dailyIndex);
			}		
		}
		
		/* 지도 생성(초기) : 2번째 입력 */
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
		function addMarker(marker, dailyIndex){
			
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
				
				// 지역 설정
				var divIndex = dailyIndex-1;
				$(".list-daily").eq(divIndex).children(".list-daily-placeName").children(".daily-placeName").attr("value", placeName);
				// 하루계획 번호
				$("#daily-index").val(dailyIndex);
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
			if($('.type').val() == "관광지"){
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
			            displayMarker(data[i], placeType, placeName);    
			            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			        }       

			        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			        map.setBounds(bounds);
			    } 
			}
			
			/* 장소 마커 표시 함수 */
			function displayMarker(place, placeType, placeName) {
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
			        
			        /* 뷰 */
			        var dailyIndex = $('#daily-index').val(); // 하루계획표 인덱스 선택자
					var placeIndex = $(".list-daily").eq(dailyIndex-1).find(".list-dailyplan").last().data("index"); // 장소 선택자
					
					if(placeIndex == null) {
						placeIndex = 0;
					}
					
					var userTemplate = $("#user-place-dailyplan-template").html();
					if(placeIndex == null) {
						userTemplate = userTemplate.replace("{index}", 1);
					} else {
						userTemplate = userTemplate.replace("{index}", placeIndex+1);
					}
					userTemplate = userTemplate.replace("{place-name}", place.place_name);
					userTemplate = userTemplate.replace("{data-latitude}", place.y);
					userTemplate = userTemplate.replace("{data-longitude}", place.x);
					userTemplate = userTemplate.replace("{data-name}", placeName);
					userTemplate = userTemplate.replace("{data-type}", placeType);
					
					$(".list-daily").eq(dailyIndex-1).append(userTemplate);
					
					/* 경로(선) */
					// 전역 변수(선 관련)
					var linePath = []; 
					var polyline = new kakao.maps.Polyline({ 
					    path: linePath, // 선을 구성하는 좌표배열 입니다
					});
					
					polyLine(); // 2. 선 생성 함수
					
					// #. 선 생성 함수
					function polyLine(){
						// 맵 초기화
						polyline.setMap(null);
						linePath = [];
						console.log("초기화");
						
						$('.list-daily').each(function(){
							// 반복문 : 장소계획
							$(this).find('.list-dailyplan').each(function(){
								var latitude = $(this).find('.list-dailyplan-latitude').val();
								var longitude = $(this).find('.list-dailyplan-longitude').val();
								var dir = new kakao.maps.LatLng(latitude, longitude);
								linePath.push(dir); // 좌표 반복문으로 추가
							});
						});
						
						polyline = new kakao.maps.Polyline({ // 좌표를 베이스로 선 생성
							endArrow: true, // 화살표 여부
						    path: linePath, // 선을 구성하는 좌표배열 입니다
						    strokeWeight: 3, // 선의 두께 입니다
							strokeColor: '#000000', // 선의 색깔입니다
							strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
							strokeStyle: 'solid' // 선의 스타일입니다
						});
						
						// 지도에 선을 표시합니다 
						polyline.setMap(map);  
					}
					/* 경로(선) */
					
					/* 삭제 (완료) */ 
					$('.list-dailyplan').find('.place-delete-button').click(function(){
						$(this).parents('.list-dailyplan').remove();
						
						polyline.setMap(null);
						
						polyLine();
					})
					/* 삭제 (완료) */
					
					/* 제어 */
					$(".list-dailyplan").find("select").change(function(){ 
						
						dataTemplate();
						
						function dataTemplate(){
							
							// FORM 데이터 초기화 
							$(".planList-place").remove();
							
							// 반복문 : 하루계획 
							$('.list-daily').each(function(){ 
								// 반복문 : 장소계획
								$(this).find('.list-dailyplan').each(function(){
									// 조건 : 선택 안한 값들은 데이터 등록에서 제외
									if($(this).find("select").val() != "선택") {
									
									var dataTemplate = $("#place-dailyplan-insert-template").html();
									
									var dailyIndex = $(this).parents('.list-daily').data("index");
									var placeIndex = $(this).data("index");
									
									// 데이터 전송 : 체크용 (완료)
									dataTemplate = dataTemplate.replace("{label-daily-index}", dailyIndex-1);
									dataTemplate = dataTemplate.replace("{label-place-index}", placeIndex-1);
									
									// 데이터 전송 : 다차원 배열 인덱스 (완료)
									
									// 하루 인덱스
									dataTemplate = dataTemplate.replace("{dailyList-index-lat}", dailyIndex-1);
									dataTemplate = dataTemplate.replace("{dailyList-index-lng}", dailyIndex-1);
									dataTemplate = dataTemplate.replace("{dailyList-index-name}", dailyIndex-1);
									dataTemplate = dataTemplate.replace("{dailyList-index-type}", dailyIndex-1);
									dataTemplate = dataTemplate.replace("{dailyList-index-place-order}", dailyIndex-1);
									dataTemplate = dataTemplate.replace("{dailyList-index-transfer}", dailyIndex-1);
									
									// 장소 인덱스
									dataTemplate = dataTemplate.replace("{placeList-index-lat}", placeIndex-1);
									dataTemplate = dataTemplate.replace("{placeList-index-lng}", placeIndex-1);
									dataTemplate = dataTemplate.replace("{placeList-index-name}", placeIndex-1);
									dataTemplate = dataTemplate.replace("{placeList-index-type}", placeIndex-1);
									dataTemplate = dataTemplate.replace("{dailyplanList-index-place-order}", placeIndex-1);
									dataTemplate = dataTemplate.replace("{dailyplanList-index-transfer}", placeIndex-1);
									
									// 데이터 전송 : 전송 값
									dataTemplate = dataTemplate.replace("{dailyplanPlaceOrder}", placeIndex);
									dataTemplate = dataTemplate.replace("{dailyplanTransfer}", $(this).find("select").val()); 
									
									dataTemplate = dataTemplate.replace("{placeLatitude}", $(this).find('.list-dailyplan-latitude').val());	
									dataTemplate = dataTemplate.replace("{placeLongitude}", $(this).find('.list-dailyplan-longitude').val());
									dataTemplate = dataTemplate.replace("{placeName}",$(this).find('.list-dailyplan-name').val());
									dataTemplate = dataTemplate.replace("{placeType}", $(this).find('.list-dailyplan-type').val());
									
									$("#plan-insert-container").append(dataTemplate);
									}
								});
								// 반복문 : 장소계획
							});
							// 반복문 : 하루계획
						}
						
					}); 
					/* 제어  */
					
			    });
			}
		
		} 
		
		
		/* 이벤트 : 계획표 생성 */
		$("#planner-insert-button").click(function(){
			planInsertService();
		});
		
		/* 비동기 전송 처리 영역 */
		function planInsertService(){
			$.ajax({
				url:"${pageContext.request.contextPath}/plan/data/planInsertService",
				type: "post",
				data: $("form").serialize(),
				success: function(){
					console.log("성공");
				},
				error: function(){
					console.log("실패");
				}
			});
		}
		
	}); 
</script>
<script type="text/template" id="planner-insert-template"> 
	<!-- 비동기 처리 : 계획표 생성(1회) -->
	<input type="hidden" name="plannerName" required readonly value={plannerName}>
	<input type="hidden" name="plannerStartDate" required readonly value={plannerStartDate}>
	<input type="hidden" name="plannerEndDate" required readonly value={plannerEndDate}>
	<br>
	<!-- 비동기 처리 : 계획표 생성(1회) -->
</script>
<script type="text/template" id="daily-insert-template">
	<!-- 비동기 처리 : 하루계획표 생성(N회) -->
	<div class="planList-daily" data-index={dailyList-index-data}>
		<input type="hidden" name="planList[{dailyList-index-stayDate}][0].dailyStayDate" required readonly value={dailyStayDate}>
		<input type="hidden" name="planList[{dailyList-index-order}][0].dailyOrder" required readonly value={dailyOrder}>
	</div>
	<br>
	<!-- 비동기 처리 : 하루 계획표 생성(N회) -->
</script>
<script type="text/template" id="place-dailyplan-insert-template">
	<!-- 비동기 처리 : 장소 & 장소계획 생성(N회) -->
		<div class="planList-place" data-index={placeList-index-data}>
			<label>{label-daily-index}일차 {label-place-index}번째</label>
			<input type="hidden" name="planList[{dailyList-index-lat}][{placeList-index-lat}].placeLatitude" required readonly value={placeLatitude}>
			<input type="hidden" name="planList[{dailyList-index-lng}][{placeList-index-lng}].placeLongitude" required readonly value={placeLongitude}>
			<input type="hidden" name="planList[{dailyList-index-name}][{placeList-index-name}].placeName" required readonly value={placeName}>
			<input type="hidden" name="planList[{dailyList-index-type}][{placeList-index-type}].placeType" required readonly value={placeType}>
			<input type="hidden" name="planList[{dailyList-index-place-order}][{dailyplanList-index-place-order}].dailyplanPlaceOrder" required readonly value={dailyplanPlaceOrder}>
 			<input type="hidden" name="planList[{dailyList-index-transfer}][{dailyplanList-index-transfer}].dailyplanTransfer" required readonly value={dailyplanTransfer}>
		</div>
</script>
<script type="text/template" id="user-daily-template">
	<!-- 사용자용 : 하루계획표 리스트 -->
	<div class="list-daily" data-index="{index}">
		<div class="list-daily-order">
			<label>{dailyOrder} 일차 하루계획표</label>
		</div>
		<div class="list-daily-placeName">
			<label>지역</label>
			<input type="text" readonly class="daily-placeName">
		</div>
		<div class="list-open-place-select-button">
			<button>지역 선택</button>
		</div>
	</div>
	<!-- 사용자용 : 하루계획표 리스트 -->
</script>
<script type="text/template" id="user-place-dailyplan-template">
	<!-- 사용자용 : 장소 & 장소계획 리스트 -->
	<div class="list-dailyplan" style="border-top: 1px solid" data-index="{index}"> 
		<div class="list-dailyplan-placeName">
			<label>{place-name}</label>
		</div>
		<div class="list-dailyplan-transfer">
			<label>교통수단</label>
			<select clsss="transfer">
				<option value="선택" selected>선택</option>
				<option value="항공">항공</option>
				<option value="기차">기차</option>
				<option value="자동차">자동차</option>
			</select>
		</div>
		<input type="hidden" class="list-dailyplan-latitude" value={data-latitude}>
		<input type="hidden" class="list-dailyplan-longitude" value={data-longitude}>
		<input type="hidden" class="list-dailyplan-name" value={data-name}>
		<input type="hidden" class="list-dailyplan-type" value={data-type}>
		<input type="button" class="place-delete-button" value="삭제">
	</div>
	<!-- 사용자용 : 장소 & 장소계획 리스트 -->
</script>
<body>
	<main>
		<div class="container-lg">
			<div class="row">
				<div class="col-xs-6 col-md-4">
					<!-- 통합계획표 입력창 -->
					<div id="planner-insert-confirm" style="border: 1px solid">
						<div style="font-weight:bold;">통합계획표</div>
							<label>계획표 이름</label>
							<input type="text" id="planner-name"> 
							<br>
							<label>날짜선택</label>
							<input type="text" id="demo">
							<br>
							<input type="button" id="planner-map-find" value="계획표 생성">
							<input type="hidden" id="planner-insert-button" value="계획표 생성완료">
							<br>
					</div>
					<!-- 통합계획표 입력창 -->	
					<!-- 검색창 -->
					<div id="search"> 
						<div style="font-weight:bold;">장소 검색창</div>
							<label>검색 유형 : </label>
							<input type="checkbox" class="type" id="hotel" value="호텔">
							<label>호텔</label>
							<input type="checkbox" class="type" id="tour" value="관광지">
							<label>관광지</label>
							<br>
							<label>검색어</label>
							<input type="text" id="keyword" required="required">
							<button id="find">검색</button>
					</div>
				<!-- 검색창 -->
				<!-- 하루계획표 -->
				<div id="daily-list-container"></div>
				<!-- 하루계획표 -->
				<form id="plan-insert-container"></form>
				<input type="hidden" id="daily-index">
				<input type="hidden" id="place-index">
				</div>
				<div class="col-xs-12 col-md-8">
					<div id="map"></div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>