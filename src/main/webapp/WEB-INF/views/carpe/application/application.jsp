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
  <div class="wrap vsa-page bg-theme blue usage-m">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>
    <!-- // header -->

    <!-- nav -->
    <c:import url="../common/left_nav.jsp">
      <c:param name="d1" value="visualization"></c:param>
      <c:param name="d2" value="apphistory"></c:param>
    </c:import>
    <!-- // nav -->

    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
        <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
        <c:import url="../common/location_area.jsp">
		      <c:param name="d1" value="visualization"></c:param>
          <c:param name="d2" value="apphistory"></c:param>
        </c:import>
      </section>

      <article class="container">
        <h4 class="blind">행위 갯수</h4>
        <!--// Content 영역 //-->
        <!--// Side 메뉴가 우측에 있는 형태의 jqx-widget //-->
        <div class="content-box">
          <div class="content-area">
            <div style="width:500px;">
							<div class="combo" style="width:400px;">
								<span class="input-text-type-1 calendar" id="sdateSpan"><input type="text" id="sdate" placeholder="시작일" /></span>
								<span class="hyp">-</span>
								<span class="input-text-type-1 calendar" id="edateSpan"><input type="text" id="edate" placeholder="종료일" /></span>
							</div>
				      <div class="btn-area">
					      <button type="button" class="btn-case-01 btn-search txt" id="btnSearch"><span class="icon ico-search">조회</span></button>
				      </div>
            </div>
            <div id="chartdiv" class="chart-area chart-type-4">
              <!-- Chart 영역 //-->
            </div>
            <div id="jqxGrid_apphistory" class="data-tbl-area">
              <!-- table 영역 //-->
            </div>
            <div id="paging" class="paging-area">
              <!--// Table Paging 영역 - 위치고정 //-->
              <div class="paginate">
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
  var lineSeries;
  var sdate = "";
  var edate = "";
  var lastBullet;

  // Themes begin
  am4core.useTheme(am4themes_animated);
  am4core.options.commercialLicense = true;
  // Themes end

	$(document).ready(function() {
    $.datetimepicker.setLocale("ko");

    $("#sdate, #edate").datetimepicker({
      format: "Y-m-d H:i:00",
      step: 10
    });

    $("#sdate").val("");
    $("#edate").val("");

    /*
    $("#sdateSpan").click(function() {
    	$("#sdate").jqxDateTimeInput('open'); 
    });

    $("#edateSpan").click(function() {
    	$("#edate").jqxDateTimeInput('open'); 
    });
    */

    $("#btnSearch").click(function() {
      search();
    });

    //nav 열린 상태로 grid 호출시 사이즈 이상 조치용
    $(".nav").hover(function() {
      window.dispatchEvent(new Event('resize'));
    });

    initGrid();
    initChart();
    getAppHistoryList();
	});

  //검색
  var search = function() {
      currentPage = 1;
      getAppHistoryList();
      $("#jqxGrid_apphistory").jqxGrid('updateBoundData');
  };

  // 데이터 조회
  var getAppHistoryList = function() {
    $.ajax({
      url: "/carpe/application/app_list_group.do",
      dataType:'json',
      data: { 
        sdate: $("#sdate").val(),
        edate: $("#edate").val()
      },
      async:false,
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      success:function(data) {
        if (lastBullet) {
          lastBullet.hide();
        }

        chart.data = data.list;
        lineSeries.bullets._values = new Array();
        var bullet = lineSeries.bullets.push(new am4charts.CircleBullet());
        bullet.circle.radius = 6;
        bullet.circle.fill = am4core.color("#fff");
        bullet.circle.strokeWidth = 3;
        lastBullet = bullet;
        bullet.cursorOverStyle = am4core.MouseCursorStyle.pointer;
        bullet.events.on("hit", function(event) {

          var data = event.target.dataItem;
          var gdata = data.groupDataItems;
          var sdata = null;
          var sdata = null;

          if (gdata) {
            sdata = gdata[0].dataContext;
            edata = gdata[gdata.length - 1].dataContext;
          } else {
            sdata = event.target.dataItem.dataContext;
            edata = sdata;
          }

          var sdate = sdata.execution_time;
          var edate = edata.execution_time;

          $("#sdate").val(sdate);
          $("#edate").val(edate);
          search();
        });
      }
    });
  };

	//App History Grid
  var initGrid = function() {
	  var source = {
      datatype: "json",
      datafields: [
        { name: 'process_name', type: 'string' },
        { name: 'execution_time', type: 'string' },
        { name: 'process_path', type: 'string' },
        { name: 'reference_file', type: 'string' },
        { name: 'source', type: 'string' }
      ],
      type : "POST",
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      url: "/carpe/application/app_list.do"
    };

    var pagesize = <%=Consts.PAGE_SZIE%>;
    var currentPage = 1;
    var lastPage = 1;
    var currentRowCount = 0;
    var currentPageOffset = 1;

    var updateBound = function(e) {
      if (currentPage === e.data.value) {
        return;
      }

      currentPage = e.data.value;
      $("#jqxGrid_apphistory").jqxGrid('updateBoundData');
    };
  
	  var dataAdapter = new $.jqx.dataAdapter(source, {
	  	contentType : 'application/json; charset=utf-8',
	  	formatData : function(data) {
        data.sdate = $("#sdate").val();
        data.edate = $("#edate").val();
        data.currentPage = currentPage;
        data.pageSize = pagesize;
	      return data;
	  	},
	  	beforeSend : function(xhr) {
	  	},
	  	downloadComplete : function(data, status, xhr) {
        var totalcount = data['totalcount'] || 0;
        currentRowCount = data['list'] ? data['list'].length : 0;
  
        $('#paging').empty();
  
        if (totalcount < 1) {
          return;
        }

        var $divpageele = $('<div class="paginate">');
        var $firstele = $('<button type="button" class="btn-paging icon ico-first"><span class="ir">처음</span></button>');
        var $firsteleDis = $('<button type="button" class="btn-paging icon ico-first" disabled="disabled"><span class="ir">처음</span></button>');
        var $prevele = $('<button type="button" class="btn-paging icon ico-prev"><span class="ir">이전</span></button>');
        var $preveleDis = $('<button type="button" class="btn-paging icon ico-prev" disabled="disabled"><span class="ir">이전</span></button>');
        var $spanele = $('<span class="num">');
        var $nextele = $('<button class="btn-paging icon ico-next"><span class="ir">다음</span></button>');
        var $nexteleDis = $('<button class="btn-paging icon ico-next" disabled="disabled"><span class="ir">다음</span></button>');
        var $lastele = $('<button class="btn-paging icon ico-last"><span class="ir">마지막</span></button>');
        var $lasteleDis = $('<button class="btn-paging icon ico-last" disabled="disabled"><span class="ir">마지막</span></button>');
        var $aele
        
        if (currentPage % 10 === 0) {
          currentPageOffset = currentPage - 1;
        } else {
          currentPageOffset = currentPage;
        }

        currentPageOffset = Math.floor(currentPageOffset / 10) * 10 + 1;
        lastPage = Math.ceil(totalcount/pagesize);

        $firstele.on("click", { value: 1 }, updateBound);
        $lastele.on("click", { value: lastPage}, updateBound);

        if (currentPageOffset - 10 < 1) {
          $prevele.on("click", { value: 1 }, updateBound);
        } else {
          $prevele.on("click", { value: (currentPageOffset - 10) }, updateBound);
        }

        if (currentPageOffset + 10 > lastPage) {
          $nextele.on("click", { value: lastPage }, updateBound);
        } else {
          $nextele.on("click", { value: (currentPageOffset + 10) }, updateBound);
        }

        for(i = currentPageOffset, j = 1; (j <= 10) && (i <= lastPage); i++, j++) {
          if (i === currentPage) {
            $aele = $('<strong class="on">&nbsp;' + i + '&nbsp;</strong>');
            $spanele.append($aele);
          } else {
            $aele = $('<a href="#">&nbsp;' + i + '&nbsp;</a>');
            $aele.on("click", { value: i }, updateBound);
            $spanele.append($aele);
          }            
        }

        if (currentPage == 1) {
          $divpageele.append($firsteleDis);
          $divpageele.append($preveleDis);                        
        } else {
          $divpageele.append($firstele);
          $divpageele.append($prevele);
        }          
        
        $divpageele.append($spanele);
        
        if (currentPage == lastPage) {
          $divpageele.append($nexteleDis);
          $divpageele.append($lasteleDis);
        } else {
          $divpageele.append($nextele);
          $divpageele.append($lastele);
        }

        
        $('#paging').append($divpageele);  
	  	},
	  	loadComplete : function(data) {
	  	},
	  	loadError : function(xhr, status, error) {
	  	}
	  });
    
	  var columnSet = [
	  	{text: 'Process Name', dataField: 'process_name', width: '20%', cellsalign: 'left', align: 'center'},
	  	{text: 'Execution Time', dataField: 'execution_time', width: '10%', cellsalign: 'left', align: 'center'},
	  	{text: 'Process Path', dataField: 'process_path', width: 'auto', cellsalign: 'left', align: 'center'},
	  	{text: 'Reference File', dataField: 'reference_file', width: '20%', cellsalign: 'left', align: 'center'},
	  	{text: 'Source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
	  ];
	  
	  $('#jqxGrid_apphistory').on('bindingcomplete', function(event) {
	  	var localizationobj = {};
	  	localizationobj.emptydatastring = " ";
	  
	  	$("#jqxGrid_apphistory").jqxGrid('localizestrings', localizationobj);
      $("#jqxGrid_apphistory").jqxGrid('pagesize', currentRowCount);
	  });
	  
	  $("#jqxGrid_apphistory").jqxGrid({
	  	width: '100%',		
	  	height: '37%',
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

  // Chart 셋팅
  var initChart = function() {
    chart = am4core.create("chartdiv", am4charts.XYChart);
    chart.dateFormatter.inputDateFormat = "yyyy-MM-dd HH:mm:ss";
    chart.mouseWheelBehavior = "panX";

    xAxis = chart.xAxes.push(new am4charts.DateAxis());
    xAxis.renderer.grid.template.location = 0.5;
    xAxis.renderer.line.opacity = 0;
    xAxis.renderer.minGridDistance = 70;
    xAxis.dateFormatter = new am4core.DateFormatter();
    xAxis.renderer.labels.template.location = 0.5;
    xAxis.groupData = true;
    xAxis.dateFormats.setKey("month", "yyyy-MM");
    xAxis.periodChangeDateFormats.setKey("month", "yyyy-MM"); 
    xAxis.dateFormats.setKey("week", "yyyy-MM-dd");
    xAxis.periodChangeDateFormats.setKey("week", "yyyy-MM-dd"); 
    xAxis.dateFormats.setKey("day", "yyyy-MM-dd");
    xAxis.periodChangeDateFormats.setKey("day", "yyyy-MM-dd"); 
    xAxis.baseInterval = {
      "timeUnit": "second",
      "count": 1
    };

    var yAxis = chart.yAxes.push(new am4charts.ValueAxis());
    yAxis.renderer.line.opacity = 0;
    yAxis.renderer.ticks.template.disabled = true;
    yAxis.renderer.minGridDistance = 80;
    yAxis.maxPrecision = 0;
    yAxis.min = 0;
    
    lineSeries = chart.series.push(new am4charts.LineSeries());
    lineSeries.dataFields.dateX = "execution_time";
    lineSeries.dataFields.valueY = "cnt";
    lineSeries.tooltipText = "{dateX} : {valueY.value}";
    lineSeries.strokeWidth = 3;
    lineSeries.groupFields.valueY = "sum";
    //lineSeries.strokeOpacity = 0;
    
    chart.cursor = new am4charts.XYCursor();
    chart.cursor.lineX.opacity = 0;
    chart.cursor.lineY.opacity = 0;
    
    chart.scrollbarX = new am4core.Scrollbar();
//     chart.scrollbarX.startGrip.icon.disabled = true;
//     chart.scrollbarX.endGrip.icon.disabled = true;
//    chart.scrollbarX.startGrip.disabled = true;
//    chart.scrollbarX.endGrip.disabled = true;
    chart.scrollbarX.parent = chart.bottomAxesContainer;
  };

  </script>
  <!-- // 현재 페이지에 필요한 js -->

</body>
</html>