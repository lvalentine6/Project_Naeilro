<%@page import="com.kh.finale.entity.member.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=60b30d68f4da16b4a316665d189e702f&libraries=services"></script>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
$(function(){
		
	$( window ).resize(function() {
		$(".story-photo").height($('.story-photo').width()+'px')
	});

})

$(function(){
	$(".story-photo").height($('.story-photo').width()+'px')
	
	<c:forEach items="${planList}" var="plan">
	var container = document.getElementById('map_${plan.plannerNo}'); //지도를 담을 영역의 DOM 레퍼런스
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(${plan.placeLatitude}, ${plan.placeLongitude}), //지도의 중심좌표.
		draggable: false,
		level: 10 //지도의 레벨(확대, 축소 정도)
	};
	
	

	var map = new kakao.maps.Map(container, options);
	var markerPosition  = new kakao.maps.LatLng(${plan.placeLatitude}, ${plan.placeLongitude}); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});

	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	</c:forEach>

})
</script>
<main>
		<div class="container-lg mypage_planner">
			<div class="row">
			<div class="jumbotron w-100">
				<h3 class="display-5">다른 여행자들 플래너</h3>
			</div>
			</div>
			<div class="row">
			<c:forEach items="${planList}" var="plan">
				<div class="col-4 px-0 pr-1 mb-2">
				<div class="card w-100 story-photo">
				<div id="map_${plan.plannerNo}"class="w-100 h-75 card-img-top"></div>
				  <div class="card-body">
				    <p class="card-text"><a href="${pageContext.request.contextPath}/plan/resultPlan?plannerNo=${plan.plannerNo}">${plan.plannerName }</a></p>
				  </div>
				</div>
		    	</div>
		    </c:forEach>
			</div>		
		</div>
		
				<div class="mt-4">
		  <ul class="pagination justify-content-center">
		  	<c:if test="${page.pageNo>page.pageSize}">
			    <li class="page-item">
			      <a class="page-link" href="?pageNo=${page.startBlock-1}" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			</c:if>
		    <c:forEach var="p" begin="${page.startBlock}" end="${page.endBlock}">
		    	<c:if test="${p==page.pageNo}">
				    <li class="page-item active"><a class="page-link active" href="?pageNo=${p}">${p}</a></li>
		    	</c:if>
		    	<c:if test="${p!=page.pageNo}">
				    <li class="page-item"><a class="page-link active" href="?pageNo=${p}">${p}</a></li>
		    	</c:if>
		    </c:forEach>
		    <c:if test="${ (page.lastBlock-page.pageSize) > page.startBlock}">
			    <li class="page-item">
			      <a class="page-link" href="?pageNo=${page.endBlock+1}" aria-label="Next">
			        <span aria-hidden="true">&raquo;</span>
			      </a>
			    </li>
		    </c:if>

		  </ul>
		</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>