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
  <style>
  .jqx-grid-content
  {
    cursor: pointer;
  }
  .gridLink:hover {text-decoration: underline;}
  </style>
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
		  <c:param name="d2" value="communication"></c:param>
		</c:import>
		<!-- // nav -->

		<!-- main -->
		<main class="main">
			<section class="tit-area">
				<h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
				<a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
				<div class="location-area">
					<ul class="list-h">
						<li>Home</li>
						<li>Visualization</li>
						<li>Communication</li>
					</ul>
				</div>
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
                      <c:forEach var="list" items="${yearList}">
                        <option value="${list.year}" <c:if test="${list.year eq year}">selected</c:if> >${list.year}</option>
                      </c:forEach>
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
	
	<!-- pop-up // 대화목록 팝업  // -->
	<div id="roomLayer" class="pop chatroom wrap-pop">
		<div id="roomLayerHeader" class="pop-header">
			<h1>Communication Data</h1>
		</div>
		<div id="roomLayerContent" class="pop-content">		
			<h4 class="blind">대화 목록</h4>
			<!--// Content 영역 //-->
			<section class="search-date">
				<div class="combo">
					<span class="input-text-type-1 calendar" id="sdateSpan"><input type="text" id="sdate" /></span>
					<span class="hyp">-</span>
					<span class="input-text-type-1 calendar" id="edateSpan"><input type="text" id="edate" /></span>
				</div>
				<div class="btn-area">
					<button type="button" class="btn-case-01 btn-search txt" id="btnSearch"><span class="icon ico-search">검색</span></button>
				</div>
			</section>
			<section class="chat-list mt20">
				<ul class="list_v list_cont_wrap" id="roomList">
				</ul>
			</section>
			<!--// content-box -->			
		</div><!-- // pop-content end -->
	</div><!-- // pop-up end -->
	

	<!-- pop-up // 데이터 선택 시, 대화내용 팝업  // -->
	<div id="dataLayer" class="pop msg wrap-pop">
		<div id="dataLayerHeader" class="pop-header">
			<h1>Communication Data</h1>
			<div class="btn-area">
				<button type="button" class="btn-case-01" id="btnExport"><span class="icon ico-export">Export</span></button>
			</div>
		</div>
		<div id="dataLayerContent" class="pop-content">		
		  <form id="frm" method="post" action="/carpe/communication_export.do">
		    <input type="hidden" id="phoneNumber" name="phoneNumber" value="" >
		    <input type="hidden" id="type" name="type" value="" >
		  </form>
			<h4 class="blind">조회된 컨텐츠</h4>
			<!--// Content 영역 //-->
			<div class="chatLog" id="dataList">
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
    $("#roomLayer, #dataLayer").jqxWindow({
        width: 400
      , height: 600
      , resizable: false
      , cancelButton: $('#cancel')
      , autoOpen: false
      , resizable: false
      , isModal: true
      , modalOpacity: 0.3
    });

    $("#sdate").jqxDateTimeInput({
      width: '100%',
      height: '30px',
      formatString: 'yyyy-MM-dd',
      placeHolder: "시작일",
      readonly: true,
      showCalendarButton: false
    });

    $("#edate").jqxDateTimeInput({
      width: '100%',
      height: '30px',
      formatString: 'yyyy-MM-dd',
      placeHolder: "종료일",
      readonly: true,
      showCalendarButton: false
    });

    $("#sdate").val("");
    $("#edate").val("");

    $("#sdateSpan").click(function() {
    	$("#sdate").jqxDateTimeInput('open'); 
    });

    $("#edateSpan").click(function() {
    	$("#edate").jqxDateTimeInput('open'); 
    });

    $("#btnSearch").click(function() {
    	getRoomList();
    });

    $("#btnExport").click(function() {
      exportCommData();
    });

    $("#dataLayerContent").scroll(function() {
      if ($("#dataLayerContent").scrollTop() == ($("#dataList").height() - $("#dataLayerContent").height())) {
        if (commDataLoading == true) {
          return;
        }

        commDataLoading = true;
        sdata += pageCnt;
        getCommData();
      }
    });

	  initGrid();
	  initChart();
	});

	var exportCommData = function() {
		if (!$("#phoneNumber").val()) {
			return;
		}

		$("#frm").submit();
	};

	//////// 대화방 목록 ////////
	var number;

	var openRoomListLayer = function(tmpNumber) {
		number = tmpNumber;
		$("#sdate").val("");
		$("#edate").val("");

		getRoomList();
    $("#roomLayer").jqxWindow('open');
	};

	var getRoomList = function() {
		var data = {
				number: number,
				sdate: $("#sdate").val(),
				edate: $("#edate").val()
		};

	  $.ajax({
	    url: "/carpe/communication_room_list.do",
	    dataType: 'json',
	    data: data,
	    async: false,
	    contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
	    success: function(data) {
		    if (data && data.list) {
		      setRoomLayer(data.list);
			  }
	    }
	  });
	};

	var setRoomLayer = function(list) {
		var html = "";

		if (list.length == 0) {
			html += "<li class=\"empty-data\"> ";
			html += "  <p>해당 기간 조회된 내용이 없습니다.</p> ";
			html += "</li> ";
		} else {
			$.each(list, function(idx, row) {
			  html += "<li onclick=\"openCommDataLayer('" + row.type + "', '" + row.phone_number + "')\" style=\"cursor:pointer;\"> ";
			  html += "	<div class=\"cr-info\"> ";
			  html += "		<h6 class=\"cr-name text-ellipsis\">[" + row.type + "] " + row.phone_number + "</h6> ";
			  html += "		<time class=\"cr-date\" datetime=\"" + row.created_at + "\">" + row.created_at.substr(0, 10) + "</time> ";
			  html += "	</div> ";
			  html += "	<p class=\"chat-data text-ellipsis\" title=\"" + row.message + "\">" + removeTags(row.message) + "</p> ";
			  html += "</li> ";
			});
		}

		$("#roomList").html(html);
	};
	//////// 대화방 목록 End ////////

	//////// 대화창 ////////
	var regdateStr = "";
	var commDataLoading = false;
	var sdata = 0;
	var pageCnt = 50;

	var openCommDataLayer = function(type, phoneNumber) {
		commDataLoading = true;
		regdateStr = "";
		sdata = 0;
		$("#phoneNumber").val(phoneNumber);
		$("#type").val(type);
		$("#dataList").html("");
		getCommData();
    $("#dataLayer").jqxWindow('open');
		$("#dataLayerContent").scrollTop(0);
	};

	var getCommData = function() {
		var data = {
			phoneNumber: $("#phoneNumber").val(),
			type: $("#type").val(),
			sdata: sdata,
			pageCnt: pageCnt 
		};

	  $.ajax({
	    url: "/carpe/communication_data_list.do",
	    dataType: 'json',
	    data: data,
	    async: false,
	    contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
	    success: function(data) {
		    if (data && data.list) {
		      setDataLayer(data.list);
			  }
	    },
	    error : function(xhr, status, error) {
		    console.log(xhr.responseText)
	    },
	    complete: function(xhr, status) {
	    	commDataLoading = false;
		  }
	  });
	};

	var setDataLayer = function(list) {
		var html = "";

		$.each(list, function(idx, row) {
			var otherClass = "";
			var timeStr = "";
			var name = row.phone_number;
			var in_out = row.in_out;
			var regdate = row.created_at;
      var message = row.message;

			if (regdate == null) {
				regdate = "";
			}

			if (regdateStr != regdate.substr(0, 10)) {
				regdateStr = regdate.substr(0, 10);

				if (html != "") {
			    html += "</section> ";
				}

				html += "<section class=\"day-wrap\"> ";
				html += "  <h5>- " + regdate.substr(0, 4) + "년 " + regdate.substr(5, 2) + "월 " + regdate.substr(8, 2) + "일 -</h5> ";
			}

			if (in_out != "Outgoing") {
				otherClass = "other";
			}

			if (regdate != "") {
				timeStr = regdate.substr(11, 2) + ":" + regdate.substr(14, 2);
			}

			if (name == "") {
				name = "(이름없음)";
			}

			html += "	 <div class=\"data_log " + otherClass + "\"> ";
			if (in_out != "Outgoing") {
			  html += "		 <div class=\"name\">" + name + "</div> ";
			  html += "		 <div class=\"log\"> ";
			  html += "			 <span>" + removeTags(message) + "</span> ";
			  html += "			 <time datetime=\"" + regdate + "\">" + timeStr + "</time> ";
			} else {
			  html += "		 <div class=\"log\"> ";
			  html += "			 <time datetime=\"" + regdate + "\">" + timeStr + "</time> ";
			  html += "			 <span>" + removeTags(message) + "</span> ";
			}

			html += "		 </div> ";
			html += "	 </div> ";
		});

		if (html != "") {
	    html += "</section> ";
		}

		$("#dataList").append(html);
	};

  var removeTags = function(str) {
    str = str.replace(/</g,"&lt;");
    str = str.replace(/>/g,"&gt;");
    str = str.replace(/\"/g,"&quot;");
    str = str.replace(/\'/g,"&#39;");
    str = str.replace(/\n/g,"<br />");
    return str;
  }

	//////// 대화창 End ////////

	// 년도 변경
	var setYear = function(val) {
	  location.href = "/carpe/communication.do?year=" + val.value;
	};

	//////// 좌측 Grid ////////
	// 좌측 데이터 그리드 초기화
	var initGrid = function() {
	  $("#setYear").val(${year});

	  var source = {
	    datatype: "json",
	    datafields: [
	      { name: 'phone_number', type: 'string' },
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

    var cellsrenderer = function(row, columnfield, value, defaulthtml, columnproperties) {
      return "<div class=\"jqx-grid-cell-right-align\" style=\"margin-top: 8px;\"><a class=\"gridLink\">" + value + "</a></div>";
    };

	  var columnSet = [
	    {text: 'Number', dataField: 'phone_number', width: 'auto', cellsalign: 'right', align: 'center', cellsrenderer: cellsrenderer},
	    {text: 'Count', dataField: 'cnt', width: '48px', cellsalign: 'center', align: 'center', cellsrenderer: cellsrenderer}
	  ];

	  $('#jqxGrid_Systemlog').on('bindingcomplete', function(event) {
	    var localizationobj = {};
	    localizationobj.emptydatastring = " ";

	    $("#jqxGrid_Systemlog").jqxGrid('localizestrings', localizationobj);
	  });

	  $("#jqxGrid_Systemlog").on("rowclick", function (event) {
		  var args = event.args;
	    var rowIdx = args.rowindex;
	    var rightClick = args.rightclick; 
	    var number = args.row.bounddata.phone_number;

	    if (rightClick == false) {
		    openRoomListLayer(number);
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
	//////// 좌측 Grid End ////////

	//////// Chart1, 2 ////////
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
	        var tmpArr = [list["phone_number"], list["m1"], list["m2"], list["m3"], list["m4"] 
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

	     openRoomListLayer(ev.target.currentText);
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
	  valueAxis.maxPrecision = 0;
//	  valueAxis.max = 40;
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
	  series.columns.template.cursorOverStyle = am4core.MouseCursorStyle.pointer;
	  series.dataFields.valueY = "value" + monthInfo.currentMonth;
	  series.dataFields.categoryX = "country";
	  series.tooltipText = "{categoryX}:{valueY.value}";

	  series.columns.template.events.on("hit", function(ev) {
//	     console.log("clicked on ", ev.target.dataItem.categories.categoryX);

	     openRoomListLayer(ev.target.dataItem.categories.categoryX);
	  }, this);
	
	
	  // this makes columns to be of a different color, depending on value
	  series.heatRules.push({ target: series.columns.template, property: "fill", minValue: 0, min: am4core.color("#673AB7"), max: am4core.color("#F44336"), dataField: "valueY" });
	
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

	//////// Chart1, 2 End ////////
			
	<!-- // 현재 페이지에 필요한 js -->
	</script>

</body>
</html>