<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko"><!-- 사용자 언어에 따라 lang 속성 변경. 예) 한국어: ko, 일본어: ja, 영어: en -->
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  <meta http-equiv="Content-Style-Type" content="text/css" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <title>CARPE</title>
  <link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" type="text/css" href="/carpe/resources/css/style.css" />
  <script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
  <script>
  $(document).ready(function() {
    if ($("#fileType").val() == "1") {
      $("#image").attr("src", "/carpe/get_image_preview.do?id=${id}&seq=${seq}")
    } else if ($("#fileType").val() == "2") {
      $("#video").attr("src", "/carpe/get_video_preview.do?id=${id}&seq=${seq}");
    }
  });
  </script>
</head>
<body>
  <div style="text-align: center">
  <input type="hidden" id="fileType" value="${fileType}">
  <c:if test="${fileType == 1}">
    <img id="image" src=""/>  
  </c:if>
  <c:if test="${fileType == 2}">
    <video id="video" width="100%" height="100%" controls autoplay src=""></video>
  </c:if>
  </div>
</body>
</html>