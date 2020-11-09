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
  <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${ncpClientId}"></script>
  <script type="text/javascript" src="/carpe/resources/naverapi/marker-clustering/src/MarkerClustering.js"></script>
  <style>
  .mapLink {cursor: pointer;}
  .mapLink:hover {text-decoration: underline;}
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
      <c:param name="d2" value="locationmap"></c:param>
    </c:import>
    <!-- // nav -->

    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
        <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
        <c:import url="../common/location_area.jsp">
		      <c:param name="d1" value="visualization"></c:param>
          <c:param name="d2" value="locationmap"></c:param>
        </c:import>
      </section>

      <article class="container">
        <h4 class="blind">행위 갯수</h4>
        <!--// Content 영역 //-->
        <!--// Side 메뉴가 우측에 있는 형태의 jqx-widget //-->
        <div class="content-box">
          <div class="content-area">
            <div class="map-area" id="map"><!-- 지도 영역 //-->
              <!-- <a href="#" class="btn map-pin ir">위치1</a>
              <div class="map-func-btns">
                <button type="button" class="btn plus ir">지도 확대</button>
                <button type="button" class="btn minus ir">지도 축소</button>
              </div> -->
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
  <div id="mapInfo" class="pop wrap-pop">
    <div class="pop-header">
      <h1>지도 정보</h1>
    </div>
    <div class="pop-content">
      <div class="data-type-1">
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
        <dl>
          <dt>커뮤니케이션</dt>
          <dd>
            <div>
               <button type="button" class="btn-case-01 txt" id="btnComm">커뮤니케이션</button>
            </div>
          </dd>
        </dl>
        <dl>
          <dt>파일</dt>
          <dd>
            <div>
               <button type="button" class="btn-case-01 txt" id="btnFile">파일</button>
            </div>
          </dd>
        </dl>
      </div>
    </div><!-- // pop-content end -->
  </div><!-- // pop-up end -->
  
  
  <!-- pop-up // 대화목록 팝업  // -->
  <div id="roomLayer" class="pop chatroom wrap-pop">
    <div class="pop-header">
      <h1>Communication Data</h1>
    </div>
    <div class="pop-content">    
      <h4 class="blind">대화 목록</h4>
      <!--// Content 영역 //-->
      <section class="search-date">
        <div class="combo">
          <span class="input-text-type-1 calendar" id="sdateSpan" style="cursor:pointer;"><input type="text" id="sdate" placeholder="시작일" /></span>
          <span class="hyp">-</span>
          <span class="input-text-type-1 calendar" id="edateSpan" style="cursor:pointer;"><input type="text" id="edate" placeholder="종료일" /></span>
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
    <div class="pop-header">
      <h1>Communication Data</h1>
      <div class="btn-area">
        <button type="button" class="btn-case-01" id="btnExport"><span class="icon ico-export">Export</span></button>
      </div>
    </div>
    <div class="pop-content" id="dataLayerContent">    
      <form id="frm" method="post" action="/carpe/communication_export.do">
        <input type="hidden" id="phoneNumber" name="phoneNumber" value="" >
        <input type="hidden" id="chatroomId" name="chatroomId" value="" >
		    <input type="hidden" id="type" name="type" value="" >
      </form>
      <h4 class="blind">조회된 컨텐츠</h4>
      <!--// Content 영역 //-->
      <div class="chatLog" id="dataList">
      </div><!--// content-box -->      
    </div><!-- // pop-content end -->
  </div><!-- // pop-up end -->

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

  <!-- pop-up //이동 경로 설정-->
  <div id="moveConfigPop" class="pop wrap-pop">
    <div class="pop-header">
      <h1>이동 경로 설정</h1>
    </div>
    <div class="pop-content">
      <section class="search-date">
        <div class="array combo">
              <span class="input-text-type-1 calendar" id="mcSdateSpan" style="cursor:pointer;"><input type="text" id="mcSdate" placeholder="시작일" /></span>
              <span class="hyp">-</span>
              <span class="input-text-type-1 calendar" id="mcEdateSpan" style="cursor:pointer;"><input type="text" id="mcEdate" placeholder="종료일" /></span>
              </div>
      </section>
      <section class="btn-area">
        <ul>
          <li><button type="button" class="btn-case-01" id="btnMcOK">확인</button></li>
          <li><button type="button" class="btn-case-01" id="btnMcCancel">취소</button></li>
        </ul>
      </section>
    </div><!-- // pop-content end -->
  </div><!-- // pop-up end -->

  <!-- pop-up //이동 경로 설정-->
  <div id="timeLinePop" class="pop wrap-pop">
    <div class="pop-header">
      <h1>분석 시점 설정</h1>
    </div>
    <div class="pop-content">
      <section>
        <div class="tit-area"><h3 class="unit">분석 시점 검색</h3></div>
        <div class="array mt10">
          <ul class="list-v">
            <li>
              <div class="array combo">
                <span class="input-text-type-1 calendar" id="tlSdateSpan" style="cursor:pointer;"><input type="text" id="tlSdate" placeholder="시작일" /></span>
                <span class="hyp">-</span>
                <span class="input-text-type-1 calendar" id="tlEdateSpan" style="cursor:pointer;"><input type="text" id="tlEdate" placeholder="종료일" /></span>
              </div>
            </li>
            <li class="mt5">
              <div class="array combo">
                <span class="input-text-type-1 calendar" id="tlStimeSpan" style="cursor:pointer;"><input type="text" id="tlStime" placeholder="시작시간" /></span>
                <span class="hyp">-</span>
                <span class="input-text-type-1 calendar" id="tlEtimeSpan" style="cursor:pointer;"><input type="text" id="tlEtime" placeholder="종료시간" /></span>
              </div>
            </li>
          </ul>
        </div>
        <div class="array mt10">
          <ul class="list-h w3ea">
            <li>
              <div class="checkbox checkbox-type-3">
                <input id="chk1" name="chk1" type="checkbox" />
                <label for="chk1" style="cursor: pointer;"><span class="text">공휴일만</span></label>
              </div>
            </li>
            <li>
              <div class="checkbox checkbox-type-3">
                <input id="chk2" name="chk2" type="checkbox" />
                <label for="chk2" style="cursor: pointer;"><span class="text">공휴일만 제외</span></label>
              </div>
            </li>
            <li>
              <div class="checkbox checkbox-type-3">
                <input id="chk3" name="chk3" type="checkbox" />
                <label for="chk3" style="cursor: pointer;"><span class="text">주말만</span></label>
              </div>
            </li>
            <li>
              <div class="checkbox checkbox-type-3">
                <input id="chk4" name="chk4" type="checkbox" />
                <label for="chk4" style="cursor: pointer;"><span class="text">주말만 제외</span></label>
              </div>
            </li>
            <li>
              <div class="checkbox checkbox-type-3">
                <input id="chk5" name="chk5" type="checkbox" />
                <label for="chk5" style="cursor: pointer;"><span class="text">첫 데이터만</span></label>
              </div>
            </li>
            <li>
              <div class="checkbox checkbox-type-3">
                <input id="chk6" name="chk6" type="checkbox" />
                <label for="chk6" style="cursor: pointer;"><span class="text">마지막 데이터만</span></label>
              </div>
            </li>
          </ul>
        </div>     
        <div class="array btn-area mt10">
          <ul class="fl w100p">
            <li>
              <button type="button" class="btn-case-01 bk" id="btnWork"><span class="icon">업무시간</span></button>
            </li>
            <li>
              <button type="button" class="btn-case-01 bk" id="btnNotWork"><span class="icon">비업무시간</span></button>
            </li>
            <li class="fr">
              <button type="button" class="btn-case-01 btn-search txt" id="btnTlSearch"><span class="icon ico-search">검색</span></button>
            </li>
          </ul>
        </div>
      </section>
          <section class="mt20">
        <div class="tit-area"><h3 class="unit">타임라인</h3></div>
            <div id="chartDiv" style="height:10rem;"></div>
            <div class="route" id="pathList">
            </div>
          </section>
      </div>
  </div><!-- // pop-up end -->

  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/core.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/charts.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/themes/animated.js"></script>
  
  <!-- 현재 페이지에 필요한 js -->
  <script>
  var map = null;
  var polyLine = null;
  var chart = null;
  var xAxis = null;

  $(document).ready(function() {
    initMap();
    initMapGrid();
    initFileGrid();
    initPopup();
    initChart();

    $("#btnComm").click(openRoomListLayer);

    $("#btnSearch").click(getRoomList);

    $("#btnFile").click(function() {
      $("#jqxGrid_fileInfo").jqxGrid('updateBoundData');
      $("#fileInfo").jqxWindow('open');
    });

    $.datetimepicker.setLocale("ko");
    
    $("#sdate, #edate").datetimepicker({
      format: "Y-m-d H:i:00",
      step: 10
    });

    $("#mcSdate, #mcEdate").datetimepicker({
      format: "Y-m-d H:i:00",
      step: 10
    });

    $("#tlSdate, #tlEdate").datetimepicker({
      format: "Y-m-d",
      timepicker: false
    });

    $("#tlStime, #tlEtime").datetimepicker({
      format: "H:i:00",
      datepicker: false,
      step: 10
    });

    $("#sdate").val("");
    $("#edate").val("");
    
    $("#sdateSpan").click(function() {
      $("#sdate").datetimepicker("show"); 
    });
    
    $("#edateSpan").click(function() {
      $("#edate").datetimepicker("show"); 
    });

    $("#mcSdateSpan").click(function() {
      $("#mcSdate").datetimepicker("show"); 
    });
    
    $("#mcEdateSpan").click(function() {
      $("#mcEdate").datetimepicker("show"); 
    });

    $("#tlSdateSpan").click(function() {
      $("#tlSdate").datetimepicker("show"); 
    });
    
    $("#tlEdateSpan").click(function() {
      $("#tlEdate").datetimepicker("show"); 
    });

    $("#tlStimeSpan").click(function() {
      $("#tlStime").datetimepicker("show"); 
    });
    
    $("#tlEtimeSpan").click(function() {
      $("#tlEtime").datetimepicker("show"); 
    });

    $("#btnExport").click(function() {
      exportCommData();
    });

    $("#chk1").change(function() {
      if ($(this).prop("checked") == true) {
        $("#chk2").prop("checked", false);
      }
    });

    $("#chk2").change(function() {
      if ($(this).prop("checked") == true) {
        $("#chk1").prop("checked", false);
      }
    });

    $("#chk3").change(function() {
      if ($(this).prop("checked") == true) {
        $("#chk4").prop("checked", false);
      }
    });

    $("#chk4").change(function() {
      if ($(this).prop("checked") == true) {
        $("#chk3").prop("checked", false);
      }
    });

    $("#chk5").change(function() {
      if ($(this).prop("checked") == true) {
        $("#chk6").prop("checked", false);
      }
    });

    $("#chk6").change(function() {
      if ($(this).prop("checked") == true) {
        $("#chk5").prop("checked", false);
      }
    });

    $("#btnMcOK").click(function() {
      var sdate = $("#mcSdate").val();
      var edate = $("#mcEdate").val();

      if (!sdate || !edate) {
        alert("시간을 입력해주세요");
        return;
      }

      var sendData = {
          sdate: sdate,
          edate: edate,
          mode: 0
      };

      var data = getLinkList(sendData);
      drawPolyLine(data.list);
      moveMap(data.list);

      if (data.list.length > 0) {
        $("#moveConfigPop").jqxWindow('close');
      }
    });

    //업무시간
    $("#btnWork").click(function() {
      $("#tlStime").val("09:00:00");
      $("#tlEtime").val("17:59:59");
    });

    //비업무시간
    $("#btnNotWork").click(function() {
      $("#tlStime").val("18:00:00");
      $("#tlEtime").val("08:59:59");
    });

    $("#btnTlSearch").click(function() {
      makeTimeLine();
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

    //맵 커스텀 버튼 생성
    naver.maps.Event.once(map, 'init_stylemap', function() {
      var btnAnaly = "<button type=\"button\" class=\"btn-case-01 txt mt10 mr20\">분석 시점 설정</button>";
      var btnMove = "<button type=\"button\" class=\"btn-case-01 txt mt10 mr20\">이동 경로 설정</button>";
      
      var analyControl = new naver.maps.CustomControl(btnAnaly, {
        position: naver.maps.Position.RIGHT_TOP
      });

      var moveControl = new naver.maps.CustomControl(btnMove, {
        position: naver.maps.Position.RIGHT_TOP
      });
      
      analyControl.setMap(map);
      moveControl.setMap(map);

      naver.maps.Event.addDOMListener(analyControl.getElement(), 'click', function() {
        $("#moveConfigPop").jqxWindow('close');
        $("#timeLinePop").jqxWindow('open');
      });

      naver.maps.Event.addDOMListener(moveControl.getElement(), 'click', function() {
        $("#mapInfo").jqxWindow('close');
        $("#timeLinePop").jqxWindow('close');
        $("#moveConfigPop").jqxWindow('open');
      });
    });

    //nav 열린 상태로 grid 호출시 사이즈 이상 조치용
    $(".nav").hover(function() {
      window.dispatchEvent(new Event('resize'));
    });
  });

  var initMap = function() {
    //지도 api 객체 생성
    map = new naver.maps.Map('map', {
      center: new naver.maps.LatLng(37.5642135, 127.0016985),
      zoom: 11
    });

    //PolyLine 객체
    polyLine = new naver.maps.Polyline({
      map: map,
      strokeWeight: 3, //두께
      strokeColor: '#db4040', //색
      strokeOpacity: 0.7, //불투명도
      strokeStyle: "solid",
      startIcon: naver.maps.PointingIcon.CIRCLE,
      endIcon: naver.maps.PointingIcon.BLOCK_ARROW
    });

    //마커 생성
    $.get("/carpe/gps/gps_list.do", function(data) {
      // 데이터에서 좌표 값을 가지고 마커를 표시합니다
      // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
      var markers = $(data.list).map(function(i, position) {
        var marker = new naver.maps.Marker({
          position : new naver.maps.LatLng(position.latitude, position.longitude),
          title : position.contents,
          clickable: true 
        });

        naver.maps.Event.addListener(marker, 'click', function() {
          viewMapInfo(position.contents, position.timestamp, position.package_name);
        });

        return marker;
      });

      var htmlMarker1 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-1.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
      },
      htmlMarker2 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-2.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
      },
      htmlMarker3 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-3.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
      },
      htmlMarker4 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-4.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
      },
      htmlMarker5 = {
        content: '<div style="cursor:pointer;width:40px;height:40px;line-height:42px;font-size:10px;color:white;text-align:center;font-weight:bold;background:url(/carpe/resources/naverapi/marker-clustering/images/cluster-marker-5.png);background-size:contain;"></div>',
        size: N.Size(40, 40),
        anchor: N.Point(20, 20)
      };
      
      // 클러스터러에 마커들을 추가
      var clusterer = new MarkerClustering({
        minClusterSize: 2,
        maxZoom: 15,
        map: map,
        markers: markers,
        disableClickZoom: false,
        gridSize: 120,
        icons: [htmlMarker1, htmlMarker2, htmlMarker3, htmlMarker4, htmlMarker5],
        indexGenerator: [5, 10, 15, 20, 25],
        stylingFunction: function(clusterMarker, count) {
          $(clusterMarker.getElement()).find('div:first-child').text(count);
        }
      });
    });
  };

  var initPopup = function() {
    //지도정보 Window
    $("#mapInfo").jqxWindow({
        width: '65rem'
      , height: '29rem'
      , position: {x: 'calc(50% - 10rem)', y: '16rem'}
      , resizable: false
      , autoOpen: false
      , resizable: false
      , isModal: false
      , modalOpacity: 0.3
    });

    //대화리스트 Window
    $("#roomLayer").jqxWindow({
        width: '52rem'
      , height: '60rem'
      , resizable: false
      , autoOpen: false
      , resizable: false
      , isModal: true
      , modalOpacity: 0.3
    });

    //대화상세 Window
    $("#dataLayer").jqxWindow({
        width: '40rem'
      , height: '60rem'
      , resizable: false
      , autoOpen: false
      , resizable: false
      , isModal: true
      , modalOpacity: 0.3
    });

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

    //설정 Window
    var mapObj = $("#map");
    var left = mapObj.offset().left;
    var right = mapObj.offset().left + mapObj.width();
    var top = mapObj.offset().top;

    //이동경로설정 Window
    $("#moveConfigPop").jqxWindow({
        width: '42rem'
      , height: '17rem'
      , resizable: false
      , cancelButton: $("#btnMcCancel")
      , autoOpen: false
      , resizable: false
      , isModal: true
      , modalOpacity: 0.3
    });

    //분석시점설정 Window
    $("#timeLinePop").jqxWindow({
        width: '42rem'
      , height: '75rem'
      , resizable: false
      , autoOpen: false 
      , resizable: false
      , isModal: false 
      , position: [left, top]
      , modalOpacity: 0.3
    });
  };

  // TimeLine Chart 초기화
  var initChart = function() {
    // Themes begin
    am4core.useTheme(am4themes_animated);
    am4core.options.commercialLicense = true;
    // Themes end
        
    chart = am4core.create("chartDiv", am4charts.XYChart);

    // X축
    xAxis = chart.xAxes.push(new am4charts.DateAxis());
    xAxis.renderer.grid.template.location = 0;
    xAxis.renderer.inside = true;
    xAxis.renderer.visible = false;
    xAxis.snapTooltip = false;
    xAxis.tooltipPosition = "fixed";
    xAxis.tooltipDateFormat = "yyyy-MM-dd eee";
    xAxis.tooltip.dy = 33;
    xAxis.tooltip.background.pointerLength = 0;

    // Y축
    var yAxis = chart.yAxes.push(new am4charts.ValueAxis());
    yAxis.renderer.inside = true;
    yAxis.renderer.visible = false;
    yAxis.cursorTooltipEnabled = false;

    // Value
    var series = chart.series.push(new am4charts.ColumnSeries());
    series.dataFields.valueY = "cnt";
    series.dataFields.dateX = "timestamp";
    series.columns.template.tooltipText = "[bold]{valueY}[/]";
    series.columns.template.fillOpacity = .8;

    series.columns.template.events.on("hit", function(ev) {
      var sdate = ev.target.dataItem.dataContext.timestamp;
      var edate = ev.target.dataItem.dataContext.timestamp;

      $("input:checkbox[id^='chk']").prop("checked", false);

      $("#tlSdate").val(sdate);
      $("#tlEdate").val(edate);
      $("#tlStime").val("");
      $("#tlEtime").val("");

      makeTimeLine();
    });

    var columnTemplate = series.columns.template;
    columnTemplate.strokeWidth = 2;
    columnTemplate.strokeOpacity = 1;

    //Cursor
    chart.cursor = new am4charts.XYCursor();
    chart.cursor.xAxis = xAxis;
    chart.cursor.lineY.disabled = true;
    chart.cursor.lineX.strokeWidth = 0;
    chart.cursor.lineX.fill = am4core.color("#8F3985");
    chart.cursor.lineX.fillOpacity = 0.1;
    chart.cursor.fullWidthLineX = true;

    //Scroll
    chart.scrollbarX = new am4core.Scrollbar();
    chart.scrollbarX.parent = chart.bottomAxesContainer;
    chart.scrollbarX.minHeight = 10;
    chart.scrollbarX.marginBottom = 0;
    chart.scrollbarX.startGrip.icon.disabled = true;
    chart.scrollbarX.endGrip.icon.disabled = true;
  };

  //TimeLine 생성
  var makeTimeLine = function() {
    var sdate = $("#tlSdate").val();
    var edate = $("#tlEdate").val();
    var stime = $("#tlStime").val();
    var etime = $("#tlEtime").val();

    if (!sdate || !edate) {
      alert("시간을 입력해주세요");
      return;
    }

    if (stime == "" || etime == "") {
      $("#tlStime").val("");
      $("#tlEtime").val("");
      stime = "";
      etime = "";
    }

    sdate += " 00:00:00";
    edate += " 23:59:59";

    var sendData = {
        sdate: sdate,
        edate: edate,
        stime: stime,
        etime: etime,
        mode: 1
    };

    $("input:checkbox[id^='chk']").each(function() {
      if ($(this).is(":checked")) {
        sendData[$(this).attr("id")] = 1;
      }
    });

    var data = getLinkList(sendData);
    makeDateCountChart(sdate, edate);
    moveMap(data.list);
    drawPolyLine(data.list);
    makePathList(data.list);
  };

  // map marker click event
  var viewMapInfo = function(contents, timestamp, package_name) {
    var sdate = timestamp.substr(0, 10) + " 00:00:00";
    var edate = timestamp.substr(0, 10) + " 23:59:59";
    var sendData = {
        sdate: sdate,
        edate: edate,
        mode: 0
    };

    var data = getLinkList(sendData);
    drawPolyLine(data.list);
    $("#infoTime").html(timestamp);
    $("#infoLocation").html(contents);
    $("#infoSource").html(package_name);
    $("#mapInfo").jqxWindow('open');
  };

  var getLinkList = function(sendData) {
    var retData = null;

    $.ajax({
      url: "/carpe/gps/gps_link_list.do",
      dataType:'json',
      data: sendData,
      async: false,
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      success: function(data) {
        var ret = data.ret;
        var msg = data.msg;

        if (ret != "0") {
          alert(msg);
        }

        retData = data;
      }
    });

    return retData;
  };

  var moveMap = function(data) {
    $(data).each(function(i, list) {
      map.setCenter(new naver.maps.LatLng(list.latitude, list.longitude));
      map.setZoom(13, true);
      return false;
    });
  };

  //차트 데이터 변경
  var makeDateCountChart = function(sdate, edate) {
    $.ajax({
      url: "/carpe/gps/gps_date_count.do",
      dataType:'json',
      data: {
        sdate : sdate,
        edate : edate
      },
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      success: function(data) {
        xAxis.min = new Date(sdate.substr(0, 10)).getTime();
        xAxis.max = new Date(edate.substr(0, 10)).getTime();
        chart.data = data.list;
      }
    });
  };

  //라인 생성
  var drawPolyLine = function(data) {
    var linePath = [];

    $(data).each(function(i, list) {
      linePath[i] = new naver.maps.LatLng(list.latitude, list.longitude);
    });

    polyLine.setPath(linePath);
    console.log(linePath.length);
  };

  //Map Grid
  var initMapGrid = function() {
    var source = {
      datatype: "json",
      datafields: [
        { name: 'serial_number', type: 'number' },
        { name: 'timestamp', type: 'string' },
        { name: 'package_name', type: 'string' },
        { name: 'contents', type: 'string' },
        { name: 'latitude', type: 'string' },
        { name: 'longitude', type: 'string' },
        { name: 'source', type: 'string' },
        { name: 'is_visited', type: 'string' }
      ],
      type : "POST",
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      url: "/carpe/gps/gps_list.do"
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
      {text: 'Timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'right', align: 'center'},
      {text: 'Application', dataField: 'package_name', width: '15%', cellsalign: 'left', align: 'center'},
      {text: 'Contents', dataField: 'contents', width: 'auto', cellsalign: 'left', align: 'center'},
      {text: 'Latitude', dataField: 'latitude', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'Longitude', dataField: 'longitude', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'Source', dataField: 'source', width: '15%', cellsalign: 'left', align: 'center'},
      {text: 'Is visited', dataField: 'is_visited', width: '10%', cellsalign: 'center', align: 'center'}
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

  //File Grid
  var initFileGrid = function() {
    var source = {
      datatype: "json",
      datafields: [
        { name: 'type', type: 'string' },
        { name: 'regdate', type: 'string' },
        { name: 'name', type: 'string' }
      ],
      type : "POST",
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      url: "/carpe/gps/file_list.do"
    };
    
    var dataAdapter = new $.jqx.dataAdapter(source, {
      contentType : 'application/json; charset=utf-8',
      formatData : function(data) {
        data.regdate = $("#infoTime").text();
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
      {text: 'Type', dataField: 'type', width: '20%', cellsalign: 'center', align: 'center'},
      {text: 'Timestamp', dataField: 'regdate', width: '30%', cellsalign: 'left', align: 'center'},
      {text: 'File Name', dataField: 'name', width: 'auto', cellsalign: 'left', align: 'center'}
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

  //TimeLine 경로 리스트 생성
  var makePathList = function(list) {
    var html = "";
    console.log(list);

    $(list).each(function(i, data) {
      if (html != "") {
        var prevData = list[i - 1];
        var diff = data.regdate.time - prevData.regdate.time;
        var h = Math.ceil(diff / (1000 * 60 * 60));
        diff = diff % (1000 * 60 * 60);
        var m = Math.ceil(diff / (1000 * 60));

        var latLng1 = new naver.maps.LatLng(data.latitude, data.longitude);
        var latLng2 = new naver.maps.LatLng(prevData.latitude, prevData.longitude);
        var distance = map.getProjection().getDistance(latLng1, latLng2);

        var distStr = "";
        var moveStr = "";

        if (distance < 1000) {
          distance = Math.round(distance);
          distStr = "이동 - " + distance + "미터 ";
        } else {
          distance = Math.round(distance / 100) / 10;
          distStr = "이동 - " + distance + "km ";
        }

        moveStr = distStr;

        if (h > 0) {
          moveStr += h + "시간 ";
        }
        
        moveStr += m + "분";
        
        html += "<dl><dd>" + moveStr + "</dd></dl>";
      }

      html += "<dl><dt><span><a class=\"mapLink\" onClick=\"movePosition('" + data.latitude + "', '" + data.longitude + "');\">" + data.contents + "</a></span><p>" + data.timestamp + "</p></dt></dl>";
    });

    $("#pathList").html(html);
  };

  var movePosition = function(lat, lng) {
    var tmp = new Array({latitude: lat, longitude: lng});
    moveMap(tmp);
  };


  //////// 대화방 목록 ////////
  var openRoomListLayer = function() {
    $("#sdate").datetimepicker("setOptions", {value: $("#infoTime").text()});
    $("#edate").datetimepicker("setOptions", {value: $("#infoTime").text()});

    var date = $("#sdate").datetimepicker("getValue");
    date.setHours(date.getHours() - 1);
    $("#sdate").datetimepicker("setOptions", {value: date});
    date.setHours(date.getHours() + 2);
    $("#edate").datetimepicker("setOptions", {value: date});
    
    getRoomList();

    $("#roomLayer").jqxWindow('open');
  }

  var getRoomList = function() {
    var data = {
      sdate: $("#sdate").val(),
      edate: $("#edate").val()
    };
  
    $.ajax({
      url: "/carpe/gps/communication_room_list.do",
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
        var type = row.type;
        var phone_number = row.phone_number;
        var name = row.name;
        var message = row.message;
        var created_at = row.created_at;
        var members = row.members;
        var chatroom_id = row.chatroom_id;

        var roomName = phone_number;

        if (type == "KAKAOTALK" && name != "") {
          roomName = name;

          var tmpArr = members.split(",");
          var cnt = tmpArr.length;

          if (cnt > 1) {
            roomName += " 외 " + (cnt - 1) + "명";
          }
        }

			  html += "<li onclick=\"openCommDataLayer('" + type + "', '" + phone_number + "', '" + chatroom_id + "');\" style=\"cursor:pointer;\"> ";
			  html += "	<div class=\"cr-info\"> ";
			  html += "		<h6 class=\"cr-name text-ellipsis\">[" + type + "] " + roomName + "</h6> ";
			  html += "		<time class=\"cr-date\" datetime=\"" + created_at + "\">" + created_at.substr(0, 10) + "</time> ";
			  html += "	</div> ";
			  html += "	<p class=\"chat-data text-ellipsis\" title=\"" + message + "\">" + removeTags(message) + "</p> ";
			  html += "</li> ";
			});
    }
  
    $("#roomList").html(html);
  };

  var removeTags = function(str) {
    str = str.replace(/</g,"&lt;");
    str = str.replace(/>/g,"&gt;");
    str = str.replace(/\"/g,"&quot;");
    str = str.replace(/\'/g,"&#39;");
    str = str.replace(/\n/g,"<br />");
    return str;
  }
  //////// 대화방 목록 End ////////

  //////// 대화창 ////////
  var regdateStr = "";
  var commDataLoading = false;
  var sdata = 0;
  var pageCnt = 50;
  
	var openCommDataLayer = function(type, phoneNumber, chatroomId) {
		commDataLoading = true;
		regdateStr = "";
		sdata = 0;
		$("#phoneNumber").val(phoneNumber);
		$("#chatroomId").val(chatroomId);
		$("#type").val(type);
		$("#dataList").html("");
		getCommData();
    $("#dataLayer").jqxWindow('open');
		$("#dataLayerContent").scrollTop(0);
	};
  
  var getCommData = function() {
    var data = {
			phoneNumber: $("#phoneNumber").val(),
			chatroomId: $("#chatroomId").val(),
			type: $("#type").val(),
			sdata: sdata,
			pageCnt: pageCnt 
    };
  
    $.ajax({
      url: "/carpe/gps/communication_data_list.do",
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
  
      html += "     </div> ";
      html += "   </div> ";
    });
  
    if (html != "") {
      html += "</section> ";
    }
  
    $("#dataList").append(html);
  };

  //////// 대화창 End ////////

  var exportCommData = function() {
    if (!$("#phoneNumber").val() && !$("#chatroomId").val()) {
      return;
    }

    $("#frm").submit();
  };
  
  </script>

</body>
</html>