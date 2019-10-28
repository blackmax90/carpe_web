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
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dd678d53931c05d004c6fbd2d20de9ca&libraries=services,clusterer,drawing"></script>
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
						<li class="level02 hide"><a href="#">검색</a></li>
						<!--// 2Depth Menu -->
					<li class="on"><a href="/carpe/communication.do" class="icon visualization">Visualization</a></li>					
						<!-- 2Depth Menu //-->
						<li class="level02"><a href="/carpe/communication.do">Communication<br/>model</a></li> 
						<li class="level02"><a href="#">Usage model</a></li>
						<li class="level02 on"><a href="/carpe/gps.do">GPS model</a></li>
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
							<a href="#" class="btn map-pin ir">위치1</a>
							<div class="map-func-btns">
								<button type="button" class="btn plus ir">지도 확대</button>
								<button type="button" class="btn minus ir">지도 축소</button>
							</div>
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

	<!-- 현재 페이지에 필요한 js -->
	<script>
	(function($) {
		$(document).ready(function() {
		    var map = new kakao.maps.Map(document.getElementById('map'), { // 지도를 표시할 div
		    	center: new kakao.maps.LatLng(37.5818014673445, 127.025512978435), // 지도의 중심좌표 
		        level : 8 // 지도의 확대 레벨 
		    });
		    
		    $('#hideInfo').click(function(){
		    	$("#mapInfo").hide();	
		    });
		    
		    // 마커 클러스터러를 생성합니다 
		    var clusterer = new kakao.maps.MarkerClusterer({
		        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		        minLevel: 4 // 클러스터 할 최소 지도 레벨 
		    });
			
		    $.get("/carpe/gps_list.do", function(data) {
		        // 데이터에서 좌표 값을 가지고 마커를 표시합니다
		        // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
		        var markers = $(data.list).map(function(i, position) {
		        	var marker = new kakao.maps.Marker({
		                position : new kakao.maps.LatLng(position.latitude, position.longitude),
		            	title : position.source,
		            	clickable: true 
		            });
		        	
		        	kakao.maps.event.addListener(marker, 'click', function() {
		        		viewMapInfo(position.location, position.regdate, position.source);
		            });
					return marker;
		        });
		        
		        // 클러스터러에 마커들을 추가합니다
		        clusterer.addMarkers(markers);
		    });
		    
		    // map marker click event
			var viewMapInfo = function(location, regdate, source) {
		    	$("#infoTime").html(regdate);
		    	$("#infoLocation").html(location);
		    	$("#infoSource").html(source);
				$("#mapInfo").show();
			}
		    
			var source = {
				datatype: "json",
				datafields: [
					{ name: 'serial_number', type: 'number' },
					{ name: 'regdate', type: 'string' },
					{ name: 'gps_type', type: 'string' },
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
				{text: 'Time', dataField: 'regdate', width: '10%', cellsalign: 'right', align: 'center'},
				{text: 'Type', dataField: 'gps_type', width: '18%', cellsalign: 'center', align: 'center'},
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
		});
	})(jQuery);
	
	</script>

</body>
</html>