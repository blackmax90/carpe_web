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

</head>
<body>

  <!-- wrap -->
  <div class="wrap bg-theme blue">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>
    <!-- // header -->

    <!-- nav -->
    <c:import url="../common/left_nav.jsp">
      <c:param name="d1" value="visualization"></c:param>
      <c:param name="d2" value="mfthistory"></c:param>
    </c:import>
    <!-- // nav -->
    
    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%> </h3>
        <h3 id="evdname"></h3>
        <button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button>
        <div class="location-area">
          <ul class="list-h">
            <li>Home</li>
            <li>Visualization</li>
            <li>MFT History</li>
          </ul>
        </div>
      </section>

      <article class="container">
        <h4 class="blind">조회된 컨텐츠</h4>

        <!--// Content 영역 //-->
        <div id="jqxSplitter" class="content-box">

          <div class="aside mft">
            <div id="jqxTree_dirs" role="tree" data-role="treeview" class="aside-result"><!--// Tree 영역 //--></div>
            <div class="aside-legend" title="대량 복사 가능성 폴더 범례"></div>
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
  <script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
  <script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
  <script type="text/javascript" src="/carpe/resources/js/common.js"></script>
  <script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
  <!-- // 공통 javascript 영역 -->

  <!-- 현재 페이지에 필요한 js -->
  <script>
  (function($) {
    $(document).ready(function() {
      // Splitter
      $('#jqxSplitter').jqxSplitter({ width: '100%', height: '100%', panels: [{ min: 200, size: 300 }, { min: 300,}] });

      // Grid
      var source = {
        datatype: "json",
        datafields: [
          { name: 'id', type: 'string' },
          { name: 'name', type: 'string' },
          { name: 'size', type: 'number' },
          { name: 'dir_type_str', type: 'string' },
          { name: 'ctime', type: 'string' },
          { name: 'mtime', type: 'string' }
        ],
        type: "POST",
        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
        url: "/carpe/mft/mfthistory_list.do"
      };

      var imgExt = ["jpg", "jpeg", "png", "gif", "bmp", "ico", "apng", "svg", "tiff"];
      var videoExt = ["mp4", "m4p", "m4v", "ogg", "avi", "webm", "wmv", "mov", "mpeg", "mpg"];
      var imagerenderer = function(row, columnfield, value, defaulthtml, columnproperties) {
        var arr = value.split("|");
        var img = "";

        if (arr[1] == "Directory") {  //Dir
          img = "/carpe/resources/images/ico_folder.svg";
        } else if (imgExt.indexOf(arr[1]) >= 0) {   //Image
          img = "/carpe/resources/images/ico_file.svg";
        } else if (videoExt.indexOf(arr[1]) >= 0) { //Video
          img = "/carpe/resources/images/ico_file.svg";
        } else {  //Etc
          img = "/carpe/resources/images/ico_file.svg";
        }

        return "<div style='padding:7px;'><img src='" + img + "' style='margin-right:5px;'>" + arr[0] + "</div>";
      };

      var columnSet = [
          {text: 'Name', dataField: 'name', width: 'auto', cellsalign: 'left', align: 'center', cellsrenderer: imagerenderer}
        , {text: 'Size', dataField: 'size', cellsformat : 'd', width: '120px', cellsalign: 'right', align: 'center'}
        , {text: 'Type', dataField: 'dir_type_str', width: '120px', cellsalign: 'center', align: 'center'}
        , {text: 'Created Time', dataField: 'ctime', width: '150px', cellsalign: 'center', align: 'center'}
        , {text: 'Modified Time', dataField: 'mtime', width: '150px', cellsalign: 'center', align: 'center'}
      ];

      var dataAdapter = new $.jqx.dataAdapter(source, {
        contentType : 'application/json; charset=utf-8',
        formatData : function(data) {
          var node = $('#jqxTree_dirs').jqxTree('getSelectedItem');

          if (node) {
            data["parent_id"] = node.value["id"];
            data["evd_id"] = node.value["evd_id"];
            data["par_id"] = node.value["par_id"];
          } else {
            data["parent_id"] = <%=Consts.TREE_ROOT_ID%>;
          }

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

      $('#jqxGrid_files').on('bindingcomplete', function(event) {
        var localizationobj = {};
        localizationobj.emptydatastring = " ";

        $("#jqxGrid_files").jqxGrid('localizestrings', localizationobj);
      });

      $("#jqxGrid_files").jqxGrid({
        width: 'calc(100% - 4rem)',
        height: 'calc(100% - 7rem)',
        source: dataAdapter,
        columnsresize: true,
        altrows: true,
        scrollbarsize: 12,
        autoshowloadelement: true,
        ready: function() {},
        enablebrowserselection: true,
        columnsresize: true,
        filterable: true,
        sortable: true,
        sortMode: 'many',
        columns: columnSet
      });

      // tree
      function expandDirTree(node) {
        var param = {}, list;

        if (node && node.value) {
          param.evd_id = node.value["evd_id"];
          param.evd_name = node.value["evd_name"];
          param.par_id = node.value["par_id"];
          param.id = node.value["id"];
          param.parent_id = node.value["id"];

          changeDirIcon(node);
        } else {
          param.evd_id = "";
        }

        param.dirType = <%=Consts.DIR_TYPE%>;

        $.ajax({
          type: "POST",
          url: "/carpe/mft/mfthistory_dir_list.do",
          async: false,
          data: param,
          success: function (data, textStatus, jqXHR) {
            if (!node) {
              list = data ? data["list"] : [];
              return;
            }

            node.value["isLoaded"] = true;

            if (data) {
              var nextItem = $("#jqxTree_dirs").jqxTree('getNextItem', node.element);
              $("#jqxTree_dirs").jqxTree('removeItem', nextItem.element);
              $("#jqxTree_dirs").jqxTree('addTo', data["list"], node);
              node.value.childcount = data["list"].length;

              if (!data["list"].length) {
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

      var changeDirIcon = function(node) {
        var param = {};
        param.evd_id = node.value["evd_id"];
        param.par_id = node.value["par_id"];
        param.file_id = node.value["id"];
        param.filename = node.value["filename"];
        param.color = node.value["color"];
        param.dirType = <%=Consts.DIR_TYPE%>;
        param.isExpanded = node.isExpanded;
        param.attr = node.value["attr"];

        $.ajax({
          type: "POST",
          url: "/carpe/mft/mfthistory_copyrate.do",
          async: false,
          data: param,
          success: function (data, textStatus, jqXHR) {
            if (data.ret != 0) {
              return;
            }

            node.label = data.label;
            node.value["filename"] = data.filename;
            node.value["color"] = data.color;
            $('#jqxTree_dirs').jqxTree('updateItem', node, node);
          },
          error: function (jqXHR, textStatus, errorThrown) {
            alert(errorThrown);
          }
        });
      };

      var treeRootDir = expandDirTree();
      $("#jqxTree_dirs").jqxTree({ source: treeRootDir, allowDrag:false, width:'calc(100%)', height:'calc(100% - 10rem)'});

      $("#jqxTree_dirs").on("expand", function (event) {
        var node = $("#jqxTree_dirs").jqxTree('getItem', event.args.element);

        $("#evdname").text("Evidence : " + node.value["evd_name"]);

        if (node.value["isLoaded"]) {
          changeDirIcon(node);
          return;
        }

        expandDirTree(node);
      });

      $("#jqxTree_dirs").on("collapse", function (event) {
        var args = event.args;
        var node = $('#jqxTree_dirs').jqxTree('getItem', args.element);

        $("#evdname").text("Evidence : " + node.value["evd_name"]);

        changeDirIcon(node);
      });

      $("#jqxTree_dirs").on('select',function (event){
        var node = $('#jqxTree_dirs').jqxTree('getSelectedItem');

        $("#evdname").text("Evidence : " + node.value["evd_name"]);

        if (node.value["attr"] == "dir") {
          $("#jqxGrid_files").jqxGrid('updateBoundData');
        }

        changeDirIcon(node);
      });
    });
  })(jQuery);
  </script>
  <!-- // 현재 페이지에 필요한 js -->

</body>
</html>