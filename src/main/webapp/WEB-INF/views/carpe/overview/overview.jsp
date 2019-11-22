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
	<div class="wrap overview bg-theme blue">

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
				//-->
				<ul>
					<li class="on"><a href="/carpe/overview.do" class="icon overview">Overview</a></li>
					<li><a href="/carpe/evdnc.do" class="icon evidence">Evidence</a></li>
					<li><a href="#" class="icon analysis">Analysis</a></li>
					<!-- 2Depth Menu //-->
						<li class="level02 hide"><a href="#">Filesystem</a></li> 
						<li class="level02 hide"><a href="#">Artifact</a></li>
					<!--// 2Depth Menu -->
					<li><a href="/carpe/communication.do" class="icon visualization">Visualization</a></li>	
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
					<h3>Evidence별 파일 비율</h3>
					<%-- <p><fmt:formatNumber value="${logtimelineCnt }"/> 건 발견</p> --%>
					<div class="cont-result" id="chartDiv">
						<ul>
							<li>
								<div id="chartdiv-s2" class="chart-area">
									<!-- Chart 영역 //-->
								</div>
							</li>
							<li>
								<div id="chartdiv-s2" class="chart-area">
									<!-- Chart 영역 //-->
								</div>
							</li>
							<li>
								<div id="chartdiv-s3" class="chart-area">
									<!-- Chart 영역 //-->
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="content-area bg-unit">
					<h3>Case Log</h3>
					<c:forEach items="${caseUserList }" var="userList">
						<p>${userList.user_id }</p>
					</c:forEach>
				</div>
			</article>
		</main>
		<!-- // main -->

	</div>
	<!-- // wrap -->


	<!-- 현재 페이지에 필요한 js -->
	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<script>
	<!-- Chart code -->
	am4core.ready(function() {

		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		// Create chart instance
		var chart = am4core.create("chartDiv", am4charts.PieChart);

		// Add data
		chart.data = [ {
		  "country": "Processing",
		  "litres": 7
		}, {
		  "country": "Complete",
		  "litres": 15
		}, {
		  "country": "Ready",
		  "litres": 5
		}];

		// Set inner radius
		chart.innerRadius = am4core.percent(50);

		// Add and configure Series
		var pieSeries = chart.series.push(new am4charts.PieSeries());
		pieSeries.dataFields.value = "litres";
		pieSeries.dataFields.category = "country";
		pieSeries.slices.template.stroke = am4core.color("#fff");
		pieSeries.slices.template.strokeWidth = 2;
		pieSeries.slices.template.strokeOpacity = 1;

		// This creates initial animation
		pieSeries.hiddenState.properties.opacity = 1;
		pieSeries.hiddenState.properties.endAngle = -90;
		pieSeries.hiddenState.properties.startAngle = -90;

		}); // end am4core.ready()
	</script>
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>