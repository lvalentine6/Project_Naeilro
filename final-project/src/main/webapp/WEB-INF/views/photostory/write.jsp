<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- 포토스토리 작성 페이지 -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Insert title here</title>
		<script>
			addEventListener('load', function () {
				document.querySelector('.btn-write').addEventListener('click', function () {
					document.querySelector('.form-write').submit();
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
			<input type="text" name="photostoryTitle" placeholder="제목">
			<textarea name="photostoryContent" placeholder="내용"></textarea>
			<input type="button" class="btn-write" value="작성" />
		</form>
	</body>
</html>
