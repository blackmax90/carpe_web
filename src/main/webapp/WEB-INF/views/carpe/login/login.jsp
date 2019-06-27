<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="/carpe/resources/css/com.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
<title>CARPE 로그인</title>
</head>

<body class="defaulLogin">
<div id="defaulWrap">
	<div class="login">
		<h1><img src="/carpe/resources/images/LoginLogo.png" alt="CARPE"/></h1>
		<form class="login_box" id="loginForm" name="loginForm" action="/carpe/login.do" method="post">
			<div class="input">
				<label for="id">ID</label>
				<input type="text" name="userId" id="userId">
			</div>
			<div class="input">
				<label for="password">PW</label>
				<input type="password" name="userPassword" id="userPassword">
			</div>
			<div class="register clear">
				<a href="#none" class="fl">Register</a>
				<a href="#none" class="fr">Forgot password?</a>
			</div>
			<button type="button" class="loginBtn"><img src="/carpe/resources/images/iconLock.png" alt="Login"/></button>
		</form>
	</div>
</div>

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

		$('.loginBtn').click(function(e){
			if (!checkValid()) {
				return false;
			} else {
				document.getElementById('loginForm').submit();
			}
		});
	});
})(jQuery);

</script>

</body>
</html>
