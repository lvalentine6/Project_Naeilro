<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <div>
<h1>회원가입 페이지</h1>
    </div>

<form action="join" method="post">
		<div class="row text-left">
			<label>아이디</label>
			<input type="text" name="memberId" required class="form-input form-input-underline"
						>
		</div>
		<div class="row text-left">
			<label>비밀번호</label>
			<input type="password" name="memberPw" required class="form-input form-input-underline"
						>
		</div>
		<div class="row text-left">
			<label>비밀번호 재확인</label>
			<input type="password" class="form-input form-input-underline"
						>
		</div>
		<div class="row text-left">
			<label>닉네임</label>
			<input type="text" name="memberNick" required class="form-input form-input-underline"
						>
		</div>
		<div class="row text-left">
			<label>이메일</label>
			<input type="text" name="memberEmail" class="form-input form-input-underline">
		</div>
		<div class="row text-left">
			<label>이름</label>
			<input type="text" name="memberName" required class="form-input form-input-underline"
						>
		</div>
		<div class="row text-left">
			<label>생년월일</label>
			<input type="date" name="memberBirth" required class="form-input form-input-underline">
		</div>
		<div class="row text-left">
			<label>성별</label>
			<input type="text" name="memberGender" required class="form-input form-input-underline">
		</div>
		<div class="row text-left">
			<label>프로필 이미지</label>
			<input type="text" name="member_profile_path" required class="form-input form-input-underline">
		</div>
		<div class="row">
			<input type="submit" value="가입" class="form-btn form-btn-positive">
		</div>
	</form>
</div>