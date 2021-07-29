<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	$(function(){
		name();
// 		function print(ResultPlanVO) { 
			
// 			var ResultPlanVO = [];
			
// 			//jsontext에 JSON객체를 넣는다. 	
// 			var json = ResultPlanVO.data; 
// 			console.log(json);
// 			//JSON.parse를 이용해 jsontext를 파싱해 리스트(javascript list)로 만든후 contact에 넣어준다. 	
// 			var contact = JSON.parse(json); 
	
// 			//for문을 돌면서 contact[i]의 key 값을 가져와 value값 출력해준다. 	
// 			for (var i = 0; i < contact.length; i++) { 	
// 				$("#?").append(contact[i].id + " : " + contact[i].pw	+ ""); 		
// 			} 	
// 		}
		
		
		
		
		
		function name() {
			// 목표 : 가져온 데이터를 자바스크립트 형태의 배열로 바꾸기 
			
			var a = ResultPlanVO
			
			var ResultPlanVO = {data:[{plannerNo:29, plannerName:'뭐지2', plannerOpen:'Y', memberNo:8, dailyNo:82, dailyStayDate:2, 
				dailyOrder:1, placeNo:114, placeLatitude:35.1479610706454, placeLongitude:126.854957397537, placeName:'광주', 
				placeType:'관광지', dailyplanPlaceOrder:3, dailyplanTransfer:'자동차'}]}
				
			console.log(ResultPlanVO);
				
// 				ResultPlanVO(plannerNo=29, plannerName=뭐지2, plannerOpen=Y, memberNo=8, dailyNo=82, dailyStayDate=2, 
// 						dailyOrder=1, placeNo=113, placeLatitude=35.1474913380556, placeLongitude=126.919801652795, placeName=광주, placeType=관광지, dailyplanPlaceOrder=2, dailyplanTransfer=자동차), 
// 						ResultPlanVO(plannerNo=29, plannerName=뭐지2, plannerOpen=Y, memberNo=8, dailyNo=82, dailyStayDate=2, dailyOrder=1, placeNo=112, placeLatitude=35.1536473895368, placeLongitude=126.852418698035, placeName=광주, placeType=호텔, dailyplanPlaceOrder=1, dailyplanTransfer=자동차), 
// 						ResultPlanVO(plannerNo=29, plannerName=뭐지2, plannerOpen=Y, memberNo=8, dailyNo=83, dailyStayDate=2, dailyOrder=2, placeNo=117, placeLatitude=35.8776099705901, placeLongitude=127.130667010808, placeName=전주, placeType=관광지, dailyplanPlaceOrder=3, dailyplanTransfer=자동차)}]}
			
			
			// 템플릿 불러오기 
// 			var template = $("#result-template").html();
			
// 			console.log("배열 길이 : " + ${list});
			
			// 1. 데이터를 자바스크립트 배열로 변환 (예 : ${list} -> ResultPlanVO )
			// 2. 반복문 으로 배열길이 만큼 데이터 집어넣기 실행
			// for(var i = 0; i <ResultPlanVO.length; i++){
			//	template = template.reaplace("{plannerNo}", ResultPlanVO[i].plannerNo)
			// }
			
			// 첨부 
			// $("#result-container").append(template);
		}
	})
</script>

<script type="text/template" id="result-template"> 
	<input type="text" name="plannerNo" value={plannerNo}>
	<input type="text" name="plannerOpen" value={plannerOpen}>
    <input type="text" name="plannerName" value={plannerName}>
    <input type="text" name="memberNo" value={memberNo}>
    <input type="text" name="dailyNo" value={dailyNo}>
    <input type="text" name="dailyStayDate" value={dailyStayDate}>
    <input type="text" name="dailyOrder" value={dailyOrder}>
    <input type="text" name="placeNo" value={placeNo}>
    <input type="text" name="placeLatitude" value={placeLatitude}>
    <input type="text" name="placeLongitude" value={placeLongitude}>
    <input type="text" name="placeName" value={placeName}>
    <input type="text" name="placeType" value={placeType}>
    <input type="text" name="dailyplanPlaceOrder" value={dailyplanPlaceOrder}>
    <input type="text" name="dailyplanTransfer" value={dailyplanTransfer}>
</script>

<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-12 offset-lg-0.5">
				<div class="row my-3 align-items-center">
					<div class="col-3" style="font-size: 1.5rem">
					<h4>플래너 이름</h4>
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
				<div>
					<c:forEach items="${list}" var="list.length" begin="0" end="0">
						<c:out value="${list}"/>
					</c:forEach>
				</div>
				<div id="result-container"></div>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>