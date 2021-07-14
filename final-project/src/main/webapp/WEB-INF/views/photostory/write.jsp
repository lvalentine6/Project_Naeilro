<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- <!-- 포토스토리 작성 페이지 -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Insert title here</title>
		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<script>
			$(function () {
				$('.btn-write').click(function () {
					$('.form-write').submit();
				});
			});
		</script>
	</head>
	<body>
		<form
			action="${pageContext.request.contextPath}/photostory/write"
			method="POST"
			class="form-write"
		>
			<div>
				<input type="text" name="photostoryTitle" placeholder="제목" />
			</div>
			<div>
				<input type="text" name="photostoryContent" placeholder="내용" />
			</div>
			<div>
				<input type="file" name="f" accept=".jpg, .png, .gif" multiple />
			</div>
			<div>
				<input type="button" class="btn-write" value="작성" />
			</div>
		</form>
	</body>
</html> --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	function readImage(input) {
	    if(input.files && input.files[0]) {
	        const reader = new FileReader()
	        reader.onload = e => {
	            const previewImage = document.querySelector(".upload_img")
	            previewImage.src = e.target.result
	        }
	        reader.readAsDataURL(input.files[0])
	    }
	}
	$(function(){
		$(".input_img").change(function(e){
			readImage(e.target)
		})
	})
</script>

<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">스토리 작성</h3>
			</div>
			<div class="col-lg-6 offset-lg-3 text-center">
				<form action="join" method="post" class="sign_up_form encrypt-form"
					enctype="multipart/form-data">
					<!-- 	프로필 사진 업로드 -->
					<div class="form-row mb-3">
						<label for='photostoryPhoto'>스토리 사진</label>
					</div>
					<div class="form-row mb-3 justify-content-center row">
						<div class="col-12">
						<label for="photostoryPhoto"  style="width: 100%"> <img
							class='upload_img story-photo'
							src="${pageContext.request.contextPath}/image/photo_story_default.png"
							> <input
							class="input_img" type="file" accept=".png, .jpg, .gif"
							id="photostoryPhoto" name="photostoryPhoto" style="display: none" />
						</label>
						</div>
					</div>
					
					<div class="form-row mb-3">
						<label for="photostoryContent">스토리 내용</label> <textarea class="form-control" name="photostoryContent" aria-label="With textarea"></textarea>
						<small id="emailHelp" class="form-text text-muted">스토리 내용을 작성해주세요.</small>
					</div>
					
					<div class="form-row mb-5 justify-content-around">
						<button class="btn btn-primary submit_btn btn-block" type="submit">작성</button>
						<button class="btn btn-secondary cancel-btn btn-block"
							type="button">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
