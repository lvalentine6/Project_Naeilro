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
		
		/*작성자 : 정 계진*/
		function planSelectService(){
			
			var ResultPlanVO = [];
			ResultPlanVO = ${list};
			
			var plannerName = ResultPlanVO[0].plannerName
			$('input[name=plannerName]').attr('value', plannerName);
			
			console.log(plannerName);
			
			console.log(ResultPlanVO[2].placeName);
			
			
			// 템플릿 불러오기 
 			var template = $("#result-template").html();
			
			// 반복문 으로 배열길이 만큼 데이터 집어넣기 실행
			 for(var i = 0; i < ResultPlanVO.length; i++) {
				console.log(ResultPlanVO[i].dailyOrder)
				template = template.replace("{plannerNo}", ResultPlanVO[i].plannerNo)
				template = template.replace("{plannerOpen}", ResultPlanVO[i].plannerOpen)
				template = template.replace("{plannerName}", ResultPlanVO[i].plannerName)
				template = template.replace("{memberNo}", ResultPlanVO[i].memberNo)
				template = template.replace("{dailyNo}", ResultPlanVO[i].dailyNo)
				template = template.replace("{dailyStayDate}", ResultPlanVO[i].dailyStayDate)
				template = template.replace("{dailyOrder}", ResultPlanVO[i].dailyOrder)
				template = template.replace("{placeNo}", ResultPlanVO[i].placeNo)
				template = template.replace("{placeLatitude}", ResultPlanVO[i].placeLatitude)
				template = template.replace("{placeLongitude}", ResultPlanVO[i].placeLongitude)
				template = template.replace("{placeName}", ResultPlanVO[i].placeName)
				template = template.replace("{placeType}", ResultPlanVO[i].placeType)
				template = template.replace("{dailyplanPlaceOrder}", ResultPlanVO[i].dailyplanPlaceOrder)
				template = template.replace("{dailyplanTransfer}", ResultPlanVO[i].dailyplanTransfer)
				$("#result-container").append(template);
			 }
		}
	});
</script>

<script type="text/template" id="result-template">
	<label>{dailyOrder} 일차 하루계획표</label>
	<br><br>
	<input type="text" name="plannerNo" value={plannerNo} readonly>
	<input type="text" name="plannerOpen" value={plannerOpen} readonly>
    <input type="text" name="plannerName" value={plannerName} readonly>
    <input type="text" name="memberNo" value={memberNo} readonly>
    <input type="text" name="dailyNo" value={dailyNo} readonly>
    <input type="text" name="dailyStayDate" value={dailyStayDate} readonly> 
    <input type="text" name="dailyOrder" value={dailyOrder} readonly>
    <input type="text" name="placeNo" value={placeNo} readonly>
    <input type="text" name="placeLatitude" value={placeLatitude} readonly>
    <input type="text" name="placeLongitude" value={placeLongitude} readonly>
    <input type="text" name="placeName" value={placeName} readonly>
    <input type="text" name="placeType" value={placeType} readonly>
    <input type="text" name="dailyplanPlaceOrder" value={dailyplanPlaceOrder} readonly>
    <input type="text" name="dailyplanTransfer" value={dailyplanTransfer} readonly>
	<br><br>
</script>

<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-12 offset-lg-0.5">
				<div class="row my-3 align-items-center">
					<div class="col-3" style="font-size: 1.5rem">
					<input type="text" name="plannerName" value="" readonly>
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
					<div class="col-4 align-items-center" style="font-size: 1.5rem">
						포토 스토리 연동</div>
				</div>
			</div>
			<div class="col-12">
				<h3>여행 계획 출력</h3>
				<div id="result-container"></div>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>