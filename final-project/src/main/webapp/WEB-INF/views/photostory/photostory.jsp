<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%-- <!-- 포토스토리 리스트 페이지 -->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8" />
		<title>Insert title here</title>
		<!-- 영역 구분용 임시 테두리 -->
		<style>
			.photostory {
				border: 1px dotted red;
			}
			.comment {
				border: 1px dotted purple;
			}
			.pagination {
				border: 1px dotted blue;
			}
		</style>

		<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
		<script>
			$(function () {
				// 글쓰기 버튼 클릭 시 페이지 이동
				$('.btn-write').click(function () {
					location.href = '${pageContext.request.contextPath}/photostory/write';
				});
			});
		</script>
	</head>
	<body>
		<!-- 검색창 영역 시작 -->
		<form action="photostory" method="GET">
			<select name="searchType">
				<option value="photostoryTitle">제목</option>
				<option value="photostoryContent">내용</option>
				<option value="memberNick">닉네임</option>
			</select>
			<input type="text" name="searchKeyword" />
			<input type="button" value="검색" />
		</form>
		<!-- 검색창 영역 종료 -->

		<!-- 글쓰기 버튼 -->
		<button class="btn-write">글쓰기</button>

		<!-- 포토스토리 리스트 영역 시작 -->
		<div class="">
			<c:forEach var="photostoryDto" items="${list}">
				<!-- 포토스토리 게시물 영역 시작 -->
				<div class="photostory">
					<div class="">${photostoryDto.photostoryTitle}</div>
					<div class="">${photostoryDto.photostoryContent}</div>
				</div>
				<!-- 포토스토리 게시물 영역 종료 -->

				<!-- 좋아요 버튼 -->
				<span class="btn-like">♥</span>
				<span class="btn-like">♡</span>

				<!-- 댓글 작성 영역 시작 -->
				<div class="comment">
					<input type="text" name="photostoryCommentContent">
					<button>댓글 작성</button>
				</div>
				<!-- 댓글 작성 영역 종료 -->

				<!-- 댓글 영역 시작 -->
				<div class="">
					<div class="">댓글1</div>
					<div class="">댓글2</div>
					<div class="">댓글3</div>
				</div>
				<!-- 댓글 영역 종료 -->
			</c:forEach>
		</div>
		<!-- 포토스토리 리스트 영역 종료 -->

		<!-- 페이지네이션 영역 시작 -->
		<div class="pagination">
			<c:if test="${photostoryVO.startBlock > 1}">
				<a class="move-link">&lt;&lt;</a>
				<a class="move-link">&lt;</a>
			</c:if>
			<c:forEach
				var="i"
				begin="${photostoryVO.startBlock}"
				end="${photostoryVO.endBlock}"
				step="1"
			>
				<c:choose>
					<c:when test="${i} == ${photostoryVO.pageNo}">
						<a class="on">${i}</a>
					</c:when>
					<c:otherwise>
						<a>${i}</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${photostoryVO.endBlock < photostoryVO.lastBlock}">
				<a class="move-link">&gt;</a>
				<a class="move-link">&gt;&gt;</a>
			</c:if>
		</div>
		<!-- 페이지네이션 영역 종료 -->
	</body>
</html> --%>


<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<main>
		<c:forEach var="photostoryTotalListDto" items="${photostoryTotalList}">
	<div class="container-lg ">
		<div class="row justify-content-center ">
			<div class=" col-lg-8 offset-lg-2 mx-2">
				<div class='border row align-items-center'>
					<div class="col-1"><img class="my-2 user_profile_sm user_profile" src="${pageContext.request.contextPath}/image/default_user_profile.jpg"></div>
					<div class="col-3">${photostoryTotalListDto.memberNick}글작성자 닉네임</div>
					<div class="col-1 offset-7 text-right"><i class="fas fa-ellipsis-h"></i></div>
				</div>
				<div class=' row align-items-center'>
					<img class="w-100 border" src="${pageContext.request.contextPath}/image/bgimg.webp"/>
				</div>
				<div class='row align-items-center border-left border-right'>
					<div class="col-1  py-2"><i class="far fa-heart fa-lg"></i></div>
					<div class="col-1"><i class="far fa-comment fa-lg"></i></div>
					<div class="col-10"></div>
				</div>
				<div class='row align-items-center border-left border-right'>
					<div class="col-12 ">좋아요 ${photostoryTotalListDto.photostoryLikeCount}</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 "><strong>${photostoryTotalListDto.memberNick}글작성자 닉네임</strong>&nbsp;&nbsp;${photostoryTotalListDto.photostoryContent} 아무글 아무글아무글아무글 아무글아무글 아무글아무글아무글아무글 아무글아무글아무글아무글</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 text-black-50 font-weight-bold">댓글 ${photostoryTotalListDto.photostoryCommentCount}개 모두 보기</div>
				</div>
				<div class='row align-items-center border-left border-right mb-1'>
					<div class="col-12 "><strong>user_test_id2</strong>&nbsp;&nbsp;아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글</div>
					<div class="col-12 "><strong>user_test_id3</strong>&nbsp;&nbsp;아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글</div>
					<div class="col-12 "><strong>user_test_id4</strong>&nbsp;&nbsp;아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글아무댓글</div>
				</div>
				<div class='row align-items-center border-left border-right border-bottom mb-3 pb-3'>
					<div class="col-12 text-black-50 font-weight-bold text-right">${photostoryTotalListDto.getPastDateString()}</div>
				</div>
			</div>
		</div>
	</div>
		</c:forEach>
</main>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>


