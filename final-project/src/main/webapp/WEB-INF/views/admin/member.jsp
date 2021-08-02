<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/adminHeader.jsp"></jsp:include>
<main>
<div class="container-lg">
	<div class="row">
		<div class="jumbotron col-lg-10 offset-lg-1">
		<h3 class="display-5">회원관리</h3>
	</div>
		<div class="col-lg-10 offset-lg-1">
				<form class="row" action="">
				<input type="hidden" value="${page.pageNo}">
				<div class="col-2 offset-9 justify-content-center py-3 px-0 text-nowrap align-items-center d-flex">
					<select class="custom-select" name="type">
					<c:choose>
						<c:when test='${type=="Y" }'>
							<option  value="all">모두보기</option>
							<option value="N">비정지회원</option>
							<option selected value="Y">정지회원</option>
						</c:when>
						<c:when test='${type=="N" }'>
							<option  value="all">모두보기</option>
							<option selected value="N">비정지회원</option>
							<option value="Y">정지회원</option>
						</c:when>
						<c:otherwise>
							<option selected value="all">모두보기</option>
							<option value="N">비정지회원</option>
							<option value="Y">정지회원</option>
						</c:otherwise>
					</c:choose>

					</select>
				</div>
				<div class="col-1 justify-content-center py-3 px-0 text-nowrap align-items-center d-flex">
					<button type="submit" class="btn btn-primary btn-sm">보기</button>
				</div>
				</form>
		</div>
	</div>
	<div class="row">
			<table class="col-lg-10 offset-lg-1 table table-hover table-striped table-responsive text-center">
			  <thead>
			    <tr>
			      <th scope="col" class="text-left">아이디</th>
			      <th scope="col" class="text-left">닉네임</th>
			      <th scope="col" class="text-left">이메일</th>
			      <th scope="col" class="text-left">이름</th>
			      <th scope="col">생일</th>
			      <th scope="col" class="text-nowrap">성별</th>
			      <th scope="col">등급</th>
			      <th scope="col">상태</th>
			      <th scope="col" class="text-nowrap">신고횟수</th>
			      <th scope="col" class="text-nowrap">상세보기</th>
			      <th scope="col" class="text-nowrap">정지</th>
			    </tr>
			  </thead>
			  <tbody>
			  	<c:forEach items="${memberList}" var="memberVo">
			    <tr>
			      <td scope="row" class="text-nowrap text-left">${memberVo.memberId }</td>
			      <td class="text-nowrap text-left">${memberVo.memberNick }</td>
			      <td class="text-nowrap text-left">${memberVo.memberEmail}</td>
			      <td class="text-nowrap text-left">${memberVo.memberName}</td>
			      <td class="text-nowrap">${memberVo.memberBirth}</td>
			      <td class="text-nowrap">${memberVo.memberGender}</td>
			      <c:if test="${memberVo.memberGrade==2}">
				      <td class="text-nowrap">일반</td>
			      </c:if>
			      <c:if test="${memberVo.memberGrade==1}">
				      <td class="text-nowrap">관리자</td>
			      </c:if>
			      <td class="text-nowrap">${memberVo.memberState}</td>
			      <td class="text-nowrap">${memberVo.reportCount}</td>
			      <td class="text-nowrap"><a class="btn btn-outline-primary btn-sm" href="${pageContext.request.contextPath}/admin/report_detail?memberNo=${memberVo.memberNo}" role="button">상세보기</a></td>
   			      <c:if test='${memberVo.memberState=="정지"}'>
				      <td class="text-nowrap"><button class="btn btn-outline-info btn-sm"  role="button">정지해제</button></td>
			      </c:if>
   			      <c:if test='${memberVo.memberState=="정상"}'>
				      <td class="text-nowrap"><button class="btn btn-outline-danger btn-sm"  role="button">정지</button></td>
			      </c:if>
			    </tr>
				</c:forEach>
			  </tbody>
			</table>
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



<div class="modal fade" id="report_modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalScrollableTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title text-danger" id="exampleModalScrollableTitle">게시글 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
      <div class="modal-body report-val">
       <input id="report_comment" type="hidden">
       <input id="report_member" type="hidden">
       <input id="report_no" type="hidden">
       <input id="report_content" type="hidden">
       <input id="report_reason" type="hidden">

       <div class="row">
    		<div class="col-6"><a href="#none">유저 정지</a></div>
    		<div class="input-group mb-3 col-6">
			  <input type="number" min="0" class="form-control" value="0" id="report_day">
			  <div class="input-group-append">
			    <span class="input-group-text" >일</span>
			  </div>
			</div>
       </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary r-c-btn" data-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-danger r-c-btn" data-dismiss="modal" onclick="delete_comment(this)">게시글 삭제</button>
      </div>
    </div>
  </div>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>