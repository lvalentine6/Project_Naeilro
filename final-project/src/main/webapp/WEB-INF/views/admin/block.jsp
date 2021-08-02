<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정지 페이지</title>

<script>
	//정지회원 알림 메시지
	var reason1 = '${reason}';
	var message = '${msg}';
	var blockEndDate1 = '${blockEndDate}';
	var url1 = '${url}';
	
	alert(message + "\n정지 종료 일자 : " + blockEndDate1 + "\n정지 사유 : " + reason1);
	document.location.href = url1;
</script>    