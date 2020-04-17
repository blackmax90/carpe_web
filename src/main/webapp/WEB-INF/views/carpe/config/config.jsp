<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<!DOCTYPE html>
<html lang="ko"><!-- 사용자 언어에 따라 lang 속성 변경. 예) 한국어: ko, 일본어: ja, 영어: en -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>CARPE</title>
   <link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">  
  <link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
  <link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">
    <link href="/carpe/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>

  <!-- wrap -->
  <div class="wrap home bg-theme blue">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>
    <!-- // header -->

    <!-- main -->
    <main class="main">
      <article class="container">
        <h4 class="blind">조회된 컨텐츠</h4>
        <div id="jqxSplitter" class="content-box">
          <div class="aside">
            <div id="jqxGrid_userlist" role="grid" align="left" class="cont-result">
            </div>
          </div>
          <div class="content-area config">        
            <!--// Content 영역 -->    
			<div class="case-result">
              <div class="tit-area">
              	<h3 class="unit">User Case</h3>
              </div>
              <div id="jqxGrid_usercase" role="grid" align="left" class="cont-result">
                <!--// Table 영역 //-->
              </div>
            </div>
			<div class="case-control">
              <ul class="list-v">
                <li><button type="button" id="btnAdd" class="btn-get-arr" value="&lt;&lt;"><span class="icon ico-get-left"></span></button></li>
                <li><button type="button" id="btnDel" class="btn-get-arr" value="&gt;&gt;"><span class="icon ico-get-right"></span></button></li>
              </ul>
            </div>
			<div class="case-result">
              <div class="tit-area">
              	<h3 class="unit">Case List</h3>
              </div>
              <div id="jqxGrid_caselist" role="grid" align="left" class="cont-result">
                <!--// Table 영역 //-->
              </div>
              <div id="paing" class="paging-area">
              </div>
            </div>
            <!-- Content 영역 //-->  
          </div>
        </div>
      </article>
    </main>
    <!-- // main -->

  </div>
  
  <!-- 공통 javascript 영역 -->    
  <script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
  <script type="text/javascript" src="/carpe/resources/js/common.js"></script>
  <script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
  <!-- // 공통 javascript 영역 -->

  <script>
  (function($) {
    $(document).ready(function() {
      var selid = "";

      $("#btnAdd").click(function() {
        var idxes = $("#jqxGrid_caselist").jqxGrid("getselectedrowindexes");
        var selCnt = idxes.length;
        var caseidList = "";

        if (selCnt == 0 || selid == "") {
          return;
        }

        for (var i = 0; i < selCnt; i++) {
          var rowData = $("#jqxGrid_caselist").jqxGrid("getrowdata", idxes[i]);

          if (caseidList != "") {
            caseidList += "|";
          }

          caseidList += rowData.case_id;
        }

        var data = {
          id: selid,
          caseidList: caseidList
        };
        
        $.ajax({
          type: "POST",
          url: "/carpe/config/insert_user_auth.do",
          dataType: 'json',
          data: data,
          async: false,
          contentType: "application/x-www-form-urlencoded; charset=UTF-8",
          success: function(rs) {
            var ret = rs.ret;
            var msg = rs.msg;
        
            if (msg) {
              alert(msg);
            }
        
            if (ret == 0) {
              //페이지의 모든 값을 이동시킨 경우 -1페이지
              if (currentPage > 1 && selCnt == $("#jqxGrid_caselist").jqxGrid("getrows").length) {
                currentPage--;
              }

              reloadGrid();
            }
          },
          error: function (jqXHR, textStatus, errorThrown) {
            alert("User Case 추가에 실패하였습니다.");
            console.log(jqXHR.responseText);
          }
        });
      });

      $("#btnDel").click(function() {
        var idxes = $("#jqxGrid_usercase").jqxGrid("getselectedrowindexes");
        var caseidList = "";

        if (idxes.length == 0 || selid == "") {
          return;
        }

        for (var i = 0; i < idxes.length; i++) {
          var rowData = $("#jqxGrid_usercase").jqxGrid("getrowdata", idxes[i]);

          if (caseidList != "") {
            caseidList += "|";
          }

          caseidList += rowData.case_id;
        }

        var data = {
          id: selid,
          caseidList: caseidList
        };
        
        $.ajax({
          type: "POST",
          url: "/carpe/config/delete_user_auth.do",
          dataType: 'json',
          data: data,
          async: false,
          contentType: "application/x-www-form-urlencoded; charset=UTF-8",
          success: function(rs) {
            var ret = rs.ret;
            var msg = rs.msg;
        
            if (msg) {
              alert(msg);
            }
        
            if (ret == 0) {
              reloadGrid();
            }
          },
          error: function (jqXHR, textStatus, errorThrown) {
            alert("User Case 삭제에 실패하였습니다.");
            console.log(jqXHR.responseText);
          }
        });
      });

      ////////// User List Grid //////////
      var userSource = {
        datatype: "json",
        datafields: [
          { name: 'id', type: 'string' },
          { name: 'name', type: 'string' }
        ],
        type : "POST",
        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
        url: "/carpe/config/user_list.do"
      };

      var userDataAdapter = new $.jqx.dataAdapter(userSource, {
        contentType : 'application/json; charset=utf-8'
      });

      var userColumnSet = [
        {text: 'ID', dataField: 'id', width: '120px', cellsalign: 'left', align: 'center'},
        {text: 'Name', dataField: 'name', width: 'auto', cellsalign: 'left', align: 'center'}
      ];

      $("#jqxGrid_userlist").jqxGrid({
        width: 'calc(100% - 4rem)',  
        height: 'calc(100% - 4rem)',      
        source: userDataAdapter,
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
        columns: userColumnSet
      });

	    $("#jqxGrid_userlist").on("rowclick", function (event) {
		    var args = event.args;
	      var rowIdx = args.rowindex;
	      var rightClick = args.rightclick; 

	      if (rightClick == false) {
	        selid = args.row.bounddata.id;
	        currentPage = 1;
          reloadGrid();
	      }
	    });

      ////////// User Case List Grid //////////
      var userCaseSource = {
        datatype: "json",
        datafields: [
          { name: 'case_id', type: 'string' },
          { name: 'case_name', type: 'string' },
          { name: 'description', type: 'string' }
        ],
        type : "POST",
        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
        url: "/carpe/config/case_user_auth_list.do"
      };

      var userCaseDataAdapter = new $.jqx.dataAdapter(userCaseSource, {
        contentType : 'application/json; charset=utf-8',
        formatData : function(data) {
          data["id"] = selid;
          return data;
        },
      });

      var userCaseColumnSet = [
        {text: 'Case ID', dataField: 'case_id', width: '150px', cellsalign: 'left', align: 'center'},
        {text: 'Case Name', dataField: 'case_name', width: '150px', cellsalign: 'left', align: 'center'},
        {text: 'Description', dataField: 'description', width: 'auto', cellsalign: 'left', align: 'center'}
      ];

      $("#jqxGrid_usercase").jqxGrid({
        width: 'calc(100% - 4rem)',
        height: 'calc(100% - 10rem)',
        source: userCaseDataAdapter,
        selectionmode: 'checkbox',
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
        columns: userCaseColumnSet
      });

      ////////// Case List Grid //////////
      var pagesize = <%=Consts.PAGE_SZIE%>;
      var i, j;
      var currentPage = 1;
      var lastPage = 1;
      var currentRowCount = 0;
      var currentPageOffset = 1;
      
      var source = {
        datatype: "json",
        datafields: [
          { name: 'case_id', type: 'string' },
          { name: 'case_name', type: 'string' },
          { name: 'description', type: 'string' }
        ],
        type : "POST",
        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
        url: "/carpe/config/case_list.do"
      };

      var updateBound = function(e) {
        if (currentPage === e.data.value) {
          return;
        }
  
        currentPage = e.data.value;
        $("#jqxGrid_caselist").jqxGrid('updateBoundData');
      };
      
      var dataAdapter = new $.jqx.dataAdapter(source, {
        contentType : 'application/json; charset=utf-8',
        formatData : function(data) {
          data["id"] = selid;
          data["currentPage"] = currentPage;
          data["pageSize"] = pagesize;
          return data;
        },
        beforeSend : function(xhr) {
        },
        downloadComplete : function(data, status, xhr) {
          var totalcount = data['totalcount'] || 0;
          currentRowCount = data['list'] ? data['list'].length : 0;
          
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
        }
      });

      var columnSet = [
        {text: 'Case ID', dataField: 'case_id', width: '150px', cellsalign: 'left', align: 'center'},
        {text: 'Case Name', dataField: 'case_name', width: '150px', cellsalign: 'left', align: 'center'},
        {text: 'Description', dataField: 'description', width: 'auto', cellsalign: 'left', align: 'center'}
      ];

      $('#jqxGrid_caselist').on('bindingcomplete', function(event) {
        var localizationobj = {};
        localizationobj.emptydatastring = " ";

        $("#jqxGrid_caselist").jqxGrid('localizestrings', localizationobj);
      });

      $("#jqxGrid_caselist").jqxGrid({
        width: 'calc(100% - 4rem)',  
        height: 'calc(100% - 10rem)',      
        source: dataAdapter,
        selectionmode: 'checkbox',
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

      ////////// Etc //////////
      var reloadGrid = function() {
          $("#jqxGrid_usercase").jqxGrid("clearselection");
          $("#jqxGrid_caselist").jqxGrid("clearselection");
          $("#jqxGrid_usercase").jqxGrid('updateBoundData');
          $("#jqxGrid_caselist").jqxGrid('updateBoundData');
      };

      ////////// Splitter //////////
      $('#jqxSplitter').jqxSplitter({ width: '100%', height: '100%', panels: [{ min: 300, size: 300 }, { min: 300}] });
    });
  })(jQuery);  
  </script>

</body>
</html>