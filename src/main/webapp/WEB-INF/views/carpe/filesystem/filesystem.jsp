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
  <link rel="stylesheet" type="text/css" href="/carpe/resources/css/jquery.datetimepicker.min.css" />
  <link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">

</head>
<body>

  <!-- wrap -->
  <div class="wrap filesys bg-theme blue">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>
    <!-- // header -->

    <!-- nav -->
    <c:import url="../common/left_nav.jsp">
      <c:param name="d1" value="analysis"></c:param>
      <c:param name="d2" value="filesystem"></c:param>
    </c:import>
    <!-- // nav -->
    
    <!-- main -->
    <main class="main">
		<section class="tit-area">
		  <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%> </h3>
		  <h3 id="evdname">Evidence : <%=(String)session.getAttribute(Consts.SESSION_EVDNC_NAME)%> </h3>
		  <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
      <c:import url="../common/location_area.jsp">
        <c:param name="d1" value="analysis"></c:param>
        <c:param name="d2" value="filesystem"></c:param>
      </c:import>
		</section>
		<section class="search-area bg-unit">
			<h4 class="blind">조회조건 선택</h4>
			<form action="/carpe/filesystem_csv_export.do" id="frm" name="frm" method="post">
				<input type="hidden" name="searchFlag" id="searchFlag" value="0" />
				<input type="hidden" name="evd_id" id="evd_id" value="" />
				<input type="hidden" name="evd_name" id="evd_name" value="" />
				<input type="hidden" name="id" id="id" value="" />
				<input type="hidden" name="par_id" id="par_id" value="" />
				<input type="hidden" name="attr" id="attr" value="" />
				<table class="tbl-srch">
					<colgroup>
						<col width="70"/>
						<col width="*" />
						<col width="70" />
						<col width="22%" />
						<col width="70" />
						<col width="22%" />
						<col width="80" />
					</colgroup>
					<tbody>
						<tr>
							<th>파일명</th>
							<td>
								<div class="input-text input-text-type-1">
									<input id="search_fname" name="search_fname" type="text" placeholder="파일명" />
								</div>
							</td>
							<th>최소 용량</th>
							<td>
								<div class="input-text input-text-type-1">
									<input id="search_ssize" name="search_ssize" type="text" placeholder="최소 용량" />
								</div>
							</td>
							<th>최대 용량</th>
							<td>
								<div class="input-text input-text-type-1">
									<input id="search_esize" name="search_esize" type="text" placeholder="최대 용량" />
								</div>
							</td>
							<th rowspan="2">
								<button type="button" class="btn-case-01 btn-search txt" id="btnSearch">
									<span class="icon ico-search">검색</span>
								</button>
							</th>
						</tr>
						<tr>
							<th>시간 종류</th>
							<td>
								<div class="select">
								  <select name="search_timeType" id="search_timeType">
								    <option value="MT">Modified Time</option>
								    <option value="CT">Created Time</option>
								    <option value="AT">Accessed Time</option>
								  </select>
								</div>
							</td>
							<th>시작일</th>
							<td>
								<div class="input-text-type-1 calendar">
		  						  <input id="search_stime" name="search_stime" type="text" placeholder="시작일" />
								</div>
							</td>
							<th>종료일</th>
							<td>
								<div class="input-text-type-1 calendar">
		  						  <input id="search_etime" name="search_etime" type="text" placeholder="종료일" />
		             			</div>
							</td>
						</tr>
					</tbody>
				</table>  
			</form>
		</section>
		<section class="fl btn-area">
			<ul class="btn-sort-area">
				<li>
				  <button type="button" class="btn-case-02" id="btnCsvExport"><span>CSV Export</span></button>
				</li>
				<li>
				  <button type="button" class="btn-case-02" id="btnFileNameWordCloud"><span>Word Cloud</span></button>
				</li>
<!-- 				<li> -->
<!-- 				  <button type="button" class="btn-case-02" id="btnDateTreeMap"><span>Data Tree Map</span></button> -->
<!-- 				</li> -->
				<li>
				  <button type="button" class="btn-case-02" id="btnHexView"><span>HEX VIEW</span></button>
				</li>
			</ul>     
		</section>
      <article class="container">
        <h4 class="blind">조회된 컨텐츠</h4>

        <!--// Content 영역 //-->
        <div id="jqxSplitter" class="content-box">

          <div class="aside">
            <div id="jqxTree_dirs" role="tree" data-role="treeview" class="aside-result"><!--// Tree 영역 //--></div>
          </div>

          <div class="content-area">
            <div id="jqxGrid_files" role="grid" class="cont-result"><!--// Table 영역 //--></div>
            <div id="paging" class="paging-area" style="display:none">
              <!--// Table Paging 영역 - 위치고정 //-->
              <div class="paginate">
              </div>
            </div>
          </div>
        </div>
      </article>
    </main>
    <!-- // main -->

  </div>
  <!-- // wrap -->

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
  (function($) {
    $(document).ready(function() {
      //검색 datetimepicker
      $.datetimepicker.setLocale("ko");

      $("#search_stime, #search_etime").datetimepicker({
        format: "Y-m-d H:i:00",
        step: 10
      });

      $("#search_fname").keypress(function(e) {
        e = e || window.event;
        if (e.which == 13) {
          search();
        }
      });

      var search = function() {
        $("#searchFlag").val("1");
        $("#paging").show();
        currentPage = 1;
				$("#jqxGrid_files").jqxGrid('updateBoundData');
      };

      //검색
			$("#btnSearch").click(function(e) {
        search();
			});

      // Word Cloud
      $('#btnFileNameWordCloud').click(function(e) {
        var popUrl = "/carpe/filename_wordcloud.do";
        var popOption = "width=900, height=750, resizable=no, scrollbars=no, status=no;";
        window.open(popUrl,"",popOption);
      });

      // Data Tree Map
      $('#btnDateTreeMap').click(function(e) {
        var node = $('#jqxTree_dirs').jqxTree('getSelectedItem');
        var dir_id;
        if (node) {
          var dir_id = node.value["id"];
        } else {
          return;
        }
        
        var popUrl = "/carpe/date_treemap.do?id=" + dir_id;
        var popOption = "width=900, height=750, resizable=no, scrollbars=no, status=no;";
        window.open(popUrl,"",popOption);
      });

      // Hex View
      $('#btnHexView').click(function(e) {
        var selIdx = $("#jqxGrid_files").jqxGrid("selectedrowindex");
        var rowData = $("#jqxGrid_files").jqxGrid("getrowdata", selIdx);

        if (!rowData || rowData.dir_type == 3) {
          return;
        }

        var seq = rowData.seq;
        var id = rowData.id;
        var popUrl = "/carpe/hexview.do?seq=" + seq + "&id=" + id;
        var popOption = "width=1050, height=750, resizable=no, scrollbars=no, status=no;";
        window.open(popUrl,"",popOption);
      });

      // splitter
      $('#jqxSplitter').jqxSplitter({ width: '100%', height: '100%', panels: [{ min: 150, size: 200 }, { min: 300,}] });

      // tree
      function expandDirTree(node) {
        var param = {}, querystr, list;
        if (node && node.value) {
          param.evd_id = node.value["evd_id"];
          param.evd_name = node.value["evd_name"];
          param.par_id = node.value["par_id"];
          param.id = node.value["id"];
          param.parentId = node.value["parentId"];
          param.attr = node.value["attr"];
        } else {
          param.id = "";
        }
        querystr = encodeQueryData(param);

        $.ajax({
          type: "POST",
          url: "/carpe/dir_list.do",
          async: false,
          data: param,
          success: function (data, textStatus, jqXHR) {
            if (!node) {
              list = data ? data["list"] : [];
              return;
            }

            node.value["isLoaded"] = true;
            $("#evdname").text("Evidence : " + node.value["evd_name"]);

            if (data) {
              var nextItem = $("#jqxTree_dirs").jqxTree('getNextItem', node.element);
              $("#jqxTree_dirs").jqxTree('removeItem', nextItem.element);
              $("#jqxTree_dirs").jqxTree('addTo', data["list"], node);
              node.value.childcount = data["list"].length;
              if (!data["list"].length) {
                node.icon = "<%=Consts.FOLDER_CLOSED_IMAGE%>";
                $('#jqxTree_dirs').jqxTree('updateItem', node, node);
              }
            }
          },
          error: function (jqXHR, textStatus, errorThrown) {
            alert(errorThrown);
          }
        });

        return list;
      }

      var treeRootDir = expandDirTree();
      $("#jqxTree_dirs").jqxTree({ source: treeRootDir, allowDrag:false, width:'calc(100%)', height:'calc(100%)'});

      $("#jqxTree_dirs").on("expand", function (event) {
        var node = $("#jqxTree_dirs").jqxTree('getItem', event.args.element);

        if (node.value["isLoaded"]) {
          if (node.value.childcount) {
            node.icon = "<%=Consts.FOLDER_OPEN_IMAGE%>";
            $('#jqxTree_dirs').jqxTree('updateItem', node, node);
          }

          return;
        } else {
          node.icon = "<%=Consts.FOLDER_OPEN_IMAGE%>";
          $('#jqxTree_dirs').jqxTree('updateItem', node, node);
        }

        expandDirTree(node);
      });

      $("#jqxTree_dirs").on("collapse", function (event) {
        var node = $("#jqxTree_dirs").jqxTree('getItem', event.args.element);
        node.icon = "<%=Consts.FOLDER_CLOSED_IMAGE%>";
        $('#jqxTree_dirs').jqxTree('updateItem', node, node);
      });

      var treeItems = $("#jqxTree_dirs").jqxTree('getItems');

      /*
      if (treeItems && treeItems.length) {
        var firstItem = treeItems[0];

        $('#jqxTree_dirs').jqxTree('selectItem', firstItem);
      }
      */

      var source = {
        datatype: "json",
        datafields: [
          { name: 'id', type: 'string' },
          { name: 'parent_path', type: 'string' },
          { name: 'name', type: 'string' },
          { name: 'size', type: 'number' },
          { name: 'md5', type: 'string' },
          { name: 'dir_type', type: 'number' },
          { name: 'ctime', type: 'string' },
          { name: 'atime', type: 'string' },
          { name: 'mtime', type: 'string' },
          { name: 'extension', type: 'string' },
          { name: 'seq', type: 'string' }
        ],
        type: "POST",
        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
        url: "/carpe/file_list.do"
      };

      var columnSet = [
          {text: 'Path', dataField: 'parent_path', width: 'auto', cellsalign: 'left', align: 'center'}
        , {text: 'Name', dataField: 'name', width: 'auto', cellsalign: 'left', align: 'center'}
        , {text: 'Size', dataField: 'size', cellsformat : 'd', width: '120px', cellsalign: 'right', align: 'center'}
        , {text: 'MD5', dataField: 'md5', width: '120px', cellsalign: 'center', align: 'center'}
        , {text: 'Category', dataField: 'dir_type', width: '120px', cellsalign: 'center', align: 'center',
          cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
            var tmp = 'etc';
            if (value === 3) {
              tmp = 'Directory';
            } else if (value === 5) {
              tmp = 'File';
            }

            return '<div style="margin-top: 8px; text-align: center;">' + tmp + '</div>';
          }
          }
        , {text: 'Modified Time', dataField: 'mtime', width: '150px', cellsalign: 'center', align: 'center'}
        , {text: 'Created Time', dataField: 'ctime', width: '150px', cellsalign: 'center', align: 'center'}
        , {text: 'Accessed Time', dataField: 'atime', width: '150px', cellsalign: 'center', align: 'center'}
        , {text: 'Extension', dataField: 'extension', width: '150px', cellsalign: 'center', align: 'center'}
        , {text: 'Seq', dataField: 'seq', width: '150px', cellsalign: 'center', align: 'center'}
      ];

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
        $("#paging").show();
        $("#jqxGrid_files").jqxGrid('updateBoundData');
      };

      var dataAdapter = new $.jqx.dataAdapter(source, {
        contentType : 'application/json; charset=utf-8',
        formatData : function(data) {
          var node = $('#jqxTree_dirs').jqxTree('getSelectedItem');
          if (node) {
            data["evd_id"] = node.value["evd_id"];
            data["evd_name"] = node.value["evd_name"];
            data["id"] = node.value["id"];
            data["par_id"] = node.value["par_id"];
            data["attr"] = node.value["attr"];
            data["search_flag"] = $("#searchFlag").val();
            data["search_fname"] = $("#search_fname").val();
            data["search_ssize"] = $("#search_ssize").val();
            data["search_esize"] = $("#search_esize").val();
            data["search_timeType"] = $("#search_timeType").val();
            data["search_stime"] = $("#search_stime").val();
            data["search_etime"] = $("#search_etime").val();
            data["currentPage"] = currentPage;
            data["pageSize"] = pagesize;
            $("#evdname").text("Evidence : " + node.value["evd_name"]);
          }
          //data["id"] = 5;
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

      $('#jqxGrid_files').on('bindingcomplete', function(event) {
        var localizationobj = {};
        localizationobj.emptydatastring = " ";

        $("#jqxGrid_files").jqxGrid('localizestrings', localizationobj);
        $("#jqxGrid_files").jqxGrid('pagesize', currentRowCount);
      });

      $("#jqxGrid_files").jqxGrid({
        width: 'calc(100% - 4rem)',
        height: 'calc(100% - 7rem)',
        source: dataAdapter,
        columnsresize: true,
        pagerheight: 0,
        pageable: true,
        pagerrenderer: function() { return  ''; },
        altrows: true,
        scrollbarsize: 12,
        autoshowloadelement: true,
        ready: function() {},
        enablebrowserselection: true,
        columnsresize: true,
        filterable: true,
        sortable: true,
        sortMode: 'many',
        columns: columnSet,
        ready: function () {
          $("#jqxGrid_files").jqxGrid('hidecolumn', 'extension');
          $("#jqxGrid_files").jqxGrid('hidecolumn', 'seq');
        }
      });

      var imgExt = ["jpg", "jpeg", "png", "gif", "bmp", "ico", "apng", "svg", "tiff"];
      var videoExt = ["mp4", "m4p", "m4v", "ogg", "avi", "webm", "wmv", "mov", "mpeg", "mpg"];

      $("#jqxGrid_files").on("rowclick", function (event) {
        var args = event.args;
        var rightClick = args.rightclick; 
        var ext = args.row.bounddata.extension;
        var seq = args.row.bounddata.seq;
        var id = args.row.bounddata.id;
      
        if (rightClick == false) {
          var fileType = 0;

          if (imgExt.indexOf(ext.toLowerCase()) >= 0) {
            fileType = 1;
          } else if (videoExt.indexOf(ext.toLowerCase()) >= 0) {
            fileType = 2;
          }

          //이미지, 동영상 미리보기
          if (fileType != 0) {
            var url = "/carpe/file_preview.do?id=" + id + "&seq=" + seq + "&fileType=" + fileType;
            var option = "width=1050, height=750, resizable=no, scrollbars=no, status=no;";
            window.open(url, "file_preview", option);
          }
        }
      });

      $("#jqxTree_dirs").on('select',function (event){
        $("#searchFlag").val("0");
        $("#paging").hide();
        currentPage = 1;
        $("#jqxGrid_files").jqxGrid('updateBoundData');
      });
    });

    //CSV Export
    $("#btnCsvExport").click(function() {
      var node = $('#jqxTree_dirs').jqxTree('getSelectedItem');

      if (node) {
        $("#evd_id").val(node.value["evd_id"]);
        $("#evd_name").val(node.value["evd_name"]);
        $("#id").val(node.value["id"]);
        $("#par_id").val(node.value["par_id"]);
        $("#attr").val(node.value["attr"]);
      }

      $("#frm").submit();
    });
  })(jQuery);
  </script>
  <!-- // 현재 페이지에 필요한 js -->

</body>
</html>