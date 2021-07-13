<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 포토스토리 작성 페이지 -->
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
</html>
