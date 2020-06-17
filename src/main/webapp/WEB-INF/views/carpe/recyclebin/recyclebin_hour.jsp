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
  <div class="wrap vsa-page bg-theme blue usage-m">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>
    <!-- // header -->

    <!-- nav -->
    <c:import url="../common/left_nav.jsp">
      <c:param name="d1" value="visualization"></c:param>
      <c:param name="d2" value="recyclebin"></c:param>
    </c:import>
    <!-- // nav -->

    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
        <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
      </section>

      <article class="container">
        <!--// Content 영역 //-->
        <div class="content-box">
          <div class="content-area">
            <div class="tit-area">
              <h3 class="unit" id="dateStr">${selYear}년 ${selMonth}월 ${selDay}일 ${selHour}시  </h3>
              <div class="select mr20">
                <form id="frm" method="post" action="/carpe/recyclebin/recyclebinHour.do">
                  <input type="hidden" name="selYear" id="selYear" value="${selYear}" />
                  <input type="hidden" name="selMonth" id="selMonth" value="${selMonth}"/>
                  <input type="hidden" name="selDay" id="selDay" value="${selDay}"/>
                  <input type="hidden" name="selMin" id="selMin" />
                  <select name="selHour" id="selHour">
                    <c:forEach var="i" begin="0" end="23">
                      <fmt:formatNumber var="hourStr" minIntegerDigits="2" value="${i}" type="number"/>
                      <option value="${hourStr}" <c:if test="${hourStr eq selHour}">selected</c:if> >${hourStr}</option>
                    </c:forEach>
                  </select>
                </form>
              </div>
						  <div>
						  	<button type="button" class="btn-case-01" id="moveBack">뒤로가기</button>
						  </div>
            </div>
            <!-- Chart 영역 //-->
            <div id="chartdiv" class="chart-area chart-type-3">
            </div>
            <!--// Chart 영역 -->
          </div>
        </div><!--// content-box -->

      </article>
    </main>
    <!-- // main -->

  </div>
  <!-- // wrap -->

	<!-- pop-up //파일목록-->
	<div id="fileInfo" class="pop wrap-pop">
		<div class="pop-header jqx-window-header">
			<h1>파일 정보</h1>
		</div>
		<div class="pop-content">
			<div id="jqxGrid_fileInfo" class="data-tbl-area">
			</div><!--// content-box -->			
		</div><!-- // pop-content end -->
	</div><!-- // pop-up end -->
  
  <!-- 공통 javascript 영역 -->
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/core.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/charts.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/themes/animated.js"></script>
  
  <script type="text/javascript" src="/carpe/resources/jqwidgets/jqxdatetimeinput.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/jqxcalendar.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/jqxtooltip.js"></script>
  <!-- // 공통 javascript 영역 -->

  <!-- 현재 페이지에 필요한 js -->
  <script>
  var chart;
  var xAxis;
  var sdate = "";
  var edate = "";

  // Themes begin
  am4core.useTheme(am4themes_animated);
  am4core.options.commercialLicense = true;
  // Themes end

  $(document).ready(function () {
    $("#selHour").change(function() {
      getRecyclebinList();
    });

    $("#moveBack").click(function() {
      history.back();
    });

    initChart();
    initPopup();
    initGrid();
    getRecyclebinList();
  });

  // 데이터 조회
  var getRecyclebinList = function() {
    var year = $("#selYear").val();
    var month = $("#selMonth").val();
    var day = $("#selDay").val();
    var hour = $("#selHour").val();

    $.ajax({
      url: "/carpe/recyclebin/recyclebinHourList.do",
      dataType:'json',
      data: { 
        year : year, 
        month : month,
        day : day,
        hour : hour 
      },
      async:false,
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      success:function(data) {
        console.log(data);
        $("#dateStr").text(year + "년 " + month + "월 " + day + "일 " + hour + "시 ");
        xAxis.min = new Date(year, parseInt(month) - 1, day, hour, 0).getTime();
        xAxis.max = new Date(year, parseInt(month) - 1, day, hour, 59).getTime();
        chart.data = data.list;
      }
    });
  };

  // Chart 셋팅
  var initChart = function() {
    chart = am4core.create("chartdiv", am4charts.XYChart);
    chart.dateFormatter.inputDateFormat = "yyyy-MM-dd HH:mm";

    xAxis = chart.xAxes.push(new am4charts.DateAxis());
    xAxis.renderer.grid.template.location = 0.5;
    xAxis.renderer.minGridDistance = 40;
    xAxis.dateFormatter = new am4core.DateFormatter();
    xAxis.dateFormats.setKey("minute", "mm");
    xAxis.periodChangeDateFormats.setKey("minute", "mm");
    xAxis.baseInterval = { count: 5, timeUnit: "minute" };
    xAxis.renderer.labels.template.location = 0.5;

    var yAxis = chart.yAxes.push(new am4charts.ValueAxis());
    yAxis.renderer.line.opacity = 0;
    yAxis.renderer.ticks.template.disabled = true;
    yAxis.renderer.minGridDistance = 80;
    yAxis.maxPrecision = 0;
    yAxis.min = 0;
    
    var lineSeries = chart.series.push(new am4charts.LineSeries());
    lineSeries.dataFields.dateX = "min";
    lineSeries.dataFields.valueY = "cnt";
    lineSeries.tooltipText = "삭제 파일 개수 : {valueY.value}";
    lineSeries.strokeWidth = 3;
    //lineSeries.strokeOpacity = 0;
    
    var bullet = lineSeries.bullets.push(new am4charts.CircleBullet());
    bullet.circle.radius = 6;
    bullet.circle.fill = am4core.color("#fff");
    bullet.circle.strokeWidth = 3;
    bullet.cursorOverStyle = am4core.MouseCursorStyle.pointer;
    bullet.events.on("hit", function(event) {
      var data = event.target.dataItem.dataContext;

      $("#fileInfo").jqxWindow('open');
      $("#selMin").val(data.min);
      $("#jqxGrid_fileInfo").jqxGrid('updateBoundData');
    });

    var bullethover = bullet.states.create("hover");
    bullethover.properties.scale = 1.5;
    
    chart.cursor = new am4charts.XYCursor();
    chart.cursor.lineX.opacity = 0;
    chart.cursor.lineY.opacity = 0;
    
    chart.scrollbarX = new am4core.Scrollbar();
    chart.scrollbarX.parent = chart.bottomAxesContainer;
  };

  // 팝업윈도우 셋팅
  var initPopup = function() {
    //파일 Window
    $("#fileInfo").jqxWindow({
        width: '80rem'
      , height: '60rem'
      , resizable: false
      , autoOpen: false
      , resizable: false
      , isModal: true
      , modalOpacity: 0.3
    });
  };

	//Grid 셋팅
  var initGrid = function() {
	  var source = {
      datatype: "json",
      datafields: [
        { name: 'file_name', type: 'string' },
        { name: 'size', type: 'string' },
        { name: 'dtime', type: 'string' },
        { name: 'i_file_name', type: 'string' }
      ],
      type : "POST",
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      url: "/carpe/recyclebin/recyclebinList.do"
    };
	  
	  var dataAdapter = new $.jqx.dataAdapter(source, {
	  	contentType : 'application/json; charset=utf-8',
	  	formatData : function(data) {
        var min = $("#selMin").val();

        if (min) {
          data.date = min + ":00";
        }
        
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
	  	{text: '파일이름', dataField: 'file_name', width: 'auto', cellsalign: 'left', align: 'center'},
	  	{text: '크기', dataField: 'size', width: 'auto', cellsalign: 'left', align: 'center'},
	  	{text: '삭제시간', dataField: 'dtime', width: 'auto', cellsalign: 'left', align: 'center'},
	  	{text: '$I 이름', dataField: 'i_file_name', width: 'auto', cellsalign: 'left', align: 'center'}
	  ];
	  
	  $('#jqxGrid_fileInfo').on('bindingcomplete', function(event) {
	  	var localizationobj = {};
	  	localizationobj.emptydatastring = " ";
	  
	  	$("#jqxGrid_fileInfo").jqxGrid('localizestrings', localizationobj);
	  });
	  
	  $("#jqxGrid_fileInfo").jqxGrid({
	  	width: '100%',		
	  	height: '100%',
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

  </script>
  <!-- // 현재 페이지에 필요한 js -->

</body>
</html>