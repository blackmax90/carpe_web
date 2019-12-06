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
						<li class="level02 hide"><a href="#">검색</a></li>
						<!--// 2Depth Menu -->
					<li><a href="/carpe/carving.do" class="icon recovery">Recovery</a></li>	
					<li class="on"><a href="/carpe/communication.do" class="icon visualization">Visualization</a></li>						
						<!-- 2Depth Menu //-->
						<li class="level02"><a href="/carpe/communication.do">Communication<br/>model</a></li> 
						<li class="level02 on"><a href="/carpe/usage.do">Usage model</a></li>
						<li class="level02"><a href="/carpe/gps.do">GPS model</a></li>
						<li class="level02"><a href="/carpe/timeline_chart.do">Timeline</a></li>
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
						<div id="chartdiv" class="chart-area chart-type-1">
							<!-- Chart 영역 //-->
						</div>
					</div>
					<!--// Chart 영역 -->
					
				</div><!--// content-box -->

			</article>
		</main>
		<!-- // main -->

	</div>
	<!-- // wrap -->


	<!-- pop-up //-->
	<div id="" class="pop wrap-pop jqx-window jqx-popup ofy-auto" style="position: absolute; top: calc(50% - 30rem); left: calc(50% - 30rem); width: 60rem; height: 60rem; display:none;">
		<div id="" class="pop-header jqx-window-header">
			<h1>선택 건수 정보</h1>
			<div class="jqx-window-close-button-background">
				<div class="jqx-window-close-button jqx-icon-close"></div>
			</div>
		</div>
		<div id="" class="pop-content">
			<!--// Table Sample - Size Check //-->
			<table class="tbl-grid tbl-data-check">
				<colgroup>
					<col width="24%"/>
					<col width="18%"/>
					<col width="18%"/>
					<col width="*"/>
				</colgroup>
				<thead>
					<tr>
						<th>생성 시간 (UTC+9)</th>
						<th>증거 유형 (설명)</th>
						<th>아티팩트 유형</th>
						<th>주요 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="bg-point-1">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-1">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-2">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-2">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-2">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
					<tr>
						<td class="bg-point-3">2016/11/09 08:25:36</td>
						<td>시스템시작</td>
						<td>Event Log</td>
						<td class="left">Test Test Test</td>
					</tr>
				</tbody>
			</table>
		</div><!-- // pop-content end -->
	</div><!-- // pop-up end -->

	<!-- 공통 javascript 영역 -->
	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<!-- // 공통 javascript 영역 -->

	<!-- 현재 페이지에 필요한 js -->
	<script>
	
		var getUsageDayList = function(year, month, day) {
			$.ajax({
				url: "/carpe/usage_day_list.do",
		        dataType:'json',
		        data: { year : year
		        	   ,month : month
		        	   ,day : day
		        	  },
		        async:false,
		        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
		        success:function(data){
		        	console.log(data);
		        	dataList = new Array();
		        	$(data["list"]).each(function(i, list) {
		        		 var tmpArr = {}
		        		 tmpArr.year = list["hour"];
		        		 tmpArr.income = list["act"];
		        		 if (list["hour"] == "18") {
		        			 tmpArr.lineColor = 'red';
		        		 }
		        		 dataList.push(tmpArr);
		            });
		        }
		    })
		    return dataList;
		}
		
		//dataList = getUsageDayList(${year}, ${month}, ${day});
		dataList = getUsageDayList('2019', '1', '1');
		console.log(dataList);
		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		var chart = am4core.create("chartdiv", am4charts.XYChart);

		chart.data = dataList;

		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.renderer.ticks.template.disabled = true;
		categoryAxis.renderer.line.opacity = 0;
		categoryAxis.renderer.grid.template.disabled = true;
		categoryAxis.renderer.minGridDistance = 40;
		categoryAxis.dataFields.category = "year";
		categoryAxis.startLocation = 0.4;
		categoryAxis.endLocation = 0.6;


		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
		valueAxis.tooltip.disabled = true;
		valueAxis.renderer.line.opacity = 0;
		valueAxis.renderer.ticks.template.disabled = true;
		valueAxis.min = 0;

		var lineSeries = chart.series.push(new am4charts.LineSeries());
		lineSeries.dataFields.categoryX = "year";
		lineSeries.dataFields.valueY = "income";
		lineSeries.tooltipText = "행위갯수: {valueY.value}";
		lineSeries.fillOpacity = 0.5;
		lineSeries.strokeWidth = 3;
		lineSeries.propertyFields.stroke = "lineColor";
		lineSeries.propertyFields.fill = "lineColor";
		
		var bullet = lineSeries.bullets.push(new am4charts.CircleBullet());
		bullet.circle.radius = 6;
		bullet.circle.fill = am4core.color("#fff");
		bullet.circle.strokeWidth = 3;

		chart.cursor = new am4charts.XYCursor();
		chart.cursor.behavior = "panX";
		chart.cursor.lineX.opacity = 0;
		chart.cursor.lineY.opacity = 0;

		chart.scrollbarX = new am4core.Scrollbar();
		chart.scrollbarX.parent = chart.bottomAxesContainer;
	</script>
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>