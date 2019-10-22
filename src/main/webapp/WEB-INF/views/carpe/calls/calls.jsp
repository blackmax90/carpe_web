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
</head>
<body>

	<!-- wrap -->
	<div class="wrap evidence bg-theme blue">

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
						<li class="level02"><a href="/carpe/artifact.do">Artifact</a></li>
						<li class="level02 on"><a href="/carpe/calls.do">Calls</a></li>
						<li class="level02"><a href="/carpe/search.do">검색</a></li>
					<li><a href="#" class="icon visualization">Visualization</a></li>
					<li><a href="#" class="icon report">Report</a></li>
				</ul>
			</div>
		</nav>
		<!-- // nav -->

		<!-- main -->
		<main class="main">
			<section class="tit-area">
				<h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
				<a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
			</section>
			<article class="container">
				<h4 class="blind">조회된 컨텐츠</h4>
				<div id="jqxSplitter" class="jqx-reset jqx-splitter jqx-widget jqx-widget-content content-box">
					<div class="jqx-widget-content jqx-splitter-panel jqx-reset content-area">				
						<!--// Content 영역 //-->	
						<div id="jqxGrid_Systemlog" role="grid" align="left" class="jqx-grid jqx-reset jqx-rc-all jqx-widget jqx-widget-content empty-area">						
							<!--// Grid Table 영역 //-->
						</div>
						<div id="paing" class="paging-area">
							<!--// Table Paging 영역 - 위치고정 //-->
							<div class="paginate">
								<button type="button" class="btn-paging icon ico-first"><span class="ir">처음</span></button>
								<button type="button" class="btn-paging icon ico-prev"><span class="ir">이전</span></button>
								<span class="num">
									<a href="#">81</strong></a>
									<a href="#">82</a>
									<a href="#"><strong class="on">83</strong></a>
									<a href="#">84</a>
									<a href="#">85</a>
									<a href="#">86</a>
									<a href="#">87</a>
									<a href="#">88</a>
									<a href="#">89</a>
									<a href="#">90</a>
								</span>
								<button class="btn-paging icon ico-next"><span class="ir">다음</span></button>
								<button class="btn-paging icon ico-last" disabled="disabled"><span class="ir">마지막</span></button>
							</div>
						</div>
					</div>
				</div>
			</article>
		</main>
		<!-- // main -->

	</div>
	<script>
	(function($) {
		$(document).ready(function() {
			var source = {
				datatype: "json",
				datafields: [
					{ name: 'serial_number', type: 'number' },
					{ name: 'number', type: 'string' },
					{ name: 'regdate', type: 'string' },
					{ name: 'calls_type', type: 'string' },
					{ name: 'duration', type: 'number' },
					{ name: 'name', type: 'string' },
					{ name: 'title', type: 'title' },
					{ name: 'conts', type: 'conts' }
				],
	            type : "POST",
	            contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/carpe/calls_list.do"
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
				{text: 'Index', dataField: 'serial_number', width: '50px', cellsalign: 'right', align: 'center'},
				{text: 'Number', dataField: 'number', width: '120px', cellsalign: 'right', align: 'center'},
				{text: 'Date', dataField: 'regdate', width: '180px', cellsalign: 'center', align: 'center'},
				{text: 'Type', dataField: 'calls_type', width: '50px', cellsalign: 'center', align: 'center'},
				{text: 'Duration', dataField: 'duration', width: '80px', cellsalign: 'center', align: 'center'},
				{text: 'Name', dataField: 'name', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'Title', dataField: 'title', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'Conts', dataField: 'conts', width: '300px', cellsalign: 'center', align: 'center'}
			];
	
			$('#jqxGrid_Systemlog').on('bindingcomplete', function(event) {
				var localizationobj = {};
				localizationobj.emptydatastring = " ";
	
				$("#jqxGrid_Systemlog").jqxGrid('localizestrings', localizationobj);
			});
	
			$("#jqxGrid_Systemlog").jqxGrid({
				width: '100%',				
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
		});
	})(jQuery);
	
	</script>

</body>
</html>