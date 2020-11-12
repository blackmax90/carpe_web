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
    <link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" type="text/css" href="/carpe/resources/css/style.css" />
	<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
	<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
	<link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">
  <style>
  .jqx-grid-cell:not(.jqx-grid-cleared-cell) { cursor: pointer; }
  .pop-content { width: 96% !important; }
  </style>
</head>
<body>

	<!-- wrap -->
	<div class="wrap srch-page bg-theme blue">

		<!-- header -->
		<%@ include file="../common/header.jsp" %>
		<!-- // header -->

		<!-- nav -->
		<c:import url="../common/left_nav.jsp">
		  <c:param name="d1" value="analysis"></c:param>
		  <c:param name="d2" value="similarity"></c:param>
		</c:import>
		<!-- // nav -->
		
        <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%> </h3>
        <h3>Evidence : <%=(String)session.getAttribute(Consts.SESSION_EVDNC_NAME)%> </h3>
        <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
        <c:import url="../common/location_area.jsp">
          <c:param name="d1" value="analysis"></c:param>
          <c:param name="d2" value="similarity"></c:param>
        </c:import>
      </section>
      <section class="search-area bg-unit">
        <h4 class="blind">조회조건 선택</h4>
        <form action="/carpe/stringsearch_csv_export.do" id="frm" name="frm" method="post">
          <input type="hidden" id="searchWord" />
          <input type="hidden" id="inFileName" />
          <input type="hidden" id="inContent" />
          <ul class="search-item-area">
            <li>
              <div class="checkbox checkbox-type-1">
                <input id="checkbox_filename" name="checkbox_filename" type="checkbox" />
                <label for="checkbox_filename"><span class="text">Name</span></label>
              </div>
            </li>
            <li>
              <div class="checkbox checkbox-type-1">
                <input id="checkbox_content" name="checkbox_content" type="checkbox" checked="checked"/>
                <label for="checkbox_content"><span class="text">Content</span></label>
              </div>
            </li>
            <li>
              <div class="input-text input-text-type-1 fl w300">
                <input id="search_word" name="search_word" type="text" placeholder="검색어를 입력해주세요."/>
              </div>
              <button type="button" class="btn-case-01 btn-search" id="btnSearch"><span class="icon ico-search"></span></button>
            </li>
          </ul>
          <ul class="btn-sort-area">
            <li>
              <button type="button" class="btn-case-01" id="btnSimilarity"><span class="icon ico-similar">Similarity</span></button>
            </li>
          </ul>
        </form>
      </section>
      <article class="container">
        <h4 class="blind">조회된 컨텐츠</h4>
        <div class="content-box">
          <div class="content-area">        
            <!--// Content 영역 //--> 
            <div id="jqxGrid_Systemlog" role="grid" align="left" class="cont-result">
            <!--// Table 영역 //-->
            </div>
            
            <!--// Table Paging 영역 - 위치고정 //-->
            <div id="paing" class="paging-area">
            </div>
          </div>
        </div>
      </article>
    </main>
    <!-- // main -->
  </div>
  <!-- // wrap -->

  <!-- pop-up // 비교 컨텐츠 선택 //--> 
  <div id="settingLayer" class="pop wrap-pop">
    <div class="pop-header">
      <h1 id="layerTitle">Choose a file for similarity analysis</h1>
    </div>
    <div id="settingLayerBody" class="pop-content" style="overflow-y:auto;">
      <div id="settingBody">
        <!--// Table Sample - Size Check //-->
        <table class="tbl-grid">
          <colgroup>
            <col width="6%"/>
            <col width="10%"/>
            <col width="7%"/>
            <col width="8%"/>
            <col width="11%"/>
            <col width="16%"/>
            <col width="16%"/>
            <col width="*"/>
          </colgroup>
          <thead>
            <tr>
              <th>Target</th>
              <th>File name</th>
              <th>File size</th>
              <th>Author</th>
              <th>Last saved by</th>
              <th>Created time</th>
              <th>Last saved time</th>
              <th>File path</th>
            </tr>
          </thead>
          <tbody id="settingTable">
          </tbody>
        </table>
        <div class="btn-area">
          <ul>
            <li><button class="btn-case-01" id="btnRun" type="button"><span class="icon ico-play">Run</span></button></li>
          </ul>
        </div>
      </div>
      <div class="loading-content" id="loadingBody" style="display:none;">
        <div class="loader lg"></div>
        <span class="text">Running...</span>
      </div>
    </div><!-- // pop-content end -->
  </div><!-- // pop-up end -->
  
  <!-- pop-up //-->
  <div id="resultLayer" class="pop wrap-pop" style="display:none;">
    <div id="" class="pop-header">
      <h1>Similarity analysis result</h1>
    </div>
    <div id="" class="pop-content" style="overflow-y:auto;">
    
      <table class="tbl-grid">
        <colgroup>
          <col width="50%"/>
          <col width="*"/>
        </colgroup>
        <thead>
          <tr>
            <th>Target file name</th>
            <th>Target file path</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td id="targetName"></td>
            <td id="targetPath"></td>
          </tr>
        </tbody>
      </table>
      <table class="tbl-grid mt10">
        <colgroup>
          <col width="20%"/>
          <col width="*%"/>
          <col width="30%"/>
          <col width="8%"/>
        </colgroup>
        <thead>
          <tr>
            <th>File name</th>
            <th>File path</th>
            <th colspan="2">Similarity</th>
          </tr>
        </thead>
        <tbody id="resultBody">
        </tbody>
      </table>
      <div class="btn-area">
        <ul>
          <li><button class="btn-case-01" id="btnResultClose" type="button"><span class="icon ico-delete">Close</span></button></li>
        </ul>
      </div>
    </div><!-- // pop-content end -->
  </div><!-- // pop-up end -->
  
  <!-- 공통 javascript 영역 -->
  <script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
  <script type="text/javascript" src="/carpe/resources/js/common.js"></script>
  <script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
  <!-- // 공통 javascript 영역 -->

  <!-- 현재 페이지에 필요한 js -->
  <script>
    $(document).ready(function() {
      var pagesize = <%=Consts.PAGE_SZIE%>;
      var currentPage = 1;
      var lastPage = 1;
      var currentRowCount = 0;
      var currentPageOffset = 1;

      $("#settingLayer, #resultLayer").jqxWindow({
          width: '96rem'
        , height: '39rem'
        , resizable: false
        , cancelButton: $('#cancel')
        , autoOpen: false
        , resizable: false
        , isModal: true
        , modalOpacity: 0.3
      });

      $("#btnResultClose").click(function() {
        $("#resultLayer").jqxWindow('close');
      });

      $("#btnSimilarity").click(function() {
        hideLoading();
        var idxes = $("#jqxGrid_Systemlog").jqxGrid("getselectedrowindexes");
        var selCnt = idxes.length;

        if (selCnt < 2) {
          alert("2개 이상의 문서를 선택해주세요.");
          return;
        }

        if (selCnt > 6) {
          alert("문서 유사도 비교는 최대 6개 까지 선택 가능합니다.");
          return;
        }

        var html = "";

        for (var i = 0; i < selCnt; i++) {
          var rowData = $("#jqxGrid_Systemlog").jqxGrid("getrowdata", idxes[i]);
          html += "\n <tr style=\"cursor:pointer;\" onClick=\"selTarget(this);\"> ";
          html += "\n   <td> ";
          html += "\n     <div class=\"radio radio-type-1\"> ";
          html += "\n       <input type=\"radio\" name=\"target\" id=\"tg_" + i + "\" value=\"" + rowData.path + "\" /><label for=\"tg_" + i + "\"></label> ";
          html += "\n     </div> ";
          html += "\n   </td> ";
          html += "\n   <td>" + rowData.name + "</td> ";
          html += "\n   <td>" + rowData.size + "</td> ";
          html += "\n   <td>" + rowData.author + "</td> ";
          html += "\n   <td>" + rowData.lastsavedby + "</td> ";
          html += "\n   <td>" + rowData.createdtime + "</td> ";
          html += "\n   <td>" + rowData.lastsavedtime + "</td> ";
          html += "\n   <td>" + rowData.path + "</td> ";
          html += "\n </tr> ";
        }

        $("#settingTable").html(html);
        $("#settingLayer").jqxWindow('open');
      });

      $("#btnRun").click(function() {
        if ($("[name=target]:checked").length == 0) {
          alert("Target 파일을 선택해주세요.");
          return;
        }

        showLoading();

        var data = {
            target: "",
            path: []
        };

        $("[name=target]").each(function() {
          if ($(this).is(":checked")) {
            data.target = $(this).val();
          } else {
            data.path.push($(this).val());
          }
        });

	      $.ajax({
	        url: "/carpe/similarity_proc.do",
	        dataType: 'json',
	        data: data,
	        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
	        success: function(data) {
            var ret = data.ret;
            var msg = data.msg;

            if (msg) {
              alert(msg);
            }

            if (ret == 0) {
              setResult(data);
              $("#resultLayer").jqxWindow('open');
            }
	        },
	        complete : function() {
            hideLoading();
	        }
	      });
      });

      $("#checkbox_filename").jqxCheckBox({ width: 28, height: 28, checked: true });
      $("#checkbox_content").jqxCheckBox({ width: 28, height: 28, checked: true });
      //$("#search_word").jqxInput({ width: '250px', height: '25px'});
      
      var updateBound = function(e) {
        currentPage = e.data.value;
        $("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
      };

      var source = {
        datatype: "json",
        datafields: [
          { name: 'id', type: 'string' },
          { name: 'name', type: 'string' },
          { name: 'highlight_nm', type: 'string' },
          { name: 'path', type: 'string' },
          { name: 'author', type: 'string' },
          { name: 'last_written_time', type: 'string' },
          { name: 'size', type: 'number' },
          { name: 'path_with_ext', type: 'string' },
          { name: 'lastsavedby', type: 'string' },
          { name: 'createdtime', type: 'string' },
          { name: 'lastsavedtime', type: 'string' },
          { name: 'content', type: 'content' },
          { name: 'download_path', type: 'string' }
        ],
        type : "POST",
        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
        url: "/carpe/search_list.do"
//         localdata: [
//           {id: "AAA1", name: "BBB1", highlight_nm: "BBB1", path: "d:/test_data/testaa/test1.txt", author: "DDD", last_written_time: "EEE", size: "10", path_with_ext: "d:/test_data/testaa/test1.txt", lastsavedby: "FFF", createdtime: "FFFGGG", lastsavedtime: "GGGFFF", content: "GGG", download_path: "HHH"},
//           {id: "AAA2", name: "BBB2", highlight_nm: "BBB2", path: "d:/test_data/testaa/test2.txt", author: "DDD", last_written_time: "EEE", size: "10", path_with_ext: "d:/test_data/testaa/test2.txt", lastsavedby: "FFF", createdtime: "FFFGGG", lastsavedtime: "GGGFFF", content: "GGG", download_path: "HHH"},
//           {id: "AAA3", name: "BBB3", highlight_nm: "BBB3", path: "d:/test_data/testaa/test3.txt", author: "DDD", last_written_time: "EEE", size: "10", path_with_ext: "d:/test_data/testaa/test3.txt", lastsavedby: "FFF", createdtime: "FFFGGG", lastsavedtime: "GGGFFF", content: "GGG", download_path: "HHH"},
//           {id: "AAA4", name: "BBB4", highlight_nm: "BBB4", path: "d:/test_data/testaa/test4.txt", author: "DDD", last_written_time: "EEE", size: "10", path_with_ext: "d:/test_data/testaa/test4.txt", lastsavedby: "FFF", createdtime: "FFFGGG", lastsavedtime: "GGGFFF", content: "GGG", download_path: "HHH"},
//           {id: "AAA5", name: "BBB5", highlight_nm: "BBB5", path: "d:/test_data/testaa/test5.txt", author: "DDD", last_written_time: "EEE", size: "10", path_with_ext: "d:/test_data/testaa/test5.txt", lastsavedby: "FFF", createdtime: "FFFGGG", lastsavedtime: "GGGFFF", content: "GGG", download_path: "HHH"},
//           {id: "AAA6", name: "BBB6", highlight_nm: "BBB6", path: "d:/test_data/testaa/test6.txt", author: "DDD", last_written_time: "EEE", size: "10", path_with_ext: "d:/test_data/testaa/test6.txt", lastsavedby: "FFF", createdtime: "FFFGGG", lastsavedtime: "GGGFFF", content: "GGG", download_path: "HHH"},
//           {id: "AAA7", name: "BBB7", highlight_nm: "BBB7", path: "d:/test_data/testaa/test7.txt", author: "DDD", last_written_time: "EEE", size: "10", path_with_ext: "d:/test_data/testaa/test7.txt", lastsavedby: "FFF", createdtime: "FFFGGG", lastsavedtime: "GGGFFF", content: "GGG", download_path: "HHH"},
//           {id: "AAA8", name: "BBB8", highlight_nm: "BBB8", path: "d:/test_data/testaa/test8.txt", author: "DDD", last_written_time: "EEE", size: "10", path_with_ext: "d:/test_data/testaa/test8.txt", lastsavedby: "FFF", createdtime: "FFFGGG", lastsavedtime: "GGGFFF", content: "GGG", download_path: "HHH"}
//         ]

      };

      var dataAdapter = new $.jqx.dataAdapter(source, {
        contentType : 'application/json; charset=utf-8',
        formatData : function(data) {
          data["currentPage"] = currentPage;
          data["pageSize"] = pagesize;

          data["inFileName"] = $('#checkbox_filename').jqxCheckBox('checked');
          data["inContent"] = $('#checkbox_content').jqxCheckBox('checked');

          var searchWord = $("#search_word").val();
          searchWord = base64EncodingUTF8(searchWord);
          data["searchWord"] = encodeURIComponent(searchWord);
          
          return data;
        },
        beforeSend : function(xhr) {
        },
        downloadComplete : function(data, status, xhr) {
          var totalcount = data['totalcount'] || 0;
          currentRowCount = data['list'] ? data['list'].length : 0;
          
          console.log(data);
          $('#paing').empty();

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

          $('#paing').append($divpageele);
        },
        loadComplete : function(data) {
        },
        loadError : function(xhr, status, error) {
          alert(error);
        }
      });

      var columnSet_list = [
        {text: 'File name', datafield: 'name', width: '350px', cellsalign: 'left', align: 'center',
          cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
            var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
            var highlight_nm = dataRecord.highlight_nm;
            var name = dataRecord.name
            var viewname = highlight_nm;
            if (highlight_nm == undefined) {
              viewname = name;
            }
            return '<div style="padding: 7px; overflow: hidden; text-overflow: ellipsis;">' + viewname + '</div>';
          }
        }
         ,{text: 'File Size', dataField: 'size', cellsformat : 'd', width: '150px', cellsalign: 'center', align: 'center',
          cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
            var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
            return '<div style="padding: 7px; overflow: hidden; text-overflow: ellipsis; text-align:center">'+ fileSizeSI(dataRecord.size) + '</div>';
            
          }
        }
         ,{text: 'Author', width: '100px', datafield: 'author', cellsalign: 'center', align: 'center'}
         ,{text: 'Last saved by', width: '110px', datafield: 'lastsavedby', cellsalign: 'center', align: 'center'}
         ,{text: 'Created time', dataField: 'createdtime', width: '150px', cellsalign: 'center', align: 'center',
          cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
            var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
            return '<div style="padding: 7px; overflow: hidden; text-overflow: ellipsis; text-align:center">'+ dataRecord.createdtime.substring(0,19) + '</div>';
            
          }
        }
         ,{text: 'Last saved time', dataField: 'lastsavedtime', width: '150px', cellsalign: 'center', align: 'center',
          cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
            var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
            return '<div style="padding: 7px; overflow: hidden; text-overflow: ellipsis; text-align:center">'+ dataRecord.lastsavedtime.substring(0,19) + '</div>';
            
          }
        }
         ,{text: 'File Path', width: 'auto', datafield: 'path_with_ext', cellsalign: 'left', align: 'center'}
      ];
  
      var columnSet_summary = [
        {text: '', dataField: 'name', width: '98%', cellsalign: 'left',align: 'center',
          cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
            var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
            var strHtml = "<ul class='unfold-ist'><li class='title'><div class='tit'>";
            var highlight_nm = dataRecord.highlight_nm;
            var name = dataRecord.name
            var viewname = highlight_nm;
            if (highlight_nm == undefined) {
              viewname = name;
            }
            strHtml += "<span style='font-size:1.3rem;'>&nbsp;<a href=\"/carpe/download_search.do?path=" + dataRecord.download_path + "\" target=\"_blank\">" + viewname + "</a></span></div></li>";

            var lastsavedtime = "시간정보가 없습니다.";
            if(dataRecord.lastsavedtime){
              lastsavedtime = dataRecord.lastsavedtime;
            }

            strHtml += "<li class='dates'>";
            strHtml += "<span><strong>수정</strong> : " + lastsavedtime + "</span>";
            strHtml += "<span><strong>크기</strong> : " + fileSizeSI(dataRecord.size) + "</span>";
            strHtml += "<span><strong>경로</strong> : " + dataRecord.path + "</span>";
            strHtml += "</li>";

            strHtml += "<li class='con'>" + dataRecord.content + "</li>";
            strHtml += "</ul>";

            return strHtml;
          }
        }
      ];

      $('#jqxGrid_Systemlog').on('bindingcomplete', function(event) {
        var localizationobj = {};
        localizationobj.emptydatastring = " ";

        $("#jqxGrid_Systemlog").jqxGrid('localizestrings', localizationobj);
        $("#jqxGrid_Systemlog").jqxGrid('pagesize', currentRowCount);
      });

      $("#jqxGrid_Systemlog").jqxGrid({
        width: '100%',
        height: 'calc(100% - 3rem)',
        source: dataAdapter,
        selectionmode: 'checkbox',
        pagerheight: 0,
        //enableellipsis: true,
        enabletooltips: true,
        pagerheight: 0,
        pageable: true,
        pagerrenderer: function(){ return  '';},
        autorowheight: false,
        altrows: true,
        scrollbarsize: 12,
        autoshowloadelement: true,
        ready: function() {},
        enablebrowserselection: true,
        columnsresize: true,
        columnsreorder: true,
        //columnsheight: 40,
        columns: columnSet_list
      });

      $("#jqxGrid_Systemlog").on("rowclick", function (event) {
        var args = event.args;
        var rowIdx = args.rowindex;
        var rightClick = args.rightclick; 
        var arrSel = $('#jqxGrid_Systemlog').jqxGrid('getselectedrowindexes');
      
        if (rightClick == false) {
          if (arrSel.indexOf(rowIdx) > -1) {
            $("#jqxGrid_Systemlog").jqxGrid('unselectrow', rowIdx);
          } else {
            $("#jqxGrid_Systemlog").jqxGrid('selectrow', rowIdx);
          }
        }
      });

      $('#btnSearch').click(function(e) {
        $("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
      });
      
      $("#search_word").keypress(function(e) { 
          if (e.keyCode == 13){
            $("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
            return false;
          }    
      });

      //nav 열린 상태로 grid 호출시 사이즈 이상 조치용
      $(".nav").hover(function() {
        window.dispatchEvent(new Event('resize'));
      });
    });

    var selTarget = function(obj) {
      $(obj).find("[name='target']").prop("checked", true);
    };

    var setResult = function(data) {
      var targetName = data.targetName;
      var targetPath = data.targetPath;
      var result = data.result;

      $("#targetName").text(targetName);
      $("#targetPath").text(targetPath);

      var html = "";

      for (var i = 0; i < result.length; i++) {
        var simClass = "";
        var name = result[i].name;
        var path = result[i].path;
        var value = parseInt(parseFloat(result[i].value) * 1000);
        value = value / 10;

        if (value >= 90) {
          simClass = "similarity";
        }

        html += "\n <tr> ";
        html += "\n   <td>" + name + "</td> ";
        html += "\n   <td>" + path + "</td> ";
        html += "\n   <td><progress class=\"" + simClass + "\" value=\"" + value + "\" max=\"100\"></progress></td> ";
        html += "\n   <td>" + value + "%</td> ";
        html += "\n </tr> ";
      }

      $("#resultBody").html(html);
    };

    var showLoading = function () {
      $("#layerTitle").text("Similarity analysis module is running");
      $("#settingLayerBody").addClass("dimd");
      $("#settingBody").hide();
      $("#loadingBody").show();
    };

    var hideLoading = function () {
      $("#layerTitle").text("Choose a file for similarity analysis");
      $("#settingLayerBody").removeClass("dimd");
      $("#loadingBody").hide();
      $("#settingBody").show();
    };

  </script>
  <!-- // 현재 페이지에 필요한 js -->

</body>
</html>