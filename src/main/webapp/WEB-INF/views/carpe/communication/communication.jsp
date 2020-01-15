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
						<div id="jqxGrid_Systemlog" role="grid" class="cont-result of-auto" style="width: 100%; height: calc(100% - 3rem);">
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
	
	
	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<!-- // 공통 javascript 영역 -->

	<!-- 현재 페이지에 필요한 js -->
	<script>

	function setYear(val) {
		location.href = "/carpe/communication.do?year=" + val.value;
	}
	
	$(document).ready(function() {
		
		var dataList = {outgoing: []}
		var dataList2 = {incoming: []}
	
		var cntData1 = 0;
		var cntData2 = 0;
		var getCallList = function(year) {
			$.ajax({
				url: "/carpe/communication_call_stat.do",
		        dataType:'json',
		        data: { year : year},
		        async:false,
		        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
		        success:function(data){
		        	 dataList = {outgoing: []}
		        	 $(data["list"]).each(function(i, list) {
		        		 cntData1 ++;
		        		 tmpArr = [list["number"], list["m1"], list["m2"], list["m3"], list["m4"]
		        		 , list["m5"], list["m6"], list["m7"], list["m8"], list["m9"]
		        		 , list["m10"], list["m11"], list["m12"]];
		        		 dataList.outgoing.push(tmpArr);
		             });
		        }
		    })
		};
		
		var getSmsList = function(year) {
			$.ajax({
				url: "/carpe/communication_sms_stat.do",
		        dataType:'json',
		        data: { year : year},
		        async:false,
		        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
		        success:function(data){
		        	 dataList2 = {incoming: []}
		        	 $(data["list"]).each(function(i, list) {
		        		 cntData2 ++;
		        		 tmpArr = [list["number"], list["m1"], list["m2"], list["m3"], list["m4"]
		        		 , list["m5"], list["m6"], list["m7"], list["m8"], list["m9"]
		        		 , list["m10"], list["m11"], list["m12"]];
		        		 dataList2.incoming.push(tmpArr);
		             });
		        }
		    })
		};
		
		getCallList(${year});
		getSmsList(${year});
		// Chart1 Start
		am4core.useTheme(am4themes_animated);
	
		var startYear = 1;
		var endYear = 12;
		var currentYear = 10;
		var colorSet = new am4core.ColorSet();
	
		if (cntData1 > 0) {
			var chart = am4core.create("chartdiv01", am4charts.RadarChart);
			chart.numberFormatter.numberFormat = "#건";
			chart.hiddenState.properties.opacity = 0;
		
			chart.startAngle = 270 - 180;
			chart.endAngle = 270 + 180;
		
			chart.radius = am4core.percent(60);
			chart.innerRadius = am4core.percent(40);
		
			// year label goes in the middle
			var yearLabel = chart.radarContainer.createChild(am4core.Label);
			yearLabel.horizontalCenter = "middle";
			yearLabel.verticalCenter = "middle";
			yearLabel.fill = am4core.color("#673AB7");
			yearLabel.fontSize = 30;
			yearLabel.text = String(currentYear);
		
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
			categoryAxisLabel.location = 0.5;
			categoryAxisLabel.radius = 28;
			categoryAxisLabel.relativeRotation = 90;
		
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
			series.dataFields.valueY = "value" + currentYear;
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
		
			// year slider
			var yearSliderContainer = chart.createChild(am4core.Container);
			yearSliderContainer.layout = "vertical";
			yearSliderContainer.padding(0, 38, 0, 38);
			yearSliderContainer.width = am4core.percent(100);
		
			var yearSlider = yearSliderContainer.createChild(am4core.Slider);
			yearSlider.events.on("rangechanged", function () {
			    updateRadarData(startYear + Math.round(yearSlider.start * (endYear - startYear)));
			})
			yearSlider.orientation = "horizontal";
			yearSlider.start = 0.5;
		
			var slider = yearSliderContainer.createChild(am4core.Slider);
			slider.start = 1;
			slider.events.on("rangechanged", function () {
			    var start = slider.start;
		
			    chart.startAngle = 270 - start * 179 - 1;
			    chart.endAngle = 270 + start * 179 + 1;
		
			    valueAxis.renderer.axisAngle = chart.startAngle;
			})
			
			chart.data = generateRadarData();
		}
		
		function generateRadarData() {
		    var data = [];
		    var i = 0;
		    for (var continent in dataList) {
		        var continentData = dataList[continent];
	
		        continentData.forEach(function (country) {
		            var rawDataItem = { "country": country[0] }
	
		            for (var y = 2; y < country.length; y++) {
		                rawDataItem["value" + (startYear + y - 2)] = country[y];
		            }
	
		            data.push(rawDataItem);
		        });
	
		        createRange(continent, continentData, i);
		        i++;
	
		    }
		    return data;
		}
	
	
		function updateRadarData(year) {
		    if (currentYear != year) {
		        currentYear = year;
		        yearLabel.text = String(currentYear) + '월';
		        series.dataFields.valueY = "value" + currentYear;
		        chart.invalidateRawData();
		    }
		}
	
		function createRange(name, continentData, index) {
	
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
		        }
		        else {
		            categoryAxis.zoomToCategories(dataItem.category, dataItem.endCategory);
		        }
		    })
	
		    // hover state
		    var hoverState = axisFill.states.create("hover");
		    hoverState.properties.innerRadius = -10;
		    hoverState.properties.radius = -25;
	
		    var axisLabel = axisRange.label;
		    axisLabel.location = 0.5;
		    axisLabel.fill = am4core.color("#ffffff");
		    axisLabel.radius = 0;
		    axisLabel.relativeRotation = 0;
		}
		
		// Chart1 End
		// Chart2 Start
		if (cntData2 > 0) {
			am4core.useTheme(am4themes_animated);
			var startYear2 = 1;
			var endYear2 = 12;
			var currentYear2 = 10;
			var colorSet = new am4core.ColorSet();
		
			var chart2 = am4core.create("chartdiv02", am4charts.RadarChart);
			chart2.numberFormatter.numberFormat = "#건";
			chart2.hiddenState.properties.opacity = 0;
		
			chart2.startAngle = 270 - 180;
			chart2.endAngle = 270 + 180;
		
			chart2.radius = am4core.percent(60);
			chart2.innerRadius = am4core.percent(40);
		
			// year label goes in the middle
			var yearLabel2 = chart2.radarContainer.createChild(am4core.Label);
			yearLabel2.horizontalCenter = "middle";
			yearLabel2.verticalCenter = "middle";
			yearLabel2.fill = am4core.color("#673AB7");
			yearLabel2.fontSize = 30;
			yearLabel2.text = String(currentYear2);
		
			// zoomout button
			var zoomOutButton = chart2.zoomOutButton;
			zoomOutButton.dx = 0;
			zoomOutButton.dy = 0;
			zoomOutButton.marginBottom = 15;
			zoomOutButton.parent = chart2.rightAxesContainer;
		
			// scrollbar
			chart2.scrollbarX = new am4core.Scrollbar();
			chart2.scrollbarX.parent = chart2.rightAxesContainer;
			chart2.scrollbarX.orientation = "vertical";
			chart2.scrollbarX.align = "center";
		
			// vertical orientation for zoom out button and scrollbar to be positioned properly
			chart2.rightAxesContainer.layout = "vertical";
			chart2.rightAxesContainer.padding(120, 20, 120, 20);
		
			// category axis
			var categoryAxis = chart2.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.dataFields.category = "country";
		
			var categoryAxisRenderer = categoryAxis.renderer;
			var categoryAxisLabel = categoryAxisRenderer.labels.template;
			categoryAxisLabel.location = 0.5;
			categoryAxisLabel.radius = 28;
			categoryAxisLabel.relativeRotation = 90;
		
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
			var valueAxis2 = chart2.yAxes.push(new am4charts.ValueAxis());
			valueAxis2.min = 0;
			valueAxis2.max = 40;
			valueAxis2.strictMinMax = true;
			valueAxis2.tooltip.defaultState.properties.opacity = 0;
			valueAxis2.tooltip.animationDuration = 0;
			valueAxis2.cursorTooltipEnabled = true;
			valueAxis2.zIndex = 10;
		
			var valueAxisRenderer2 = valueAxis2.renderer;
			valueAxisRenderer2.axisFills.template.disabled = true;
			valueAxisRenderer2.ticks.template.disabled = true;
			valueAxisRenderer2.minGridDistance = 30;
			valueAxisRenderer2.grid.template.strokeOpacity = 0.05;
		
		
			// series
			var series2 = chart2.series.push(new am4charts.RadarColumnSeries());
			series2.columns.template.width = am4core.percent(90);
			series2.columns.template.strokeOpacity = 0;
			series2.dataFields.valueY = "value" + currentYear2;
			series2.dataFields.categoryX = "country";
			series2.tooltipText = "{categoryX}:{valueY.value}";
		
			// this makes columns to be of a different color, depending on value
			series2.heatRules.push({ target: series2.columns.template, property: "fill", minValue: 0, maxValue: 40, min: am4core.color("#673AB7"), max: am4core.color("#F44336"), dataField: "valueY" });
		
			// cursor
			var cursor = new am4charts.RadarCursor();
			chart2.cursor = cursor;
			cursor.behavior = "zoomX";
		
			cursor.xAxis = categoryAxis;
			cursor.innerRadius = am4core.percent(40);
			cursor.lineY.disabled = true;
		
			cursor.lineX.fillOpacity = 0.2;
			cursor.lineX.fill = am4core.color("#000000");
			cursor.lineX.strokeOpacity = 0;
			cursor.fullWidthLineX = true;
		
			// year slider
			var yearSliderContainer2 = chart2.createChild(am4core.Container);
			yearSliderContainer2.layout = "vertical";
			yearSliderContainer2.padding(0, 38, 0, 38);
			yearSliderContainer2.width = am4core.percent(100);
		
			var yearSlider2 = yearSliderContainer2.createChild(am4core.Slider);
			yearSlider2.events.on("rangechanged", function () {
			    updateRadarData2(startYear2 + Math.round(yearSlider2.start * (endYear2 - startYear2)));
			})
			yearSlider2.orientation = "horizontal";
			yearSlider2.start = 0.5;
		
			var slider2 = yearSliderContainer2.createChild(am4core.Slider);
			slider2.start = 1;
			slider2.events.on("rangechanged", function () {
			    var start2 = slider2.start;
		
			    chart2.startAngle = 270 - start2 * 179 - 1;
			    chart2.endAngle = 270 + start2 * 179 + 1;
		
			    valueAxis2.renderer.axisAngle = chart2.startAngle;
			})
		
			chart2.data = generateRadarData2();
		
		}
		function generateRadarData2() {
		    var data = [];
		    var i = 0;
		    for (var continent in dataList2) {
		        var continentData = dataList2[continent];
	
		        continentData.forEach(function (country) {
		            var rawDataItem = { "country": country[0] }
	
		            for (var y = 2; y < country.length; y++) {
		                rawDataItem["value" + (startYear2 + y - 2)] = country[y];
		            }
	
		            data.push(rawDataItem);
		        });
	
		        createRange2(continent, continentData, i);
		        i++;
	
		    }
		    return data;
		}
	
	
		function updateRadarData2(year) {
		    if (currentYear2 != year) {
		        currentYear2 = year;
		        yearLabel2.text = String(currentYear2) + '월';
		        series2.dataFields.valueY = "value" + currentYear2;
		        chart2.invalidateRawData();
		    }
		}
	
		function createRange2(name, continentData, index) {
	
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
		        }
		        else {
		            categoryAxis.zoomToCategories(dataItem.category, dataItem.endCategory);
		        }
		    })
	
		    // hover state
		    var hoverState = axisFill.states.create("hover");
		    hoverState.properties.innerRadius = -10;
		    hoverState.properties.radius = -25;
	
		    var axisLabel = axisRange.label;
		    axisLabel.location = 0.5;
		    axisLabel.fill = am4core.color("#ffffff");
		    axisLabel.radius = 0;
		    axisLabel.relativeRotation = 0;
		}
	
	
		//grid start
		$(document).ready(function() {
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
		});
	});
	<!-- // 현재 페이지에 필요한 js -->
	</script>

</body>
</html>