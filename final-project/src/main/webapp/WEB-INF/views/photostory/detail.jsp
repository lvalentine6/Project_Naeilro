<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!-- 포토스토리 상세 페이지 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
내용: ${photostoryListDto.photostoryContent}
<br>
작성날짜: ${photostoryListDto.getPhotostoryDateString()}
<br>
닉네임: ${photostoryListDto.memberNick}
<br>
댓글수: ${photostoryListDto.photostoryCommentCount}
<br>
좋아요수: ${photostoryListDto.photostoryLikeCount}
<br><br>
<c:forEach var="photostoryCommentListDto" items="${photostoryCommentList}">
	댓글작성자닉: ${photostoryCommentListDto.photostoryCommentMemberNick}
<br>
	댓글내용: ${photostoryCommentListDto.photostoryCommentContent}
<br>
	댓글작성날짜: ${photostoryCommentListDto.getPhotostoryCommentDateString()}
<br><br>
</c:forEach>
</body>
</html>