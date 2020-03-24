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
    <link rel="stylesheet" type="text/css" href="/carpe/resources/css/style.css" />
	<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
	<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
	<link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">
	
	<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
	<script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/common.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
  <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${ncpClientId}"></script>
	<script type="text/javascript" src="/carpe/resources/naverapi/marker-clustering/src/MarkerClustering.js"></script>
  
</head>
<body>

	<!-- wrap -->
	<div class="wrap vsa-page bg-theme blue">

		<!-- header -->
		<%@ include file="../common/header.jsp" %>
		<!-- // header -->

		<!-- nav -->
		<nav class="nav bg-unit">
			<div class="bg-img-nav">
				<!--//
					목록 추가는 <li> 생성
					1Depth Menu class : 없음
					2Depth Menu class="level02"
					1Depth/2Depth Selected class="on"
					2Depth Menu Class : 1Depth Menu = unselected 상태일 경우에는 class="hide" // 2019-10-20 추가
				//-->
				<ul>
					<li><a href="/carpe/overview.do" class="icon overview">Overview</a></li>
					<li><a href="/carpe/evdnc.do" class="icon evidence">Evidence</a></li>
					<li><a href="#" class="icon analysis">Analysis</a></li>
						<!-- 2Depth Menu //-->
						<li class="level02 hide"><a href="#">Filesystem</a></li> 
						<li class="level02 hide"><a href="#">Artifact</a></li>
						<li class="level02 hide"><a href="#">String Search</a></li>
						<!--// 2Depth Menu -->
					<li><a href="/carpe/carving.do" class="icon recovery">Recovery</a></li>
					<li class="on"><a href="/carpe/communication.do" class="icon visualization">Visualization</a></li>					
						<!-- 2Depth Menu //-->
						<li class="level02"><a href="/carpe/timeline_chart.do">Timeline</a></li>
						<li class="level02"><a href="/carpe/communication.do">Communication</a></li> 
						<li class="level02"><a href="/carpe/usage.do">Usage history</a></li>
						<li class="level02 on"><a href="/carpe/gps.do">Location map</a></li>
						<!--// 2Depth Menu -->
					<li><a href="#" class="icon report">Report</a></li>
				</ul>
			</div>
		</nav>
		<!-- // nav -->

		<!-- main -->
		<main class="main">
			<section class="tit-area">
				<h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
				<a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
			</section>

			<article class="container">
				<h4 class="blind">행위 갯수</h4>
				<!--// Content 영역 //-->
				<!--// Side 메뉴가 우측에 있는 형태의 jqx-widget //-->
				<div class="content-box">
					<div class="content-area">
						<div class="map-area" id="map"><!-- 지도 영역 //-->
							<!-- <a href="#" class="btn map-pin ir">위치1</a>
							<div class="map-func-btns">
								<button type="button" class="btn plus ir">지도 확대</button>
								<button type="button" class="btn minus ir">지도 축소</button>
							</div> -->
						</div>

						
						<!--// Table Sample - Size Check //-->
						<div id="jqxGrid_Systemlog" class="data-tbl-area">

						</div><!-- // pop-content end -->
					</div>
					<!--// Chart 영역 -->
					
				</div><!--// content-box -->

			</article>
		</main>
		<!-- // main -->

	</div>
	<!-- // wrap -->

	<!-- pop-up //-->
	<div id="mapInfo" class="pop wrap-pop" style="position: absolute; top: 16rem; left: calc(50% - 10rem); width: 40rem; height: 24rem; display:none;">
		<div id="" class="pop-header jqx-window-header">
			<h1>지도 정보</h1>
			<div class="jqx-window-close-button-background">
				<div id="hideInfo" class="jqx-window-close-button jqx-icon-close"></div>
			</div>
		</div>
		<div id="" class="pop-content">
			<div class="data-type-2">
				<dl>
					<dt>시간</dt>
					<dd id="infoTime"></dd>
				</dl>
				<dl>
					<dt>소스</dt>
					<dd id="infoSource"></dd>
				</dl>
				<dl>
					<dt>장소</dt>
					<dd id="infoLocation"></dd>
				</dl>
			</div>
		</div><!-- // pop-content end -->
	</div><!-- // pop-up end -->
	
	
	<!-- pop-up // 대화목록 팝업  // -->
	<div id="" class="pop chatroom wrap-pop jqx-window jqx-popup" style="position: absolute; top: 50%; left: 50%; margin-top:-32rem; margin-left:-32rem; width: 40rem;">
		<div id="" class="pop-header jqx-window-header">
			<h1>Communication Data</h1>
			<div class="jqx-window-close-button-background">
				<div class="jqx-window-close-button jqx-icon-close"></div>
			</div>
		</div>
		<div id="" class="pop-content">		
			<h4 class="blind">대화 목록</h4>
			<!--// Content 영역 //-->
			<section class="search-date">
				<div class="combo">
					<span class="input-text-type-1 calendar"><input type="text" id="" placeholder="2020-01-01"/></span>
					<span class="hyp">-</span>
					<span class="input-text-type-1 calendar"><input type="text" id="" placeholder="2020-02-29"/></span>
				</div>
				<div class="btn-area">
					<button type="button" class="btn-case-01 btn-search txt" id=""><span class="icon ico-search">검색</span></button>
				</div>
			</section>
			<section class="chat-list mt20">
				<ul class="list_v list_cont_wrap">				
					<li class="empty-data">
						<p>해당 기간 조회된 내용이 없습니다.</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="카카오톡" class="cr-name text-ellipsis">카카오톡</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="이번에도 좋은 기능 왕창 안고 찾아온 8.7.7 버전 업데이트 안내">이번에도 좋은 기능 왕창 안고 찾아온 8.7.7 버전 업데이트 안내</p>
					</li>
					<li class="on">
						<div class="cr-info">
							<h6 title="유르페우스,유산슬" class="cr-name text-ellipsis">유르페우스,유산슬</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="마스크 없어- 나가면 안돼~ 마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~">
							마스크 없어- 나가면 안돼~ 마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~
						</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="eh,노민혁,광훈,M,강욱,최재영,미미/29/여,박슬기,이진희,TAK,ㄱ김경숙 구원의주님(Dearro9),은지,류양환,𝓑𝓮𝓵𝓵𝓪,Human,지모,김보라,정배,상준님" class="cr-name text-ellipsis">eh,노민혁,광훈,M,강욱,최재영,미미/29/여,박슬기,이진희,TAK,ㄱ김경숙
									구원의주님(Dearro9),은지,류양환,𝓑𝓮𝓵𝓵𝓪,Human,지모,김보라,정배,상준님</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="네, 저는 샀어요">네, 저는 샀어요</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="(이름없음)" class="cr-name text-ellipsis">(이름없음)</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="번호 드렸습니다">번호 드렸습니다</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="플러스친구" class="cr-name text-ellipsis">플러스친구</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="무료로 만들어 새로운 비즈니스 홈을 경험하세요!">무료로 만들어 새로운 비즈니스 홈을 경험하세요!</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="카카오톡" class="cr-name text-ellipsis">카카오톡</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="이번에도 좋은 기능 왕창 안고 찾아온 8.7.7 버전 업데이트 안내">이번에도 좋은 기능 왕창 안고 찾아온 8.7.7 버전 업데이트 안내</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="한별,병수,문형진,한현욱,혜린,김준석,영이,상준,JK,조순익,승희,백승진,고여은,임현,김남준,문각,박연주,박서희,숨,이정근,예진,Youdaehyun,이민욱,태횽,수,송지현,횬디,유민혁,EJ,송영윤,소명 So Myeong Choe,류재욱,동석,정규현,ㅅㅎ,Lucy, 아름,유아름,윤태림,최낙윤,상표,세웅,미현,ㅅㄹ,길은정,신민해,송,남규,민우,지선,Kevin,지우,강정훈,장미연,규,박헌경,DALE,이병완,😄,박찬혁,최신애,최민정,빽,박한민,dain⭐️,소영,채영,배재석,임소정,kim,이승민,지윤,이태헌,이다경,Jay,이아름,Minjoo,형진,김기태,황태현,L,이주희,정하민,Julie 짜요닝,김정호,전다훈,정지호,정승윤,joanne,🌟ㅎ으니,윤,이정욱,김은주,신건하,star,민수,권지연,우상현,션 킴,이진희,민정,이창용,배민구,정예인,Yoon,히지,김우찬(달타냥),재원♡,박찬곤,우병준,박지호,윤덕,전지혜Gia,오렌지라이프 이은총부지점장,김지언,김성현  SUNG HYUN KIM,다혜,^^,도윤,⚡,나르미"
								class="cr-name text-ellipsis">한별,병수,문형진,한현욱,혜린,김준석,영이,상준,JK,조순익,승희,백승진,고여은,임현,김남준,문각,박연주,박서희,숨,이정근,예진,Youdaehyun,이민욱,태횽,수,송지현,횬디,유민혁,EJ,송영윤,소명
								So Myeong Choe,류재욱,동석,정규현,ㅅㅎ,Lucy,
								아름,유아름,윤태림,최낙윤,상표,세웅,미현,ㅅㄹ,길은정,신민해,송,남규,민우,지선,Kevin,지우,강정훈,장미연,규,박헌경,DALE,이병완,😄,박찬혁,최신애,최민정,빽,박한민,dain⭐️,소영,채영,배재석,임소정,kim,이승민,지윤,이태헌,이다경,Jay,이아름,Minjoo,형진,김기태,황태현,L,이주희,정하민,Julie
								짜요닝,김정호,전다훈,정지호,정승윤,joanne,🌟ㅎ으니,윤,이정욱,김은주,신건하,star,민수,권지연,우상현,션
								킴,이진희,민정,이창용,배민구,정예인,Yoon,히지,김우찬(달타냥),재원♡,박찬곤,우병준,박지호,윤덕,전지혜Gia,오렌지라이프
								이은총부지점장,김지언,김성현 SUNG HYUN KIM,다혜,^^,도윤,⚡,나르미</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="저번에 여행일정 맞추느라 같이 만났어요.">저번에 여행일정 맞추느라 같이 만났어요.</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="eh,노민혁,광훈,M,강욱,최재영,미미/29/여,박슬기,이진희,TAK,ㄱ김경숙 구원의주님(Dearro9),은지,류양환,𝓑𝓮𝓵𝓵𝓪,Human,지모,김보라,정배,상준님" class="cr-name text-ellipsis">eh,노민혁,광훈,M,강욱,최재영,미미/29/여,박슬기,이진희,TAK,ㄱ김경숙
									구원의주님(Dearro9),은지,류양환,𝓑𝓮𝓵𝓵𝓪,Human,지모,김보라,정배,상준님</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="네, 저는 샀어요">네, 저는 샀어요</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="(이름없음)" class="cr-name text-ellipsis">(이름없음)</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="번호 드렸습니다">번호 드렸습니다</p>
					</li>
					<li>
						<div class="cr-info">
							<h6 title="플러스친구" class="cr-name text-ellipsis">플러스친구</h6>
							<time class="cr-date" datetime="2020-03-23T14:51:56+09:00">2020-03-23</time>
						</div>
						<p class="chat-data text-ellipsis" title="무료로 만들어 새로운 비즈니스 홈을 경험하세요!">무료로 만들어 새로운 비즈니스 홈을 경험하세요!</p>
					</li>
				</ul>
			</section>
			<!--// content-box -->			
		</div><!-- // pop-content end -->
	</div><!-- // pop-up end -->
	
	<!-- pop-up // 데이터 선택 시, 대화내용 팝업  // -->
	<div id="dataLayer" class="pop msg wrap-pop jqx-window jqx-popup" style="position: absolute;top: 50%; left: 50%; margin-top:-32rem; margin-left:12rem; width: 40rem; display:none;">
		<div id="" class="pop-header jqx-window-header">
			<h1>Communication Data</h1>
			<div class="btn-area">
				<button type="button" class="btn-case-01" id=""><span class="icon ico-export">Export</span></button>
			</div>
			<div class="jqx-window-close-button-background">
				<div class="jqx-window-close-button jqx-icon-close"></div>
			</div>
		</div>
		<div id="" class="pop-content">		
			<h4 class="blind">조회된 컨텐츠</h4>
			<!--// Content 영역 //-->
			<div class="chatLog">
				<section class="day-wrap">
					<h5>- 2020년 03월 09일 -</h5>
					<div class="data_log other">
						<div class="name">유르페우스</div>
						<div class="log">
							<span>주말에 뭐했니?</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log">
						<div class="name">유재석</div>
						<div class="log">
							<span>집에 있었지- 왜?</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log other">
						<div class="name">유산슬</div>
						<div class="log">
							<span>마스크 없어- 나가면 안돼~</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log other">
						<div class="name">유르페우스</div>
						<div class="log">
							<span>주말에 뭐했니?</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log">
						<div class="name">유재석</div>
						<div class="log">
							<span>집에 있었지- 왜?</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log other">
						<div class="name">유산슬</div>
						<div class="log">
							<span>마스크 없어- 나가면 안돼~ 마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
				</section>
				<section class="day-wrap">
					<h5>- 2020년 03월 23일 -</h5>
					<div class="data_log other">
						<div class="name">유르페우스</div>
						<div class="log">
							<span>주말에 뭐했니?</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log">
						<div class="name">유재석</div>
						<div class="log">
							<span>집에 있었지- 왜?</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log other">
						<div class="name">유산슬</div>
						<div class="log">
							<span>마스크 없어- 나가면 안돼~</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log other">
						<div class="name">유르페우스</div>
						<div class="log">
							<span>주말에 뭐했니?</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log">
						<div class="name">유재석</div>
						<div class="log">
							<span>집에 있었지- 왜?</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
					<div class="data_log other">
						<div class="name">유산슬</div>
						<div class="log">
							<span>마스크 없어- 나가면 안돼~ 마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~마스크 없어- 나가면 안돼~</span>
							<time datetime="2019-04-19T14:51:56+09:00">14:51</time>
						</div>
					</div>
				</section>
			</div><!--// content-box -->			
		</div><!-- // pop-content end -->
	</div><!-- // pop-up end -->
	
	
	<!-- 현재 페이지에 필요한 js -->
	<script>
	(function($) {
		var map = null;
		var polyLine = null;

		$(document).ready(function() {
			init();

	    $('#hideInfo').click(function(){
	    	$("#mapInfo").hide();	
	    });
		});

		var init = function() {
			//지도 api 객체 생성
			map = new naver.maps.Map('map', {
			  center: new naver.maps.LatLng(37.5642135, 127.0016985),
			  zoom: 11
			});

			//PolyLine 객체
			polyLine = new naver.maps.Polyline({
				map: map,
		    strokeWeight: 3, //두께
		    strokeColor: '#db4040', //색
		    strokeOpacity: 0.7, //불투명도
		    strokeStyle: "solid",
		    startIcon: naver.maps.PointingIcon.CIRCLE,
		    endIcon: naver.maps.PointingIcon.BLOCK_ARROW
			});

			//마커 생성
		  $.get("/carpe/gps_list.do", function(data) {
		    // 데이터에서 좌표 값을 가지고 마커를 표시합니다
		    // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
		    var markers = $(data.list).map(function(i, position) {
		      var marker = new naver.maps.Marker({
		        position : new naver.maps.LatLng(position.latitude, position.longitude),
		        title : position.source,
		        clickable: true 
		      });

		      naver.maps.Event.addListener(marker, 'click', function() {
		    		viewMapInfo(position.location, position.regd, position.source);
		      });

				  return marker;
		    });

		    var htmlMarker1 = {
		      content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-1.png);background-size:contain;"></div>',
		      size: N.Size(40, 40),
		      anchor: N.Point(20, 20)
		    },
		    htmlMarker2 = {
		      content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-2.png);background-size:contain;"></div>',
		      size: N.Size(40, 40),
		      anchor: N.Point(20, 20)
		    },
		    htmlMarker3 = {
		      content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-3.png);background-size:contain;"></div>',
		      size: N.Size(40, 40),
		      anchor: N.Point(20, 20)
		    },
		    htmlMarker4 = {
		      content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-4.png);background-size:contain;"></div>',
		      size: N.Size(40, 40),
		      anchor: N.Point(20, 20)
		    },
		    htmlMarker5 = {
		      content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-5.png);background-size:contain;"></div>',
		      size: N.Size(40, 40),
		      anchor: N.Point(20, 20)
		    };
		    
		    // 클러스터러에 마커들을 추가
	      var clusterer = new MarkerClustering({
	        minClusterSize: 2,
	        maxZoom: 15,
	        map: map,
	        markers: markers,
	        disableClickZoom: false,
	        gridSize: 120,
	        icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
	        indexGenerator: [5, 10, 15, 20, 25],
	        stylingFunction: function(clusterMarker, count) {
	          $(clusterMarker.getElement()).find('div:first-child').text(count);
	        }
	      });
		  });
		};

    // map marker click event
		var viewMapInfo = function(location, regd, source) {
	   	getLinkList(regd);
	   	$("#infoTime").html(regd);
	   	$("#infoLocation").html(location);
	   	$("#infoSource").html(source);
	    $("#mapInfo").show();
		};

		var getLinkList = function(regdate) {
		  $.ajax({
			  url: "/carpe/gps_link_list.do",
		    dataType:'json',
		    data: { regdate : regdate},
		    async: false,
		    contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
		    success: function(data) {
		      var linePath = [];

		      $(data.list).each(function(i, list) {
		    	  linePath[i] = new naver.maps.LatLng(list.latitude, list.longitude);
		      });

		      console.log(linePath.length);
		   	
			    polyLine.setPath(linePath);
		    }
		  });
		};

		//Grid
		var source = {
      datatype: "json",
      datafields: [
        { name: 'serial_number', type: 'number' },
        { name: 'regd', type: 'string' },
        //{ name: 'gps_type', type: 'string' },
        { name: 'source', type: 'string' },
        { name: 'location', type: 'string' },
        { name: 'latitude', type: 'string' },
        { name: 'longitude', type: 'string' }
      ],
      type : "POST",
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      url: "/carpe/gps_list.do"
    };
		
		var dataAdapter = new $.jqx.dataAdapter(source, {
			contentType : 'application/json; charset=utf-8',
			formatData : function(data) {
		    return data;
			},
			beforeSend : function(xhr) {
			},
			downloadComplete : function(data, status, xhr) {
			},
			loadComplete : function(data) {
			},
			loadError : function(xhr, status, error) {
			}
		});

		var columnSet = [
			{text: 'No.', dataField: 'serial_number', width: '6%', cellsalign: 'right', align: 'center'},
			{text: 'Time', dataField: 'regd', width: '10%', cellsalign: 'right', align: 'center'},
			//{text: 'Type', dataField: 'gps_type', width: '18%', cellsalign: 'center', align: 'center'},
			{text: 'Source', dataField: 'source', width: '10%', cellsalign: 'center', align: 'center'},
			{text: 'Location', dataField: 'location', width: 'auto', cellsalign: 'center', align: 'center'},
			{text: 'Latitude', dataField: 'latitude', width: '10%', cellsalign: 'center', align: 'center'},
			{text: 'Longitude', dataField: 'longitude', width: '10%', cellsalign: 'center', align: 'center'}
		];
	
		$('#jqxGrid_Systemlog').on('bindingcomplete', function(event) {
			var localizationobj = {};
			localizationobj.emptydatastring = " ";
	
			$("#jqxGrid_Systemlog").jqxGrid('localizestrings', localizationobj);
		});
	
		$("#jqxGrid_Systemlog").jqxGrid({
			width: '100%',		
			height: '40%',
			source: dataAdapter,
			pagerheight: 0,
			altrows: true,
			scrollbarsize: 12,
			autoshowloadelement: true,
			ready: function() {},
			enablebrowserselection: true,
			columnsresize: true,
			filterable: true,
			sortable: true,
			sortMode: 'many',
			columnsheight: 40,
			columns: columnSet
		});
	})(jQuery);
	
	</script>

</body>
</html>