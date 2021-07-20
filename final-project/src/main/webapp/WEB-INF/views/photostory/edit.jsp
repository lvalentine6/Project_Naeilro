<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	var sel_files = [];
	
	$(function(){
		$(".input_img").on("change",handleImgFileSelect)
	})
	
	function handleImgFileSelect(e){
		sel_files=[];
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;
		
		filesArr.forEach(function(f){
			sel_files.push(f);
			$(".add_img").remove();
			var reader = new FileReader();
			reader.onload = function(e){
				var html = "<img class='upload_img story-photo add_img' style='width: 24%' src='"+e.target.result+"'>";
				$(".imgs_wrap").append(html);
				index++
			}
			reader.readAsDataURL(f);
		})
	}
</script>

<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">스토리 수정</h3>
			</div>
			<div class="col-lg-6 offset-lg-3 text-center">
				<form action="edit" method="post" class="sign_up_form encrypt-form"
					enctype="multipart/form-data">
					<!-- 	프로필 사진 업로드 -->
					<div class="form-row mb-3">
						<label for='photostoryPhoto'>스토리 사진</label>
					</div>
					<div class="form-row mb-3 row ">
						<div class="col text-left imgs_wrap">
						<label for="photostoryPhoto" style="width: 24%"> <img
							class='upload_img story-photo'
							src="${pageContext.request.contextPath}/image/photo_story_default.png"
							>
							 <input
							class="input_img" type="file" accept=".png, .jpg, .gif"
							id="photostoryPhoto" name="photostoryPhoto" style="display: none" multiple/>
						</label>
						<c:forEach var="photostoryPhotoDto" items="${photostoryPhotoList}">
						   <img class="w-100 border"
						      src="${pageContext.request.contextPath}/photostory/photo/${photostoryPhotoDto.photostoryPhotoNo}" />
						</c:forEach>
						</div>
					</div>
					
					<div class="form-row mb-3">
						<label for="photostoryContent">스토리 내용</label> 
						<textarea class="form-control" name="photostoryContent" aria-label="With textarea">
							${photostoryListDto.photostoryContent}
						</textarea>
						<small id="emailHelp" class="form-text text-muted">스토리 내용을 작성해주세요.</small>
					</div>
					
					<div class="form-row mb-5 justify-content-around">
						<button class="btn btn-primary submit_btn btn-block" type="submit">수정</button>
						<button class="btn btn-secondary cancel-btn btn-block"
							type="button">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
