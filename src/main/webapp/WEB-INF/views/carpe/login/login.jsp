<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko"><!-- 사용자 언어에 따라 lang 속성 변경. 예) 한국어: ko, 일본어: ja, 영어: en -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>CARPE</title>
	<link href="/carpe/resources/css/style.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
	<script>
	(function($) {
		$(document).ready(function() {
		    var errmsg='${errmsg}';
		    
		    if(errmsg!='') {
		    	alert(errmsg);
		    }
		    
			function checkValid() {
				var userId, userPasswd;
				userId = $('#userId').val();
				if (userId === '') {
					alert("사용자 ID를 입력해주십시오.");
					$('#userId').focus();
					return false;
				}
				
				userPasswd = $('#userPassword').val();
				if (userPasswd === '') {
					alert("패스워드를 입력해주십시오.");
					$('#userPasswd').focus();
					return false;
				}
				
				return true;
			}
			
		    $('#userId').keypress(function(e) {
				e = e || window.event;
		    	if (e.which == 13) {
					$('#userPassword').focus();
				}
			});
	
			$('#userPassword').keypress(function(e) {
				e = e || window.event;
				if (e.which == 13) {
					if (!checkValid()) {
						return false;
					} else {
						document.getElementById('loginForm').submit();
					}
				}
			});
	
			$('#loginBtn').click(function(e){
				if (!checkValid()) {
					return false;
				} else {
					document.getElementById('loginForm').submit();
				}
			});
		});
	})(jQuery);
	
	</script>	
</head>
<body>
	<!-- wrap -->
	<div class="wrap bg-theme blue login">
		<!-- main -->
		<main class="main">
			<div class="box-login">
				<section class="login_cont bg-unit">
					<h1 class="logo ir">CARPE</h1>
					<form id="loginForm" name="loginForm" action="/carpe/login.do" method="post">
						<div class="input-text input-text-type-2">							
							<input type="text" name="userId" placeholder="ID" id="userId">
						</div>
						<div class="input-text input-text-type-2">
							<input type="password" name="userPassword" placeholder="PASSWORD" id="userPassword">
						</div>
						
						<button type="button" class="btn-block btn-login" id="loginBtn">
							<span class="icon lock">Login</span>							
						</button>

						<div class="module-text-link">
							<a class="fl" href="#">Sign Up</a>
							<a class="fr" href="#">Forgot ID/PW</a>
						</div>
					</form>
				</section>
			</div>
		</main>
		<!-- // main -->
	</div>
</body>
</html>