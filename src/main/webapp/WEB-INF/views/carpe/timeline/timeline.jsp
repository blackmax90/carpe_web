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
  <link rel="stylesheet" type="text/css" href="/carpe/resources/css/jquery.datetimepicker.min.css" />
  <link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">
  
  <script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/jquery.datetimepicker.full.min.js"></script>
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
    <c:import url="../common/left_nav.jsp">
      <c:param name="d1" value="visualization"></c:param>
      <c:param name="d2" value="timeline"></c:param>
    </c:import>
    <!-- // nav -->

    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
        <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
        <c:import url="../common/location_area.jsp">
          <c:param name="d1" value="visualization"></c:param>
          <c:param name="d2" value="timeline"></c:param>
        </c:import>
      </section>

      <article class="container">
        <h4 class="blind">행위 갯수</h4>
        <!--// Content 영역 //-->
        <!--// Side 메뉴가 우측에 있는 형태의 jqx-widget //-->
        <div class="content-box">
          <div class="content-area">
            <div class="fr" style="width:500px;">
              <div class="combo" style="width:400px;">
                <span class="input-text-type-1 calendar" id="sdateSpan" style="cursor: pointer;"><input type="text" id="sdate" placeholder="시작일" /></span>
                <span class="hyp">-</span>
                <span class="input-text-type-1 calendar" id="edateSpan" style="cursor: pointer;"><input type="text" id="edate" placeholder="종료일" /></span>
              </div>
              <div class="btn-area">
                <button type="button" class="btn-case-01 btn-search txt" id="btnSearch"><span class="icon ico-search">조회</span></button>
              </div>
            </div>
            <div class="division-line"></div>
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

  <!-- 공통 javascript 영역 -->
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/core.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/charts.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/themes/animated.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/plugins/timeline.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/plugins/bullets.js"></script>
  <!-- // 공통 javascript 영역 -->

  <script>
  // Themes begin
  am4core.useTheme(am4themes_animated);
  am4core.options.commercialLicense = true;
  // Themes end
  
  var chart = null;
  
  $(document).ready(function() {
    $.datetimepicker.setLocale("ko");

    $("#sdate, #edate").datetimepicker({
      format: "Y-m-d H:i:00",
      step: 10
    });

    $("#sdate").val("");
    $("#edate").val("");

    $("#sdateSpan").click(function() {
    	$("#sdate").datetimepicker('show'); 
    });
    
    $("#edateSpan").click(function() {
    	$("#edate").datetimepicker('show'); 
    });

    $("#btnSearch").click(function() {
      search();
    });
  });

  //검색
  var search = function() {
      getTimeLineList();
  };

  // 데이터 조회
  var getTimeLineList = function() {
    $.ajax({
      url: "/carpe/timeline/timeline_list.do",
      dataType:'json',
      data: { 
        sdate: $("#sdate").val(),
        edate: $("#edate").val()
      },
      async:false,
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      success:function(data) {
        var list = data.list;
        var sdate = "";
        var edate = "";

        for (var i = 0; i < list.length; i++) {
          var eventType = list[i].event_type;

          if (sdate == "") {
            sdate = list[i].event_time;
          }

          edate = list[i].event_time;

          if (eventType == "Email") {
            list[i].deactivate_message = false;
            list[i].color = "#888FFE";
            list[i].icon = "/carpe/resources/images/email2.png";
          } else if (eventType == "Call") {
            list[i].deactivate_call = false;
            list[i].color = "#5FDF7F";
            list[i].icon = "/carpe/resources/images/call4.png";
          } else if (eventType == "Message(SMS)") {
            list[i].deactivate_message = false;
            list[i].color = "#67B0FF";
            list[i].icon = "/carpe/resources/images/sms.svg";
          } else if (eventType == "Message(MMS)") {
            list[i].deactivate_message = false;
            list[i].color = "#67B0FF";
            list[i].icon = "/carpe/resources/images/sms.svg";
          } else if (eventType == "USB Connection") {
            list[i].deactivate_usb = false;
            list[i].color = "#DF5F5F";
            list[i].icon = "/carpe/resources/images/usb5.png";
          } else if (eventType == "Web(File Download)") {
            list[i].deactivate_web_download = false;
            list[i].color = "#DF865F";
            list[i].icon = "/carpe/resources/images/web_download.png";
          } else {
            list[i].deactivate_message = false;
            list[i].color = "#888FFE";
            list[i].icon = "/carpe/resources/images/email2.png";
          }

          if (list[i].description.trim().length > 0) {
            var arr = list[i].description.split(",");
            
            for (var j = 0; j < arr.length; j++) {
              var pos = arr[j].indexOf(":") + 1;
              var keyValArr = arr[j].split(":");
              var key = keyValArr[0].trim();
              var val = arr[j].substring(pos).trim();

              if (key.length > 0) {
                list[i][key] = val;
              }
            }
          }

          list[i].category = "Timeline";
        }

        //console.log(list);
        chart.data = list;

        if ($("#sdate").val() == "") {
          $("#sdate").val(sdate);
        }

        if ($("#edate").val() == "") {
          $("#edate").val(edate);
        }
      }
    });
  };

  am4core.ready(function() {
    chart = am4core.create("chartdiv", am4plugins_timeline.SerpentineChart);
    chart.curveContainer.padding(50, 20, 50, 20);
    chart.levelCount = 3;
    chart.yAxisRadius = am4core.percent(25);
    chart.yAxisInnerRadius = am4core.percent(-25);
    chart.maskBullets = false;
    
    var colorSet = new am4core.ColorSet();
    colorSet.saturation = 0.5;
    
    chart.dateFormatter.dateFormat = "yyyy-MM-dd HH:mm";
    chart.dateFormatter.inputDateFormat = "yyyy-MM-dd HH:mm";
    chart.fontSize = 11;
    
    var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
    categoryAxis.dataFields.category = "category";
    categoryAxis.renderer.grid.template.disabled = true;
    categoryAxis.renderer.labels.template.paddingRight = 25;
    categoryAxis.renderer.minGridDistance = 10;
    categoryAxis.renderer.innerRadius = -60;
    categoryAxis.renderer.radius = 60;
    
    var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
    dateAxis.renderer.minGridDistance = 70;
    dateAxis.baseInterval = { count: 1, timeUnit: "minute" };
    dateAxis.renderer.tooltipLocation = 0;
    dateAxis.startLocation = -0.5;
    dateAxis.renderer.line.strokeDasharray = "5,4";
    dateAxis.renderer.line.strokeOpacity = 0.6;
    dateAxis.tooltip.background.fillOpacity = 0.2;
    dateAxis.tooltip.background.cornerRadius = 5;
    dateAxis.tooltip.label.fill = new am4core.InterfaceColorSet().getFor("alternativeBackground");
    dateAxis.tooltip.label.paddingTop = 7;
  
    var labelTemplate = dateAxis.renderer.labels.template;
    labelTemplate.verticalCenter = "middle";
    labelTemplate.fillOpacity = 0.7;
    labelTemplate.background.fill = new am4core.InterfaceColorSet().getFor("background");
    labelTemplate.background.fillOpacity = 1;
    labelTemplate.padding(7, 7, 7, 7);
    
    var series = chart.series.push(new am4plugins_timeline.CurveColumnSeries());
    series.columns.template.height = am4core.percent(5);
    series.columns.template.tooltipText = "{event_type}: [bold]{openDateX}[/] - [bold]{dateX}[/]";
    series.dataFields.openDateX = "start";
    series.dataFields.dateX = "end";
    series.dataFields.categoryY = "category";
    series.columns.template.propertyFields.fill = "color"; // get color from data
    series.columns.template.propertyFields.stroke = "color";
    series.columns.template.strokeOpacity = 0;
    
    var bullet = series.bullets.push(new am4charts.CircleBullet());
    bullet.circle.radius = 3;
    bullet.circle.strokeOpacity = 0;
    bullet.propertyFields.fill = "color";
    bullet.locationX = 0;
    bullet.locationY = 10;
    
    var bullet2 = series.bullets.push(new am4charts.CircleBullet());
    bullet2.circle.radius = 3;
    bullet2.circle.strokeOpacity = 0;
    bullet2.propertyFields.fill = "color";
    bullet2.locationX = 1;
    bullet2.locationY = 10;
    
    var imageBullet1 = series.bullets.push(new am4plugins_bullets.PinBullet());
    imageBullet1.locationX = 0.5;
    imageBullet1.disabled = true;
    imageBullet1.propertyFields.disabled = "deactivate_call";
    imageBullet1.propertyFields.stroke = "color";
    imageBullet1.background.propertyFields.fill = "color";
    imageBullet1.image = new am4core.Image();
    imageBullet1.image.propertyFields.href = "icon";
    imageBullet1.image.scale = 0.7;
    imageBullet1.circle.radius = am4core.percent(100);
    imageBullet1.dy = -5;
    imageBullet1.tooltipText = "[bold]<{event_type}>[/]\n[bold]From[/] : {from}\n[bold]To[/] : {to}\n[bold]Start Time[/] : {openDateX}\n[bold]End Time[/] : {dateX}";
    imageBullet1.propertyFields.fill = "color"; // get color from data
    
    var imageBullet2 = series.bullets.push(new am4plugins_bullets.PinBullet());
    imageBullet2.locationX = 0.5;
    imageBullet2.disabled = true;
    imageBullet2.propertyFields.disabled = "deactivate_web_download";
    imageBullet2.propertyFields.stroke = "color";
    imageBullet2.background.propertyFields.fill = "color";
    imageBullet2.image = new am4core.Image();
    imageBullet2.image.propertyFields.href = "icon";
    imageBullet2.image.scale = 0.6;
    imageBullet2.circle.radius = am4core.percent(100);
    imageBullet2.dy = -5;
    imageBullet2.tooltipText = "[bold]<{event_type}>[/]\n[bold]Download Time[/] : {dateX}\n[bold]URL[/] : {URL}\n[bold]File[/] : {File}";
    imageBullet2.propertyFields.fill = "color"; // get color from data
    
    var imageBullet3 = series.bullets.push(new am4plugins_bullets.PinBullet());
    imageBullet3.locationX = 0.5;
    imageBullet3.disabled = true;
    imageBullet3.propertyFields.disabled = "deactivate_usb";
    imageBullet3.propertyFields.stroke = "color";
    imageBullet3.background.propertyFields.fill = "color";
    imageBullet3.image = new am4core.Image();
    imageBullet3.image.propertyFields.href = "icon";
    imageBullet3.image.scale = 0.7;
    imageBullet3.circle.radius = am4core.percent(100);
    imageBullet3.dy = -5;
    imageBullet3.tooltipText = "[bold]<{event_type}>[/]\n[bold]Connected Time[/] : {dateX}\n[bold]Serial Number[/] : {serial number}";
    imageBullet3.propertyFields.fill = "color"; // get color from data
    
    var imageBullet4 = series.bullets.push(new am4plugins_bullets.PinBullet());
    imageBullet4.locationX = 0.5;
    imageBullet4.disabled = true;
    imageBullet4.propertyFields.disabled = "deactivate_message";
    imageBullet4.propertyFields.stroke = "color";
    imageBullet4.background.propertyFields.fill = "color";
    imageBullet4.image = new am4core.Image();
    imageBullet4.image.propertyFields.href = "icon";
    imageBullet4.image.scale = 0.7;
    imageBullet4.circle.radius = am4core.percent(100);
    imageBullet4.dy = -5;
    imageBullet4.tooltipText = "[bold]<{event_type}>[/]\n[bold]From[/] : {from}\n[bold]To[/] : {to}\n[bold]DateTime[/] : {openDateX}";
    imageBullet4.propertyFields.fill = "color"; // get color from data
  
  
    var eventSeries = chart.series.push(new am4plugins_timeline.CurveLineSeries());
    eventSeries.dataFields.dateX = "eventDate";
    eventSeries.dataFields.categoryY = "category";
    eventSeries.data = [
    <!--    { category: "", eventDate: "2019-01-05 11:33", letter: "Call", description: "전지훈 called 윤우성" }, -->
    <!--    { category: "", eventDate: "2019-01-08 14:00", letter: "Message", description: "윤우성 send message to 전지훈" }, -->
    <!--    { category: "", eventDate: "2019-01-10 12:34", letter: "Call", description: "윤우성 called 전지훈" }-->
    ];
    eventSeries.strokeOpacity = 0;
    
    var flagBullet = eventSeries.bullets.push(new am4plugins_bullets.FlagBullet())
    flagBullet.label.propertyFields.text = "letter";
    flagBullet.locationX = 0;
    flagBullet.tooltipText = "{description}";
    
    chart.scrollbarX = new am4core.Scrollbar();
    chart.scrollbarX.align = "center"
    chart.scrollbarX.width = am4core.percent(85);
    
    var cursor = new am4plugins_timeline.CurveCursor();
    chart.cursor = cursor;
    cursor.xAxis = dateAxis;
    cursor.yAxis = categoryAxis;
    cursor.lineY.disabled = true;
    cursor.lineX.strokeDasharray = "1,4";
    cursor.lineX.strokeOpacity = 1;
    
    dateAxis.renderer.tooltipLocation2 = 0;
    categoryAxis.cursorTooltipEnabled = false;
  }); // end am4core.ready()
</script>

</body>
</html>