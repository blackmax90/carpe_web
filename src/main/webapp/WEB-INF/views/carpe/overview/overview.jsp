<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko"><!-- 사용자 언어에 따라 lang 속성 변경. 예) 한국어: ko, 일본어: ja, 영어: en -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>CARPE</title>
    <link rel="stylesheet" type="text/css" href="/carpe/resources/css/style.css" />
	<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
	<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
	<link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">
</head>
<body>

	<!-- wrap -->
	<div class="wrap overview bg-theme blue">

		<!-- header -->
		<header class="header">
			<a href="/carpe/case.do"><h1 class="logo ir">CARPE</h1></a>
			<h2>Digital Forensic Platform CARPE v1.0 - <strong>디지털 포렌식 통합 플랫폼 CARPE 입니다.</strong></h2>
			<section class="top bg-unit">
				<ul>
					<li><a href="#" class="icon setting"><span class="ir">설정</span></a></li>
					<li><a href="#" class="icon noti new"><span class="ir">알림</span></a></li>
					<li><a href="#" class="icon email new text-ellipsis"><span>koreauniv.dfrc@korea.ac.kr</span></a></li>
					<li><a href="#" class="icon logout"><span>LOGOUT</span></a></li>
				</ul>
			</section>
		</header>
		<!-- // header -->

		<!-- nav -->
		<nav class="nav bg-unit">
			<div class="bg-img-nav">
				<!--//
					목록 추가는 <li> 생성
					1Depth Menu class : 없음
					2Depth Menu class="level02"
					1Depth/2Depth Selected class="on" 
				//-->
				<ul>
					<li class="on"><a href="/carpe/overview.do" class="icon overview">Overview</a></li>
					<li><a href="/carpe/evdnc.do" class="icon evidence">Evidence</a></li>
					<li><a href="#" class="icon analysis">Analysis</a></li>
					<!-- 2Depth Menu //-->
						<li class="level02 hide"><a href="#">Filesystem</a></li> 
						<li class="level02 hide"><a href="#">Artifact</a></li>
					<!--// 2Depth Menu -->
					<li><a href="#" class="icon visualization">Visualization</a></li>
					<li><a href="#" class="icon report">Report</a></li>
				</ul>
			</div>
		</nav>
		<!-- // nav -->

		<!-- main -->
		<main class="main">
			<section class="desc-area bg-unit">
				<h3>Current Case : ${caseName}</h3>
				<p>${desc}</p>
			</section>
			<article class="container">
				<aside class="content-area bg-unit">
					<h3>Current Info</h3>
					<p>Case State : ${procStat}</p>
					<p>Last analysis Time : - </p>
					<p># of Evidence : ${evidenceCnt}</p>
					<p># of members : ${caseUserCnt}</p>
				</aside>
				<div class="content-area bg-unit">					
					<h3>Events</h3>
					<p><fmt:formatNumber value="${logtimelineCnt }"/> 건 발견</p>
					
				</div>
				<div class="content-area bg-unit">
					<h3>Members(${caseUserCnt})</h3>
					<c:forEach items="${caseUserList }" var="userList">
						<p>${userList.user_id }</p>
					</c:forEach>
				</div>
			</article>
		</main>
		<!-- // main -->

	</div>
	<!-- // wrap -->

	<!-- 공통 javascript 영역 -->
	<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
	<script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/common.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
	<!-- // 공통 javascript 영역 -->

	<!-- 현재 페이지에 필요한 js -->
	<!-- <script>
	$(document).ready(function(){
	});
	</script> -->
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>