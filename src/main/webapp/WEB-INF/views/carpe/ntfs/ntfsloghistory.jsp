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
  <link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" type="text/css" href="/carpe/resources/css/style.css" />
  <link rel="stylesheet" type="text/css" href="/carpe/resources/css/jquery.datetimepicker.min.css" />
  <link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">

</head>
<body>

  <!-- wrap -->
  <div class="wrap usage-m bg-theme blue">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>
    <!-- // header -->

    <!-- nav -->
    <c:import url="../common/left_nav.jsp">
      <c:param name="d1" value="visualization"></c:param>
      <c:param name="d2" value="ntfsloghistory"></c:param>
    </c:import>
    <!-- // nav -->
    
    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%> </h3>
        <button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button>
        <c:import url="../common/location_area.jsp">
		      <c:param name="d1" value="visualization"></c:param>
          <c:param name="d2" value="ntfsloghistory"></c:param>
        </c:import>
      </section>

      <article class="container">
        <h4 class="blind">조회된 컨텐츠</h4>

        <!--// Content 영역 //-->
        <div id="jqxSplitter" class="content-box jqx-splitter-panel">
          <div class="content-area" style="padding:0px;">
            <div class="tit-area">
              <div class="select" style="margin-right:5px;">
                <select id="selYear">
                  <c:forEach var="data" items="${yearList}" varStatus="status">
                    <option value="${data.year}" <c:if test="${status.last}">selected</c:if>>${data.year}년</option>
                  </c:forEach>
                </select>
              </div>
              <div class="select" style="margin-right:5px;">
                <select id="selMonth">
                  <c:forEach var="i" begin="1" end="12">
                    <fmt:formatNumber var="monthStr" minIntegerDigits="2" value="${i}" type="number"/>
                    <option value="${monthStr}">${i}월</option>
                  </c:forEach>
                </select>
              </div>
              <div class="select" style="margin-right:5px;">
                <select id="selReason">
                  <option value="0">전체 Transaction</option>
                  <option value="1">파일 이름 변경</option>
                  <option value="2">파일 삭제</option>
                  <option value="3">파일 생성</option>
                </select>
              </div>
            </div>
            <div id="jqxGrid_Systemlog" role="grid" class="cont-result" style="width: calc(100% - 4rem); height:calc(100% - 8rem);margin-left:calc(0% + 2rem);margin-right:calc(0% + 2rem);"><!-- // Table 영역 // -->
              <!--// Table Sample - Size Check //-->
              <table class="tbl-grid tbl-data-check ">
                <colgroup>
                  <col width="*"/>
                </colgroup>
                <thead>
                  <tr>
                    <th></th>
                    <c:forEach var="i" begin="1" end="31">
                      <fmt:formatNumber var="monthStr" minIntegerDigits="2" value="${i}" type="number"/>
                      <th style="cursor:pointer" id="tr_${monthStr}">${i}</th>
                    </c:forEach>
                  </tr>
                </thead>
                <tbody id="ntfs_body">
                </tbody>
              </table>
            </div>
          </div>
        </div>
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
  <script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/jquery.datetimepicker.full.min.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
  <script type="text/javascript" src="/carpe/resources/js/common.js"></script>
  <script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
  <!-- // 공통 javascript 영역 -->

  <!-- 현재 페이지에 필요한 js -->
  <script>
  var selTime = "";

  $(document).ready(function() {
    $("#selYear, #selMonth, #selReason").change(getData);
    getData();
    initPopup();
    initGrid();
  });

  var showFileInfo = function(timestamp) {
    selTime = timestamp;
    $("#fileInfo").jqxWindow('open');
    $("#jqxGrid_fileInfo").jqxGrid('updateBoundData');
  };


  // 팝업윈도우 셋팅
  var initPopup = function() {
    //파일 Window
    $("#fileInfo").jqxWindow({
        width: '100rem'
      , height: '60rem'
      , resizable: false
      , autoOpen: false
      , resizable: false
      , isModal: true
      , modalOpacity: 0.3
    });
  };

  var getData = function() {
    $.ajax({
      url: "/carpe/ntfs/ntfs_history_count_list.do",
      dataType:'json',
      data: {
        timestamp : $("#selYear").val() + "-" + $("#selMonth").val(),
        reason : $("#selReason").val()
      },
      async:false,
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      success:function(data) {
         dataRender(data);
      }
    });
  };
  
  var dataRender = function(data) {        
    var list = "";
    var nightCnt = 0;
    var workCnt = 0;    
    var nightDayArr = {};
    var sIdx = new Array(31);   //시작시간
    var eIdx = new Array(31);   //종료시간
    var year = $("#selYear").val();
    var month = $("#selMonth").val();

    for (var h = 0; h < 24; h++) {        
      var time = "";
      var hour = h;
  
      if (h < 10) {
        time = "0";
        hour = "0" + h;
      }
  
      time += h + ":00";
  
      list += "\n                  <tr> ";
      list += "\n                    <th>" + time + "</th> ";      

      for (var d = 0; d < 31; d++) {        
        var dayStr = d + 1;
  
        if (dayStr < 10) {
            dayStr = "0" + dayStr;
        }

        var key = year + "-" + month + "-" + dayStr + " " + hour;
        var val = data.list[key];
        var onClick = "";
        var alpha = 0;
  
        if (val) {
          alpha = val / 10000;
          onClick = "onClick=\"showFileInfo('" + key + "');\"";
        }

        if (alpha > 1) {
          alpha = 1;
        }

        list += "\n                    <td style=\"background-color: rgba(255, 0, 0, " + alpha + ");\" " + onClick + "></td> ";
      }
  
      list += "\n                  </tr> ";
    }
  
    $("#ntfs_body").html(list);
  };

  var initGrid = function() {
	  var source = {
      datatype: "json",
      datafields: [
        { name: 'file_name', type: 'string' },
        { name: 'file_size', type: 'string' },
        { name: 'file_path', type: 'string' },
        { name: 'reason_str', type: 'string' },
        { name: 'timestamp', type: 'string' }
      ],
      type : "POST",
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      url: "/carpe/ntfs/ntfs_history_list.do"
    };
	  
	  var dataAdapter = new $.jqx.dataAdapter(source, {
	  	contentType : 'application/json; charset=utf-8',
	  	formatData : function(data) {
        data.timestamp = selTime;
        data.reason = $("#selReason").val();
        
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
	  	{text: 'Name', dataField: 'file_name', width: 'auto', cellsalign: 'left', align: 'center'},
	  	{text: 'Size', dataField: 'file_size', width: '70px', cellsalign: 'left', align: 'center'},
	  	{text: 'Path', dataField: 'file_path', width: 'auto', cellsalign: 'left', align: 'center'},
	  	{text: 'Reason', dataField: 'reason_str', width: '150px', cellsalign: 'left', align: 'center'},
	  	{text: 'Timestamp', dataField: 'timestamp', width: '150px', cellsalign: 'left', align: 'center'}
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