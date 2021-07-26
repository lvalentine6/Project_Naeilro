<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<main>
	<div class="container-lg">
		<div class="row">
			<div>
				<a href="${pageContext.request.contextPath}">
				<img class="go_to_home" src="${pageContext.request.contextPath}/image/img_nopage.png">
				</a>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
