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
		<div class="pop-header">
			<h1>Communication Data</h1>
			<div class="btn-area">
				<button type="button" class="btn-case-01" id="btnExport"><span class="icon ico-export">Export</span></button>
			</div>
		</div>
		<div class="pop-content" id="dataLayerContent">		
		  <form id="frm" method="post" action="/carpe/communication_export.do">
		    <input type="hidden" id="roomno" name="roomno" value="" >
		  </form>
			<h4 class="blind">조회된 컨텐츠</h4>
			<!--// Content 영역 //-->
			<div class="chatLog" id="dataList">
			</div><!--// content-box -->			
		</div><!-- // pop-content end -->
	</div><!-- // pop-up end -->

	<!-- pop-up //-->
	<div id="fileInfo" class="pop wrap-pop">
		<div class="pop-header jqx-window-header">
			<h1>파일 정보</h1>
		</div>
		<div class="pop-content">
			<div id="jqxGrid_fileInfo" class="data-tbl-area">
			</div><!--// content-box -->			
		</div><!-- // pop-content end -->
	</div><!-- // pop-up end -->
	
	
	<!-- 현재 페이지에 필요한 js -->
	<script>
	(function($) {
		var map = null;
		var polyLine = null;

		$(document).ready(function() {
			init();
      initMapGrid();
      initFileGrid();

      $("#btnComm").click(openRoomListLayer);

      $("#btnSearch").click(getRoomList);

      $("#btnFile").click(function() {
        $("#jqxGrid_fileInfo").jqxGrid('updateBoundData');
        $("#fileInfo").jqxWindow('open');
      });

      $.datetimepicker.setLocale("ko");
      
      $("#sdate, #edate").datetimepicker({
        format: "Y-m-d H:i:s",
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
		});

		var init = function() {
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
		        title : position.source,
		        clickable: true 
		      });

		      naver.maps.Event.addListener(marker, 'click', function() {
		    		viewMapInfo(position.location, position.regd, position.source);
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

      //지도정보 Window
      $("#mapInfo").jqxWindow({
          width: '40rem'
        , height: '29rem'
        , position: {x: 'calc(50% - 10rem)', y: '16rem'}
        , resizable: false
        , cancelButton: $('#cancel')
        , autoOpen: false
        , resizable: false
        , isModal: true
        , modalOpacity: 0.3
      });

      //대화리스트 Window
      $("#roomLayer").jqxWindow({
          width: '52rem'
        , height: '60rem'
        , resizable: false
        , cancelButton: $('#cancel')
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
        , cancelButton: $('#cancel')
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
        , cancelButton: $('#cancel')
        , autoOpen: false
        , resizable: false
        , isModal: true
        , modalOpacity: 0.3
      });
		};

    // map marker click event
		var viewMapInfo = function(location, regd, source) {
	   	getLinkList(regd);
	   	$("#infoTime").html(regd);
	   	$("#infoLocation").html(location);
	   	$("#infoSource").html(source);
      $("#mapInfo").jqxWindow('open');
		};

		var getLinkList = function(regdate) {
		  $.ajax({
			  url: "/carpe/gps/gps_link_list.do",
		    dataType:'json',
		    data: { regdate : regdate},
		    async: false,
		    contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
		    success: function(data) {
		      var linePath = [];

		      $(data.list).each(function(i, list) {
		    	  linePath[i] = new naver.maps.LatLng(list.latitude, list.longitude);
		      });

		      console.log(linePath.length);
		   	
			    polyLine.setPath(linePath);
		    }
		  });
		};

		//Map Grid
    var initMapGrid = function() {
		  var source = {
        datatype: "json",
        datafields: [
          { name: 'serial_number', type: 'number' },
          { name: 'regd', type: 'string' },
          //{ name: 'gps_type', type: 'string' },
          { name: 'source', type: 'string' },
          { name: 'location', type: 'string' },
          { name: 'latitude', type: 'string' },
          { name: 'longitude', type: 'string' }
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
		  	{text: 'Timestamp', dataField: 'regd', width: '10%', cellsalign: 'right', align: 'center'},
		  	//{text: 'Type', dataField: 'gps_type', width: '18%', cellsalign: 'center', align: 'center'},
		  	{text: 'Application', dataField: 'source', width: '10%', cellsalign: 'center', align: 'center'},
		  	{text: 'Keyword', dataField: 'location', width: 'auto', cellsalign: 'center', align: 'center'},
		  	{text: 'Latitude', dataField: 'latitude', width: '10%', cellsalign: 'center', align: 'center'},
		  	{text: 'Longitude', dataField: 'longitude', width: '10%', cellsalign: 'center', align: 'center'}
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

	})(jQuery);

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
			  html += "<li onclick=\"openCommDataLayer('" + row.roomno + "')\"> ";
			  html += "	<div class=\"cr-info\"> ";
			  html += "		<h6 title=\"" + row.name + "\" class=\"cr-name text-ellipsis\">" + row.name + "</h6> ";
			  html += "		<time class=\"cr-date\" datetime=\"" + row.regdate + "\">" + row.regdate.substr(0, 10) + "</time> ";
			  html += "	</div> ";
			  html += "	<p class=\"chat-data text-ellipsis\" title=\"" + row.content + "\">" + row.content + "</p> ";
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
  
	var openCommDataLayer = function(tmpRoomno) {
		commDataLoading = true;
		regdateStr = "";
		sdata = 0;
		$("#roomno").val(tmpRoomno);
		$("#dataList").html("");
		getCommData();
    $("#dataLayer").jqxWindow('open');
		$("#dataLayerContent").scrollTop(0);
	};
  
	var getCommData = function() {
		var data = {
			roomno: $("#roomno").val(),
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
			var name = row.sender_name;
			var regdate = row.regdate;
  
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
  
			if (row.msg_type != "발신") {
				otherClass = "other";
			}
  
			if (regdate != "") {
				timeStr = regdate.substr(11, 2) + ":" + regdate.substr(14, 2);
			}
  
			if (name == "") {
				name = "(이름없음)";
			}
  
			html += "	 <div class=\"data_log " + otherClass + "\"> ";
			if (row.msg_type != "발신") {
			  html += "		 <div class=\"name\">" + name + "</div> ";
			  html += "		 <div class=\"log\"> ";
			  html += "			 <span>" + row.content + "</span> ";
			  html += "			 <time datetime=\"" + regdate + "\">" + timeStr + "</time> ";
			} else {
			  html += "		 <div class=\"log\"> ";
			  html += "			 <time datetime=\"" + regdate + "\">" + timeStr + "</time> ";
			  html += "			 <span>" + row.content + "</span> ";
			}
  
			html += "		 </div> ";
			html += "	 </div> ";
		});
  
		if (html != "") {
	    html += "</section> ";
		}
  
		$("#dataList").append(html);
	};

	//////// 대화창 End ////////

	var exportCommData = function() {
		if (!$("#roomno").val()) {
			return;
		}

		$("#frm").submit();
	};
	
	</script>

</body>
</html>