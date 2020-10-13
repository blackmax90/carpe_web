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
      <c:param name="d2" value="usagehistory"></c:param>
    </c:import>
    <!-- // nav -->

    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
        <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
        <c:import url="../common/location_area.jsp">
		      <c:param name="d1" value="visualization"></c:param>
		      <c:param name="d2" value="usagehistory"></c:param>
        </c:import>
      </section>

      <article class="container">
        <h4 class="blind">행위 갯수</h4>
        <!--// Content 영역 //-->
        <!--// Side 메뉴가 우측에 있는 형태의 jqx-widget //-->
        <div class="content-box">
          <div class="content-area">
            <div class="tit-area">
              <h3 class="unit" id="dateStr">${year}년 ${month}월 ${day}일</h3>
              <button type="button" class="fl btn-case-01" style="margin-right:1rem;" id="btnCalendar"><span>일자변경</span></button>
                  <div id="dateInput" class="input-calendar-jqx" style="margin-left: -9rem; width: 0rem;"></div>
              <div class="select">
                <select name="selHour" id="selHour">
                  <c:forEach var="i" begin="1" end="24">
                    <fmt:formatNumber var="hourStr" minIntegerDigits="2" value="${i}" type="number"/>
                    <option value="${hourStr}" <c:if test="${i == hour}">selected</c:if> >${i}시</option>
                  </c:forEach>
                </select>
              </div>
            </div>
            <div id="chartdiv" class="chart-area chart-type-4">
              <!-- Chart 영역 //-->
            </div>
            <div id="jqxGrid_Systemlog" class="data-tbl-area">
              <!-- table 영역 //-->
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
  var sdate = "";
  var edate = "";

  // Themes begin
  am4core.useTheme(am4themes_animated);
  am4core.options.commercialLicense = true;
  // Themes end

  $(document).ready(function () {
    // Create a jqxDateTimeInput
    $("#dateInput").jqxDateTimeInput({
      value: new Date(${year}, ${month} - 1, ${day}), 
      width: '30rem', 
      height: '3rem'
    });

    $("#btnCalendar").click(function() {
      $("#dateInput").jqxDateTimeInput('open'); 
    });

    $("#selHour").change(function() {
      getUsageDayList();
    });

    $("#dateInput").change(function() {
      getUsageDayList();
    });

    initChart();
    initGrid();
    getUsageDayList();
  });

  var getUsageDayList = function() {
    var date = $("#dateInput").jqxDateTimeInput("getDate");
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var hour = $("#selHour").val();

    $("#dateStr").text(year + "년 " + month + "월 " + day + "일");

    $.ajax({
      url: "/carpe/usage_day_list.do",
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
        chart.data = data.list;
        $("#jqxGrid_Systemlog").jqxGrid("clear");
      }
    });
  };
  
  var initChart = function() {
    chart = am4core.create("chartdiv", am4charts.XYChart);

    var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
    categoryAxis.renderer.grid.template.location = 0;
    categoryAxis.renderer.ticks.template.disabled = true;
    categoryAxis.renderer.line.opacity = 0;
    categoryAxis.renderer.grid.template.disabled = true;
    categoryAxis.renderer.minGridDistance = 40;
    categoryAxis.dataFields.category = "min";
    categoryAxis.startLocation = 0.4;
    categoryAxis.endLocation = 0.6;
    
    var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
    valueAxis.tooltip.disabled = true;
    valueAxis.renderer.line.opacity = 0;
    valueAxis.renderer.ticks.template.disabled = true;
    valueAxis.min = 0;
    
    var lineSeries = chart.series.push(new am4charts.LineSeries());
    lineSeries.dataFields.categoryX = "min";
    lineSeries.dataFields.valueY = "act";
    lineSeries.tooltipText = "행위갯수: {valueY.value}";
    lineSeries.fillOpacity = 0.5;
    lineSeries.strokeWidth = 3;
    lineSeries.propertyFields.stroke = "lineColor";
    lineSeries.propertyFields.fill = "lineColor";
    
    var bullet = lineSeries.bullets.push(new am4charts.CircleBullet());
    bullet.circle.radius = 6;
    bullet.circle.fill = am4core.color("#fff");
    bullet.circle.strokeWidth = 3;
    bullet.cursorOverStyle = am4core.MouseCursorStyle.pointer;
    bullet.events.on("hit", function(event) {
      var data = event.target.dataItem.dataContext;
      var date = $("#dateInput").jqxDateTimeInput("getDate");
      var year = date.getFullYear();
      var month = date.getMonth() + 1;
      var day = date.getDate();
      var hour = $("#selHour").val();

      if (month < 10) {
        month = "0" + month;
      }

      if (day < 10) {
        day = "0" + day;
      }

      sdate = year + "-" + month + "-" + day + " " + hour + ":" + data.min + ":00";
      edate = year + "-" + month + "-" + day + " " + hour + ":" + data.min + ":59";

      console.log(sdate + ", " + edate);
      $("#jqxGrid_Systemlog").jqxGrid("updateBoundData");
      //console.log(event.target.dataItem.dataContext);
    });
    
    chart.cursor = new am4charts.XYCursor();
    chart.cursor.behavior = "panX";
    chart.cursor.lineX.opacity = 0;
    chart.cursor.lineY.opacity = 0;
    
    chart.scrollbarX = new am4core.Scrollbar();
    chart.scrollbarX.parent = chart.bottomAxesContainer;
  };

  // 하단 Grid
  var initGrid = function() {
    var source = {
      datatype: "json",
      datafields: [
        { name: 'regdate', type: 'string' },
        { name: 'evdnc_type', type: 'string' },
        { name: 'artifact_type', type: 'string' },
        { name: 'information', type: 'string' }
      ],
      type : "POST",
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      url: "/carpe/usage_day_detail_list.do"
    };

    var dataAdapter = new $.jqx.dataAdapter(source, {
      contentType : 'application/json; charset=utf-8',
      formatData : function(data) {
        data["sdate"] = sdate;
        data["edate"] = edate;
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
      {text: '시간', dataField: 'regdate', width: '200px', cellsalign: 'center', align: 'center'},
      {text: '증거 유형', dataField: 'evdnc_type', width: '200px', cellsalign: 'center', align: 'center'},
      {text: '아티팩트 유형', dataField: 'artifact_type', width: '200px', cellsalign: 'center', align: 'center'},
      {text: '주요 정보', dataField: 'information', width: 'auto', cellsalign: 'left', align: 'center'}
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
  };

  </script>
  <!-- // 현재 페이지에 필요한 js -->

</body>
</html>