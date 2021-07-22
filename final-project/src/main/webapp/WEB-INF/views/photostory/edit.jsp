<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<script>
	var sel_files = [];
	var delete_no =[];
	$(function(){
		$(".story-photo").height($('.upload_img').width()+'px')
		$(".input_img").on("change",handleImgFileSelect)
		$( window ).resize(function() {
			$(".story-photo").height($('.upload_img').width()+'px')
		});
		
		$(".submit_btn").click(function(e){
			for(let i=0;i<sel_files.length;i++){
				var $input = $('<input type="hidden" name="index" value="'+sel_files[i]+'">');
				$(".photostory_form").append($input)
			}
			for(let i=0;i<delete_no.length;i++){
				var $input = $('<input type="hidden" name="deleteNo" value="'+delete_no[i]+'">');
				$(".photostory_form").append($input)
			}
		})
	})
	
	
	function handleImgFileSelect(e){
		sel_files=[];
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		var index = 0;
		
		filesArr.forEach(function(f){
			
			$(".prev_img").remove();
			var reader = new FileReader();
			reader.onload = function(e){
				var html = '<div class="d-inline-block position-relative story-photo prev_img" id="img_id_'+index+'" style="width: 24%;height:'+$('.upload_img').width()+'px"> <img class="upload_img story-photo h-100 add_img" src="'+e.target.result+'"> <i class="fas fa-times text-danger position-absolute" onclick="deleteImageAction('+index+')" style="right:4%; top:4%; font-size: 1rem"></i> </div>';
				$(".imgs_wrap").append(html);
				sel_files.push(index);
				index++
			}
			reader.readAsDataURL(f);
		})
	}
	function deleteExistenceImage(no){
		delete_no.push(no)
		
		let img_id = "#del_id_"+no
		$(img_id).remove();
	}
	function deleteImageAction(index){
		console.log('index =' + index)
		sel_files.splice(index,1);
		
		let img_id = "#img_id_"+index
		$(img_id).remove();
		console.log(sel_files);
	}
</script>

<main>
	<div class="container-lg">
		<div class="row">
			<div class="jumbotron col-lg-6 offset-lg-3">
				<h3 class="display-5">스토리 수정</h3>
			</div>
			<div class="col-lg-6 offset-lg-3 text-center">
				<form action="edit" method="get" class="photostory_form encrypt-form"
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
							<div class="d-inline-block position-relative story-photo" id="del_id_${photostoryPhotoDto.photostoryPhotoNo}" style="width: 24%;height:'+$('.upload_img').width()+'px">
								<img class="upload_img story-photo h-100 add_img" src="${pageContext.request.contextPath}/photostory/photo/${photostoryPhotoDto.photostoryPhotoNo}">
								<i class="fas fa-times text-danger position-absolute" onclick="deleteExistenceImage(${photostoryPhotoDto.photostoryPhotoNo})" style="right:4%; top:4%; font-size: 1rem"></i> 
							</div>
						</c:forEach>
						</div>
					</div>
					
					<div class="form-row mb-3">
						<input type="hidden" name="photostoryNo" value="${photostoryListDto.photostoryNo}">
						<label for="photostoryContent">스토리 내용</label> 
						<textarea class="form-control" name="photostoryContent" aria-label="With textarea">${photostoryListDto.photostoryContent}</textarea>
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
