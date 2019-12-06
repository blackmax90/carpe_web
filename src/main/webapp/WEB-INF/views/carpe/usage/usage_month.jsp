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
				<h4 class="blind">Usage model Chart</h4>
				<!--// Content 영역 //-->
				<!--// Side 메뉴가 우측에 있는 형태의 jqx-widget //-->
				<div class="content-box">
					<div class="content-area">
						<div class="btn-area">
							<ul>
								<li><button type="button" class="btn-case-01" id="">사용 (업무시간)</button></li>
								<li><button type="button" class="btn-case-01" id="">사용 (업무시간 이외)</button></li>
							</ul>
						</div>
						<div class="result-long-data ofy-auto">
							<div id="chartdiv" class="chart-area chart-type-2">
								<!-- Chart 영역 //-->
							</div>
						</div>
					</div>
					<!--// Chart 영역 -->
					
				</div><!--// content-box -->

			</article>
		</main>
		<!-- // main -->

	</div>
	<!-- // wrap -->

	<!-- 공통 javascript 영역 -->
	<script src="https://www.amcharts.com/lib/4/core.js"></script>
	<script src="https://www.amcharts.com/lib/4/charts.js"></script>
	<script src="https://www.amcharts.com/lib/4/themes/animated.js"></script>
	<!-- // 공통 javascript 영역 -->

	<!-- 현재 페이지에 필요한 js -->
	<script>
		
		var getUsageMonthList = function(year, month) {
			$.ajax({
				url: "/carpe/usage_month_list.do",
		        dataType:'json',
		        data: { year : year
		        	   ,month : month
		        	  },
		        async:false,
		        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
		        success:function(data){
		        	dataList = new Array();
		        	$(data["list"]).each(function(i, list) {
		        		 var tmpArr = {}
		        		 tmpArr.year = list["day"] + "일";
		        		 tmpArr.income = list["office_hours"];
		        		 tmpArr.expenses = list["office_hours_after"];
		        		 dataList.push(tmpArr);
	
		            });
		        }
		    })
		    return dataList;
		}
		
		dataList = getUsageMonthList(${year}, ${month});
		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		 // Create chart instance
		var chart = am4core.create("chartdiv", am4charts.XYChart);

		// Add data
		chart.data = dataList;

		
		// Create axes
		var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
		categoryAxis.dataFields.category = "year";
		categoryAxis.numberFormatter.numberFormat = "#";
		categoryAxis.renderer.inversed = true;
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.renderer.cellStartLocation = 0.1;
		categoryAxis.renderer.cellEndLocation = 0.9;

		var  valueAxis = chart.xAxes.push(new am4charts.ValueAxis()); 
		valueAxis.renderer.opposite = true;

		// Create series
		function createSeries(field, name) {
		  var series = chart.series.push(new am4charts.ColumnSeries());
		  series.dataFields.valueX = field;
		  series.dataFields.categoryY = "year";
		  series.name = name;
		  series.columns.template.tooltipText = "{name}: [bold]{valueX}[/]";
		  series.columns.template.height = am4core.percent(100);
		  series.sequencedInterpolation = true;

		  series.columns.template.events.on("hit", function(ev) {
			  day = ev.target.dataItem.categoryY.replace("일", "");
			  location.href = '/carpe/usage_day.do?year=' + ${year} + '&month=' + ${month} + '&day=' + day;
  		  	  handleHover(ev.target);
			})
			
		  var valueLabel = series.bullets.push(new am4charts.LabelBullet());
		  valueLabel.label.text = "{valueX}";
		  valueLabel.label.horizontalCenter = "left";
		  valueLabel.label.dx = 10;
		  valueLabel.label.hideOversized = false;
		  valueLabel.label.truncate = false;

		  var categoryLabel = series.bullets.push(new am4charts.LabelBullet());
		  categoryLabel.label.text = "{name}";
		  categoryLabel.label.horizontalCenter = "right";
		  categoryLabel.label.dx = -10;
		  categoryLabel.label.fill = am4core.color("#fff");
		  categoryLabel.label.hideOversized = false;
		  categoryLabel.label.truncate = false;
		}

		createSeries("income", "업무시간");
		createSeries("expenses", "업무시간 이외");

	</script>
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>