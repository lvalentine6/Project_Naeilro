<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정지 페이지</title>
<style>
	.swal-wide{
		width:600px !important;
	}
</style>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
// 작성자 : 이승로

	//정지회원 알림 메시지
	var reason1 = '${reason}';
	var message = '${msg}';
	var blockEndDate1 = '${blockEndDate}';
	var url1 = '${url}';
	
$().ready(function () {	
                Swal.fire({
                	 icon: 'error',
                	 title: message,
                     html: '정지 종료 일자 : ' + blockEndDate1 +
                     ' <br>정지 사유 : ' + reason1,
                     customClass: 'swal-wide'
                }).then(function() {
                	location.href = url1;
				});
        });
	
// 	alert(message + "\n정지 종료 일자 : " + blockEndDate1 + "\n정지 사유 : " + reason1);
// 	location.href = url1;
</script>    