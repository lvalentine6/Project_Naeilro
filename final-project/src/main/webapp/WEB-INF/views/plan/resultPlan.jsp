<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
	$(function(){
		planSelectService();
		//name();
		
		function planSelectService(){
			
			var ResultPlanVO = [];
			ResultPlanVO = ${list};
			
			// 데이터 정렬
			ResultPlanVO.sort(function(a, b)  {
				  return a.dailyOrder - b.dailyOrder;
				});
				console.log(ResultPlanVO);
			
			var plannerName = ResultPlanVO[0].plannerName
			
			var dailyStayDate = ResultPlanVO[0].dailyStayDate
			
			// 변수 설정
			$("#planName").text(plannerName);
			$("#date").text(dailyStayDate + "일간의 여행");
			
			console.log(plannerName);
			
			console.log("초기값 : " + ResultPlanVO[0].dailyOrder);
			
			
			// 하루 계획표 템플릿 출력 준비
 				/* var template = $("#result-template").html();
				template = template.replace("{dr}", ResultPlanVO[0].dailyOrder)
				$("#result-container").append(template); */
			
			 /* for(var i = 0; i < ResultPlanVO.length; i++) {
				if(ResultPlanVO[i].dailyOrder != ResultPlanVO[i+1].dailyOrder) {
					var template = $("#result-template").html();
					template = template.replace("{dr}", ResultPlanVO[i+1].dailyOrder)
					$("#result-container").append(template);
				}
			 } */
			for(var i = 0; i < ResultPlanVO.length; i++){ // 1 1 2 2
				// 0 이면 생성 
				if(i == 0){
					var template = $("#result-template").html();
					template = template.replace("{dr}", ResultPlanVO[0].dailyOrder); // 1
					template = template.replace("{index}", ResultPlanVO[0].dailyOrder);
					$("#result-container").append(template);
				} 
				// 하루계획 순서가 달라지면 생성 
				else if($(".daily-plan-container").data("index") != ResultPlanVO[i].dailyOrder){
					var template = $("#result-template").html();
					template = template.replace("{dr}", ResultPlanVO[i].dailyOrder); // 1 2 2
					template = template.replace("{index}", ResultPlanVO[i].dailyOrder);
					$("#result-container").append(template);
				}
			}
			// 반복문 으로 배열길이 만큼 데이터 집어넣기 실행
			 /* for(var i = 0; i < ResultPlanVO.length; i++) {
				 var template1 = $("#plan-template").html();
				console.log(ResultPlanVO[i].dailyOrder)
				/* template1 = template1.replace("{plannerNo}", ResultPlanVO[i].plannerNo)
				template1 = template.replace("{plannerOpen}", ResultPlanVO[i].plannerOpen)
				template1 = template.replace("{plannerName}", ResultPlanVO[i].plannerName)
				template1 = template.replace("{memberNo}", ResultPlanVO[i].memberNo)
				template1 = template.replace("{dailyNo}", ResultPlanVO[i].dailyNo)
				template1 = template.replace("{dailyStayDate}", ResultPlanVO[i].dailyStayDate)
				template1 = template.replace("{dailyOrder}", ResultPlanVO[i].dailyOrder)
				template1 = template.replace("{placeNo}", ResultPlanVO[i].placeNo)
				template1 = template.replace("{placeLatitude}", ResultPlanVO[i].placeLatitude)
				template1 = template.replace("{placeLongitude}", ResultPlanVO[i].placeLongitude)
				template1 = template.replace("{placeName}", ResultPlanVO[i].placeName)
				template1 = template.replace("{placeType}", ResultPlanVO[i].placeType)
				template1 = template.replace("{dailyplanPlaceOrder}", ResultPlanVO[i].dailyplanPlaceOrder)
				template1 = template.replace("{dailyplanTransfer}", ResultPlanVO[i].dailyplanTransfer)
				template1 = template.replace("{placeNo}", ResultPlanVO[i].placeNo)
				$(".daily-plan-container").append(template1);
			 } */
			
			
		}
	});
</script>

<script type="text/template" id="result-template">
	<!-- 하루 계획표 출력 템플릿 -->
	<div style="border: 1px solid gray" class="daily-plan-container" data-index={index}>
	<label>{dr} 일차 하루계획표</label>
    </div>
	<br>
</script>

<script type="text/template" id="plan-template">
	<!-- 여행 계획 출력 템플릿 -->
	<div>
	<input type="hidden" name="plannerNo" value={plannerNo} readonly>
	<input type="hidden" name="plannerOpen" value={plannerOpen} readonly>
    <input type="hidden" name="plannerName" value={plannerName} readonly>
    <input type="hidden" name="memberNo" value={memberNo} readonly>
    <input type="hidden" name="dailyNo" value={dailyNo} readonly>
    <input type="text" name="dailyplanPlaceOrder" value={dailyplanPlaceOrder} readonly>
    <input style="border: none;" type="hidden" name="dailyStayDate" value={dailyStayDate} readonly> 
    <input type="hidden" name="dailyOrder" value={dailyOrder} readonly>
    <input type="hidden" name="placeNo" value={placeNo} readonly>
    <input type="hidden" name="placeLatitude" value={placeLatitude} readonly>
    <input type="hidden" name="placeLongitude" value={placeLongitude} readonly>
    <input style="border: none;" type="text" name="placeName" value={placeName} readonly>
    <input style="border: none;" type="text" name="placeType" value={placeType} readonly>
    <input style="border: none;" type="text" name="dailyplanTransfer" value={dailyplanTransfer} readonly>
	<br>
    </div>
	<br>
</script>

<main>
<div></div>
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
					<img class="img-responsive left-block" alt="더미"
						src="${pageContext.request.contextPath}/image/default_user_profile.jpg">
					<div id ="result-image-template" class="col-4 align-items-center" style="font-size: 1.5rem">
						포토 스토리 연동</div>
				</div>
			</div>
			<div class="col-12">
					<div>
					<b><span id = "date" style="font-size: 25px; color: rgb(3,199,90);" ></span></b>
					</div>
					<br>
				<div>
				</div>
				<div id="result-container"></div>
				<div id="plan-container"></div>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>