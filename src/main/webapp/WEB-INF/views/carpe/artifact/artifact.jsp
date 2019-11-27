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
	<div class="wrap analysis bg-theme blue">

		<!-- header -->
		<%@ include file="../common/header.jsp" %>
		<!-- // header -->

		<!-- nav -->
		<nav class="nav bg-unit">
			<div class="bg-img-nav">
				<!--//
					목록 추가는 <li> 생성
					1Depth Menu class : 없음
					2Depth Menu class="level02"
					1Depth/2Depth Selected class="on" 
				//-->
				<ul>
					<li><a href="/carpe/overview.do" class="icon overview">Overview</a></li>
					<li><a href="/carpe/evdnc.do" class="icon evidence">Evidence</a></li>
					<li class="on"><a href="#" class="icon analysis">Analysis</a></li>					
						<li class="level02"><a href="/carpe/filesystem.do">Filesystem</a></li> 
						<li class="level02 on"><a href="/carpe/artifact.do">Artifact</a></li>
						<li class="level02"><a href="/carpe/search.do">검색</a></li>
					<li><a href="/carpe/communication.do" class="icon visualization">Visualization</a></li>
					<li><a href="#" class="icon report">Report</a></li>
				</ul>
			</div>
		</nav>
		<!-- // nav -->
		
		<!-- main -->
		<main class="main">
			<section class="tit-area">
				<h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%> </h3>
				<h3>Evidence : <%=(String)session.getAttribute(Consts.SESSION_EVDNC_NAME)%> </h3>
				<button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button>
			</section>
			<section class="btn-area">
				<ul>
					<li>
						<button type="button" class="btn-case-02" id="btnTimeLine"><span>Time Line</span></button>
					</li>
				</ul>				
			</section>
			<article class="container">
				<h4 class="blind">조회된 컨텐츠</h4>
				<!--// Content 영역 //-->
				<div id="jqxSplitter" class="content-box">

					<div class="aside">
						<div id="jqxTree_artifacts" role="tree" data-role="treeview" class="aside-result"><!--// Tree 영역 //--></div>
					</div>

					<div class="content-area">
						<div id="jqxGrid_Systemlog" role="grid" class="cont-result"><!--// Table 영역 //--></div>
						<div id="paing" class="paging-area" style="display:none">
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
	  $('#btnTimeLine').click(function(e) {
			var popUrl = "/carpe/timeline.do";
			var popOption = "width=1200, height=750, resizable=no, scrollbars=no, status=no;";
			window.open(popUrl,"",popOption);
		});

	    var pagesize = <%=Consts.PAGE_SZIE%>;
			var i, j;
			var currentPage = 1;
			var lastPage = 1;
			var currentRowCount = 0;
			var currentPageOffset = 1;
	
			var source = {
				datatype: "json",
	            type: "POST",
	            contenttype: "application/x-www-form-urlencoded; charset=UTF-8"
			};
			
			var columnSet = [];
			
			var artifactKind = {};
			artifactKind["Overview"] = {};
			artifactKind["Overview"].url = "/carpe/system_log_overview.do";
			artifactKind["Overview"].columnSet = [
				{text: 'MACB', dataField: 'MACB', width: '70px', cellsalign: 'left', align: 'center'}
			  , {text: 'source', dataField: 'source', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'sourcetype', dataField: 'sourcetype', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'type', dataField: 'type', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'user', dataField: 'user', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'host', dataField: 'host', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'filename', dataField: 'filename', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'inode', dataField: 'inode', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'notes', dataField: 'notes', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'format', dataField: 'format', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'extra', dataField: 'extra', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'datetime', dataField: 'datetime', width: '100px', cellsalign: 'center', align: 'center'}
			  , {text: 'reportnotes', dataField: 'reportnotes', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'inreport', dataField: 'inreport', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'tag', dataField: 'tag', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'offset', dataField: 'offset', width: '100px', cellsalign: 'right', align: 'center'}
			  , {text: 'vss_store_number', dataField: 'vss_store_number', width: '100px', cellsalign: 'right', align: 'center'}
			  , {text: 'URL', dataField: 'URL', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'record_number', dataField: 'record_number', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'event_identifier', dataField: 'event_identifier', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'event_type', dataField: 'event_type', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'source_name', dataField: 'source_name', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'user_sid', dataField: 'user_sid', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'computer_name', dataField: 'computer_name', width: '100px', cellsalign: 'left', align: 'center'}
			  , {text: 'evidence', dataField: 'evidence', width: '100px', cellsalign: 'left', align: 'center'}
			];
		    
			artifactKind["Log"] = {};
			artifactKind["Log"].url = "/carpe/log.do";
			artifactKind["Log"].columnSet = [
				{text: 'MACB', dataField: 'MACB', width: '100%', cellsalign: 'left', align: 'center'}
			];
			
	
			artifactKind["Application List"] = {};
			artifactKind["Application List"].url = "/carpe/sqlite_list.do?div=application_list";
			artifactKind["Application List"].columnSet = [
				 {text: 'package_name', dataField: 'package_name', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'applicationi_name', dataField: 'applicationi_name', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'version', dataField: 'version', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'category', dataField: 'category', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'installed_time', dataField: 'installed_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'updated_time', dataField: 'updated_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'is_updated', dataField: 'is_updated', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'cnt_permission', dataField: 'cnt_permission', width: '5%', cellsalign: 'left', align: 'center'}
				,{text: 'is_deleted', dataField: 'is_deleted', width: '5%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Call Log"] = {};
			artifactKind["Call Log"].url = "/carpe/sqlite_list.do?div=call_log";
			artifactKind["Call Log"].columnSet = [
				 {text: 'id_application', dataField: 'id_application', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp_start', dataField: 'timestamp_start', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp_end', dataField: 'timestamp_end', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'time_duration', dataField: 'time_duration', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'is_group', dataField: 'is_group', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'id_from', dataField: 'id_from', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'id_to', dataField: 'id_to', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'is_recorded', dataField: 'is_recorded', width: '5%', cellsalign: 'left', align: 'center'}
				,{text: 'id_file', dataField: 'id_file', width: '5%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Web Browser"] = {};
			artifactKind["Web Browser"].url = "/carpe/sqlite_list.do?div=web_browser";
			artifactKind["Web Browser"].columnSet = [
				 {text: 'id_application', dataField: 'id_application', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp', dataField: 'timestamp', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp_end', dataField: 'timestamp_end', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'url_address', dataField: 'url_address', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'title', dataField: 'title', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'id_file', dataField: 'id_file', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Message"] = {};
			artifactKind["Message"].url = "/carpe/sqlite_list.do?div=message";
			artifactKind["Message"].columnSet = [
				 {text: 'id_application', dataField: 'id_application', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp', dataField: 'timestamp', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'time_duration', dataField: 'time_duration', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'id_from', dataField: 'id_from', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'id_to', dataField: 'id_to', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'contents', dataField: 'contents', width: '30%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Timeline"] = {};
			artifactKind["Timeline"].url = "/carpe/sqlite_list.do?div=timeline";
			artifactKind["Timeline"].columnSet = [
				 {text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'time_duration', dataField: 'time_duration', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'id_application', dataField: 'id_application', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'id_from', dataField: 'id_from', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'id_to', dataField: 'id_to', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'has_attachment', dataField: 'has_attachment', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'id_file', dataField: 'id_file', width: '5%', cellsalign: 'left', align: 'center'}
				,{text: 'attachement_contetns', dataField: 'attachement_contetns', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'is_deleted', dataField: 'is_deleted', width: '5%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Contacts"] = {};
			artifactKind["Contacts"].url = "/carpe/sqlite_list.do?div=contacts";
			artifactKind["Contacts"].columnSet = [
				 {text: 'is_group', dataField: 'is_group', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'id_group', dataField: 'id_group', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'name', dataField: 'name', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'phonenumber', dataField: 'phonenumber', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'email', dataField: 'email', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'ip_address', dataField: 'ip_address', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'mac_address', dataField: 'mac_address', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			// splitter
			$('#jqxSplitter').jqxSplitter({ width: '100%', height: '100%', panels: [{ min: 150, size: 200 }, { min: 300 }] });
	
			// tree
			function expandArtifactTree() {
				$.ajax({
					type: "POST",
					url: "/carpe/artifact_tree_node.do",
					async: false,
					success: function (data, textStatus, jqXHR) {
						list = data ? data["list"] : [];
						return;
					},
					error: function (jqXHR, textStatus, errorThrown) {
						alert(errorThrown);
					}
				});
	
				return list;
			}
	
			var treeRootDir = expandArtifactTree();
		    $("#jqxTree_artifacts").jqxTree({ source: treeRootDir, allowDrag:false, width:'100%', height:'100%'});
	
		    var treeItems = $("#jqxTree_artifacts").jqxTree('getItems');
	
		    for (var i = 0; i < treeItems.length; i++) {
		    	var item = treeItems[i];
		    	if (item.value["force_select"]) {
				    $('#jqxTree_artifacts').jqxTree('selectItem', item);
				    source["url"] = artifactKind[item.value["artifact"]].url;
				    columnSet = artifactKind[item.value["artifact"]].columnSet;
				    
				    break;
		    	}
		    }
	
		    $('#jqxTree_artifacts').jqxTree('expandAll');
	
			var updateBound = function(e) {
				if (currentPage === e.data.value) {
					return;
				}
	
				currentPage = e.data.value;
				$("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
			};
	
			var dataAdapter = new $.jqx.dataAdapter(source, {
				contentType : 'application/json; charset=utf-8',
				formatData : function(data) {
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
					var $firstele = $('<button class="first">&nbsp;처음&nbsp;</button>');
					var $prevele = $('<button class="prev">&nbsp;이전&nbsp;</button>');
					var $spanele = $('<span class="num">');
					var $nextele = $('<button class="next">&nbsp;다음&nbsp;</button>');
					var $lastele = $('<button class="last">&nbsp;마지막&nbsp;</button>');
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
					
					$divpageele.append($firstele);
					$divpageele.append($prevele);
					$divpageele.append($spanele);
					$divpageele.append($nextele);
					$divpageele.append($lastele);
					
					$('#paing').append($divpageele);			
				},
				loadComplete : function(data) {
				},
				loadError : function(xhr, status, error) {
				}
			});
	
			$('#jqxGrid_Systemlog').on('bindingcomplete', function(event) {
				var localizationobj = {};
				localizationobj.emptydatastring = " ";
	
				$("#jqxGrid_Systemlog").jqxGrid('localizestrings', localizationobj);
				$("#jqxGrid_Systemlog").jqxGrid('pagesize', currentRowCount);
			});
	
			$("#jqxGrid_Systemlog").jqxGrid({
				width: 'calc(100% - 4rem)',
				height: 'calc(100% - 7rem)',
				source: dataAdapter,
				//selectionmode: 'checkbox', // 'none',
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
				columns: columnSet
			});
	
			$("#jqxTree_artifacts").on('select',function (event){		
			  var item = $('#jqxTree_artifacts').jqxTree('getSelectedItem');
				
				if (item.value["sub_exists"]) {
					return;
				}
	
			    source["url"] = artifactKind[item.value["artifact"]].url;
			    columnSet = artifactKind[item.value["artifact"]].columnSet;
				$('#jqxGrid_Systemlog').jqxGrid({ columns: columnSet });
	
				currentPage = 1;
				$("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
			});
		});
	})(jQuery);
	</script>
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>