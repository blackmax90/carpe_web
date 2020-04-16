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
  <link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">
  <script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
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

      function checkSignupValid() {
        var signupid = $('#signupid').val();

        if (signupid === '') {
          alert("사용자 ID를 입력해주십시오.");
          $('#signupid').focus();
          return false;
        }

        var signupname = $('#signupname').val();

        if (signupname === '') {
          alert("사용자명을 입력해주십시오.");
          $('#signupname').focus();
          return false;
        }

        var signupemail = $('#signupemail').val();

        if (signupemail === '') {
          alert("메일 주소를 입력해주십시오.");
          $('#signupemail').focus();
          return false;
        }
        
        var signuppw = $('#signuppw').val();

        if (signuppw === '') {
          alert("패스워드를 입력해주십시오.");
          $('#signuppw').focus();
          return false;
        }

        if (signuppw.length < 4) {
          alert("패스워드를 4글자 이상 입력해주십시오.");
          $('#signuppw').focus();
          return false;
        }

        var signuppw2 = $('#signuppw2').val();

        if (signuppw != signuppw2) {
          alert("패스워드가 일치하지 않습니다.");
          $('#signuppw2').focus();
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

      $("#signupWindow").jqxWindow({
          width: 460
        , height: 330
        , resizable: false
        , cancelButton: $("#cancel")
        , autoOpen: false
        , resizable: false
        , isModal: true
        , modalOpacity: 0.3
      });

      $("#btnSignup").click(function() {
        $("#signupFrm")[0].reset();
        $("#signupWindow").jqxWindow('open');
      });

      $("#ok").click(function() {
        if (!checkSignupValid()) {
          return;
        }

        var data = {
          userid: $("#signupid").val(),
          name: $("#signupname").val(),
          password: $("#signuppw").val(),
          email: $("#signupemail").val()
        };
        
        $.ajax({
          type: "POST",
          url: "/carpe/signup.do",
          dataType: 'json',
          data: data,
          async: false,
          contentType: "application/x-www-form-urlencoded; charset=UTF-8",
          success: function(rs) {
            var ret = rs.ret;
            var msg = rs.msg;

            if (msg) {
              alert(msg);
            }

            if (ret == 0) {
              $("#signupWindow").jqxWindow('close');
            }
          },
          error: function (jqXHR, textStatus, errorThrown) {
            alert("사용자 등록에 실패하였습니다.");
            console.log(jqXHR.responseText);
          }
        });
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
              <a class="fl" href="#" id="btnSignup">Sign Up</a>
              <a class="fr" href="#">Forgot ID/PW</a>
            </div>
          </form>
        </section>
      </div>
    </main>
    <!-- // main -->
  </div>

  <div id="signupWindow" class="pop wrap-pop">
    <div id="signupWindowHeader" class="pop-header" >
      <h1>Sign Up</h1>
    </div>
    <div id="signupWindowContent" class="pop-content">
      <form id="signupFrm" name="signupFrm" action="" method="post" autocomplete="off" enctype="multipart/form-data">
        <div class="data-type-1">
          <dl>
            <dt>User ID :</dt>
            <dd>
              <div class="input-text input-text-type-1">
                <input type="text" name="signupid" id="signupid" placeholder="ID" >
              </div>
            </dd>
          </dl>
          <dl>
            <dt>Name :</dt>
            <dd>
              <div class="input-text input-text-type-1">
                <input type="text" name="signupname" id="signupname" placeholder="NAME" />
              </div>
            </dd>
          </dl>
          <dl>
            <dt>E-Mail :</dt>
            <dd>
              <div class="input-text input-text-type-1">
                <input type="text" name="signupemail" id="signupemail" placeholder="E-MAIL" />
              </div>
            </dd>
          </dl>
          <dl>
            <dt>Password :</dt>
            <dd>
              <div class="input-text input-text-type-1">
                <input type="password" name="signuppw" id="signuppw" autocomplete="new-password" placeholder="PASSWORD" />
              </div>
            </dd>
          </dl>
          <dl>
            <dt>Confirm Password :</dt>
            <dd>
              <div class="input-text input-text-type-1">
                <input type="password" name="signuppw2" id="signuppw2" autocomplete="new-password" placeholder="CONFIRM PASSWORD" />
              </div>
            </dd>
          </dl>
        </div>
        <div class="btn-area">
          <ul>
            <li><button type="button" class="btn-case-01 bk" id="cancel" value="Cancel" >Cancel</button></li>
            <li><button type="button" class="btn-case-01" id="ok" value="OK">OK</button></li>
          </ul>
        </div>
      </form>
    </div>
  </div>
</body>
</html>