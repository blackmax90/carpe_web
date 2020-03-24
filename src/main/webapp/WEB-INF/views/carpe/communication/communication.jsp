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
						<li class="level02 on"><a href="/carpe/communication.do">Communication</a></li> 
						<li class="level02"><a href="/carpe/usage.do">Usage history</a></li>
						<li class="level02"><a href="/carpe/gps.do">Location map</a></li>
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
				<h4 class="blind">조회된 컨텐츠</h4>
				<!--// Content 영역 //-->
				<!--// Side 메뉴가 우측에 있는 형태의 jqx-widget //-->
				<div id="jqxSplitter" class="jqx-reset jqx-splitter jqx-widget jqx-widget-content content-box">
					<!-- Table 영역 //-->
					<div class="jqx-widget-content jqx-splitter-panel jqx-reset aside ofy-auto">
						<div id="jqxGrid_Systemlog" class="cont-result"></div>
					</div><!--// Table 영역 -->

					<!-- Chart 영역 //-->
					<div class="jqx-widget-content jqx-splitter-panel jqx-reset content-area">
						
						<div class="btn-area division-line" style="display:">
							<dl>
								<dt>연도선택 :</dt>
								<dd>
									<div class="select">
										<select name="" id="setYear" onChange="setYear(this);">
											<option value="2019">2019</option>
											<option value="2018">2018</option>
											<option value="2017">2017</option>
										</select>
									</div>
								</dd>
							</dl>	
						</div>
						<div class="cont-result">
							<div id="chartdiv01" class="chart-area chart-type-3"></div>							
							<h5>outgoing</h5>						
						</div>
						<div class="cont-result">
							<div id="chartdiv02" class="chart-area chart-type-3"></div>	
							<h5>incoming</h5>				
						</div>
					</div>
					<!--// Chart 영역 -->
					
				</div><!--// content-box -->

			</article>
		</main>
		<!-- // main -->

	</div>
	<!-- // wrap -->
	
	<!-- pop-up // 데이터 선택 시, 대화내용 팝업  // -->
	<div id="" class="pop wrap-pop jqx-window jqx-popup" style="position: absolute; top: 20rem; left: calc(50% - 30rem); width: 80rem; height: auto; display:none;">
		<div id="" class="pop-header jqx-window-header">
			<h1>Communication Data</h1>
			<div class="jqx-window-close-button-background">
				<div class="jqx-window-close-button jqx-icon-close"></div>
			</div>
		</div>
		<div id="" class="pop-content">
			<!-- <article class="container"> -->
				<h4 class="blind">조회된 컨텐츠</h4>
				<!--// Content 영역 //-->
				<div id="jqxSplitter" class="content-box">
					<div class="content-area">
						<div id="jqxGrid_Systemlog2" role="grid" class="cont-result of-auto" style="width: 100%; height: calc(100% - 3rem);">
							<!--// Table Sample - Size Check //-->
							<table class="tbl-grid">
								<thead>
									<tr>
										<th>타입</th>
										<th>시간</th>
										<th>발신</th>
										<th>수신</th>
										<th>내용</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
									<tr>
										<td>문자</td>
										<td>2019-12-13 11:50:12</td>
										<td>유재석</td>
										<td>유산슬</td>
										<td>펭수를 만났습니다.</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div id="paing" class="paging-area">
							<!--// Table Paging 영역 - 위치고정 //-->
							<div class="paginate">
								<button type="button" class="btn-paging icon ico-first"><span class="ir">처음</span></button>
								<button type="button" class="btn-paging icon ico-prev"><span class="ir">이전</span></button>
								<span class="num">
									<a href="#">81</a>
									<a href="#">82</a>
									<a href="#"><strong class="on">83</strong></a>
									<a href="#">84</a>
									<a href="#">85</a>
									<a href="#">86</a>
									<a href="#">87</a>
									<a href="#">88</a>
									<a href="#">89</a>
									<a href="#">90</a>
								</span>
								<button class="btn-paging icon ico-next"><span class="ir">다음</span></button>
								<button class="btn-paging icon ico-last" disabled="disabled"><span class="ir">마지막</span></button>
							</div>
						</div><!--// paging-area -->
					</div><!--// content-area -->
					
				</div><!--// content-box -->
			<!-- </article> -->
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
	
	
	<script src="/carpe/resources/amcharts_4.5.3/amcharts4/core.js"></script>
	<script src="/carpe/resources/amcharts_4.5.3/amcharts4/charts.js"></script>
	<script src="/carpe/resources/amcharts_4.5.3/amcharts4/themes/animated.js"></script>
	<!-- // 공통 javascript 영역 -->

	<!-- 현재 페이지에 필요한 js -->
	<script>

	$(document).ready(function() {
	  $("#btnHide").click(function() {
	    $("#dataLayer").hide();
	  });

	  initGrid();
	  initChart();
	});

	// 년도 변경
	function setYear(val) {
	  location.href = "/carpe/communication.do?year=" + val.value;
	}

	// 좌측 데이터 그리드 초기화
	var initGrid = function() {
	  $("#setYear").val(${year});

	  var source = {
	    datatype: "json",
	    datafields: [
	      { name: 'call_number', type: 'string' },
	      { name: 'cnt', type: 'number' }         
	    ],
	    type : "POST",
	    contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
	    url: "/carpe/communication_list.do?year=" + ${year}
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
	    {text: 'Number', dataField: 'call_number', width: 'auto', cellsalign: 'right', align: 'center'},
	    {text: 'Count', dataField: 'cnt', width: '48px', cellsalign: 'center', align: 'center'},
	  ];

	  $('#jqxGrid_Systemlog').on('bindingcomplete', function(event) {
	    var localizationobj = {};
	    localizationobj.emptydatastring = " ";

	    $("#jqxGrid_Systemlog").jqxGrid('localizestrings', localizationobj);
	  });

	  $("#jqxGrid_Systemlog").on("rowclick", function (event) {
	    var rowIdx = args.rowindex;
	    var rightClick = args.rightclick; 

	    if (rightClick == false) {
	      $("#dataLayer").show();
	    }
	  });

	  $("#jqxGrid_Systemlog").jqxGrid({
	    width: 'calc(100% - 4rem)',
	    height: 'calc(100% - 4rem)',    
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
	};

	var dataList1;
	var dataList2;
	var chart1;
	var chart2;
	var monthInfo1;
	var monthInfo2;
	var colorSet;

	// Chart 초기화
	var initChart = function() {
	  am4core.useTheme(am4themes_animated);
	  am4core.options.commercialLicense = true;

	  colorSet = new am4core.ColorSet();

	  dataList1 = {outgoing: []};
	  dataList2 = {incoming: []};

	  monthInfo1 = {
	    startMonth: 1,
	    endMonth: 12,
	    currentMonth: 10
	  };

	  monthInfo2 = {
	    startMonth: 1,
	    endMonth: 12,
	    currentMonth: 10
	  };

	  getCommList(${year}, chart1, monthInfo1, dataList1, "chartdiv01", 0);
	  getCommList(${year}, chart2, monthInfo2, dataList2, "chartdiv02", 1);
	};

	var getCommList = function(year, chart, monthInfo, dataList, div, type) {
	  var url = "/carpe/communication_call_stat.do";

	  if (type == 1) {
	    url = "/carpe/communication_sms_stat.do";
	  }

	  $.ajax({
	    url: url,
	    dataType: 'json',
	    data: {
	      year : year
	    },
	    async: false,
	    contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
	    success: function(data) {
	      $(data["list"]).each(function(i, list) {
	        var tmpArr = [list["number"], list["m1"], list["m2"], list["m3"], list["m4"] 
	               , list["m5"], list["m6"], list["m7"], list["m8"], list["m9"]
	               , list["m10"], list["m11"], list["m12"]];

	        if (type == 0) {
	          dataList.outgoing.push(tmpArr);
	        } else {
	          dataList.incoming.push(tmpArr);
	        }
	      });

	      makeChart(chart, monthInfo, dataList, div);
	    }
	  });
	};

	var makeChart = function(chart, monthInfo, dataList, div) {
	  chart = am4core.create(div, am4charts.RadarChart);
	  chart.numberFormatter.numberFormat = "#건";
	  chart.hiddenState.properties.opacity = 0;
	
	  chart.startAngle = 270 - 180;
	  chart.endAngle = 270 + 180;
	
	  chart.radius = am4core.percent(60);
	  chart.innerRadius = am4core.percent(40);
	
	  // month label goes in the middle
	  var monthLabel = chart.radarContainer.createChild(am4core.Label);
	  monthLabel.horizontalCenter = "middle";
	  monthLabel.verticalCenter = "middle";
	  monthLabel.fill = am4core.color("#673AB7");
	  monthLabel.fontSize = 30;
	  monthLabel.text = String(monthInfo.currentMonth);
	
	  // zoomout button
	  var zoomOutButton = chart.zoomOutButton;
	  zoomOutButton.dx = 0;
	  zoomOutButton.dy = 0;
	  zoomOutButton.marginBottom = 15;
	  zoomOutButton.parent = chart.rightAxesContainer;
	
	  // scrollbar
	  chart.scrollbarX = new am4core.Scrollbar();
	  chart.scrollbarX.parent = chart.rightAxesContainer;
	  chart.scrollbarX.orientation = "vertical";
	  chart.scrollbarX.align = "center";
	
	  // vertical orientation for zoom out button and scrollbar to be positioned properly
	  chart.rightAxesContainer.layout = "vertical";
	  chart.rightAxesContainer.padding(120, 20, 120, 20);
	
	  // category axis
	  var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
	  categoryAxis.renderer.grid.template.location = 0;
	  categoryAxis.dataFields.category = "country";
	
	  var categoryAxisRenderer = categoryAxis.renderer;
	  var categoryAxisLabel = categoryAxisRenderer.labels.template;

	  categoryAxisLabel.events.on("hit", function(ev) {
	     //console.log("clicked on ", ev.target.currentText);
	     $("#dataLayer").show();
	  }, this);

	  categoryAxisLabel.location = 0.5;
	  categoryAxisLabel.radius = 28;
	  categoryAxisLabel.relativeRotation = 90;
	  categoryAxisLabel.cursorOverStyle = am4core.MouseCursorStyle.pointer;
	
	  categoryAxisRenderer.minGridDistance = 13;
	  categoryAxisRenderer.grid.template.radius = -25;
	  categoryAxisRenderer.grid.template.strokeOpacity = 0.05;
	  categoryAxisRenderer.grid.template.interactionsEnabled = false;
	
	  categoryAxisRenderer.ticks.template.disabled = true;
	  categoryAxisRenderer.axisFills.template.disabled = true;
	  categoryAxisRenderer.line.disabled = true;
	
	  categoryAxisRenderer.tooltipLocation = 0.5;
	  categoryAxis.tooltip.defaultState.properties.opacity = 0;
	
	  // value axis
	  var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
	  valueAxis.min = 0;
	  valueAxis.max = 40;
	  valueAxis.strictMinMax = true;
	  valueAxis.tooltip.defaultState.properties.opacity = 0;
	  valueAxis.tooltip.animationDuration = 0;
	  valueAxis.cursorTooltipEnabled = true;
	  valueAxis.zIndex = 10;
	
	  var valueAxisRenderer = valueAxis.renderer;
	  valueAxisRenderer.axisFills.template.disabled = true;
	  valueAxisRenderer.ticks.template.disabled = true;
	  valueAxisRenderer.minGridDistance = 30;
	  valueAxisRenderer.grid.template.strokeOpacity = 0.05;
	
	
	  // series
	  var series = chart.series.push(new am4charts.RadarColumnSeries());
	  series.columns.template.width = am4core.percent(90);
	  series.columns.template.strokeOpacity = 0;
	  series.dataFields.valueY = "value" + monthInfo.currentMonth;
	  series.dataFields.categoryX = "country";
	  series.tooltipText = "{categoryX}:{valueY.value}";
	
	  // this makes columns to be of a different color, depending on value
	  series.heatRules.push({ target: series.columns.template, property: "fill", minValue: 0, maxValue: 40, min: am4core.color("#673AB7"), max: am4core.color("#F44336"), dataField: "valueY" });
	
	  // cursor
	  var cursor = new am4charts.RadarCursor();
	  chart.cursor = cursor;
	  cursor.behavior = "zoomX";
	
	  cursor.xAxis = categoryAxis;
	  cursor.innerRadius = am4core.percent(40);
	  cursor.lineY.disabled = true;
	
	  cursor.lineX.fillOpacity = 0.2;
	  cursor.lineX.fill = am4core.color("#000000");
	  cursor.lineX.strokeOpacity = 0;
	  cursor.fullWidthLineX = true;
	
	  // month slider
	  var monthSliderContainer = chart.createChild(am4core.Container);
	  monthSliderContainer.layout = "vertical";
	  monthSliderContainer.padding(0, 38, 0, 38);
	  monthSliderContainer.width = am4core.percent(100);
	
	  var monthSlider = monthSliderContainer.createChild(am4core.Slider);
	  monthSlider.events.on("rangechanged", function () {
	      updateRadarData(chart, monthLabel, series, monthInfo, monthInfo.startMonth + Math.round(monthSlider.start * (monthInfo.endMonth - monthInfo.startMonth)));
	  });
	  monthSlider.orientation = "horizontal";
	  monthSlider.start = 0.5;
	
	  var slider = monthSliderContainer.createChild(am4core.Slider);
	  slider.start = 1;
	  slider.exportable = false;
	  slider.events.on("rangechanged", function() {
	    var start = slider.start;
	
	    chart.startAngle = 270 - start * 179 - 1;
	    chart.endAngle = 270 + start * 179 + 1;
	
	    valueAxis.renderer.axisAngle = chart.startAngle;
	  });
	  
	  chart.data = generateRadarData(chart, monthInfo, dataList);
	};

	var updateRadarData = function(chart, label, series, monthInfo, month) {
	  if (monthInfo.currentMonth != month) {
	    monthInfo.currentMonth = month;
	    label.text = String(monthInfo.currentMonth) + '월';
	    series.dataFields.valueY = "value" + monthInfo.currentMonth;
	    chart.invalidateRawData();
	  }
	};

	var generateRadarData = function(chart, monthInfo, dataList) {
	  var data = [];
	  var i = 0;
	  for (var continent in dataList) {
	    var continentData = dataList[continent];
	
	    continentData.forEach(function(country) {
	      var rawDataItem = { "country": country[0] }
	
	      for (var m = 1; m < country.length; m++) {
	        rawDataItem["value" + (monthInfo.startMonth + m - 1)] = country[m];
	      }
	
	      data.push(rawDataItem);
	    });

	    createRange(chart, continent, continentData, i);
	    i++;
	  }

	  return data;
	};
	
	var createRange = function(chart, name, continentData, index) {
	  var categoryAxis = chart.xAxes.getIndex(0);
	  var axisRange = categoryAxis.axisRanges.create();
	  axisRange.axisFill.interactionsEnabled = true;
	  axisRange.text = name;
	  // first country
	  axisRange.category = continentData[0][0];
	  // last country
	  axisRange.endCategory = continentData[continentData.length - 1][0];
	
	  // every 3rd color for a bigger contrast
	  axisRange.axisFill.fill = colorSet.getIndex(index * 3);
	  axisRange.grid.disabled = true;
	  axisRange.label.interactionsEnabled = false;
	
	  var axisFill = axisRange.axisFill;
	  axisFill.innerRadius = -0.001; // almost the same as 100%, we set it in pixels as later we animate this property to some pixel value
	  axisFill.radius = -20; // negative radius means it is calculated from max radius
	  axisFill.disabled = false; // as regular fills are disabled, we need to enable this one
	  axisFill.fillOpacity = 1;
	  axisFill.togglable = true;
	
	  axisFill.showSystemTooltip = true;
	  axisFill.readerTitle = "click to zoom";
	  axisFill.cursorOverStyle = am4core.MouseCursorStyle.pointer;
	
	  axisFill.events.on("hit", function (event) {
	    var dataItem = event.target.dataItem;
	    if (!event.target.isActive) {
	      categoryAxis.zoom({ start: 0, end: 1 });
	    } else {
	      categoryAxis.zoomToCategories(dataItem.category, dataItem.endCategory);
	    }
	  });
	
	  // hover state
	  var hoverState = axisFill.states.create("hover");
	  hoverState.properties.innerRadius = -10;
	  hoverState.properties.radius = -25;
	
	  var axisLabel = axisRange.label;
	  axisLabel.location = 0.5;
	  axisLabel.fill = am4core.color("#ffffff");
	  axisLabel.radius = 0;
	  axisLabel.relativeRotation = 0;
	};
			
	<!-- // 현재 페이지에 필요한 js -->
	</script>

</body>
</html>