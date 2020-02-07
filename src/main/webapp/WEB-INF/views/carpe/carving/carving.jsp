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
					<li><a href="#" class="icon analysis">Analysis</a></li>
					<!-- 2Depth Menu //-->
						<li class="level02 hide"><a href="#">Filesystem</a></li> 
						<li class="level02 hide"><a href="#">Artifact</a></li>
					<!--// 2Depth Menu -->
					<li class="on"><a href="/carpe/carving.do" class="icon recovery">Recovery</a></li>
						<li class="level02"><a href="/carpe/carving.do">Deleted Files</a></li>
						<li class="level02 on"><a href="/carpe/carving.do">File Carving</a></li>
						<li class="level02"><a href="/carpe/carving.do">Record Carving</a></li>
					<li><a href="/carpe/communication.do" class="icon visualization">Visualization</a></li>
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
				<div id="jqxSplitter" class="content-box">
					<div class="content-area">				
						<!--// Content 영역 //-->	
						<div id="jqxGrid_Systemlog" role="grid" align="left" class="cont-result">						
							<!--// Grid Table 영역 //-->
						</div>
						<div id="paing" class="paging-area">
						</div>
					</div>
				</div>
			</article>
		</main>
		<!-- // main -->

	</div>
	<!-- // wrap -->

	<script>
	(function($) {
		$(document).ready(function() {
			
			var pagesize = <%=Consts.PAGE_SZIE%>;
			var i, j;
			var currentPage = 1;
			var lastPage = 1;
			var currentRowCount = 0;
			var currentPageOffset = 1;
			var source = {
				datatype: "json",
				datafields: [
					{ name: 'serial_number', type: 'number' },
					{ name: 'category', type: 'string' },
					{ name: 'owner', type: 'string' },
					{ name: 'filename', type: 'string' },
					{ name: 'extension', type: 'string' },
					{ name: 'start', type: 'number' },
					{ name: 'last', type: 'number' },
					{ name: 'size', type: 'number' },
				],
	            type : "POST",
	            contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/carpe/carving_list.do"
			};

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
				{text: 'Index', dataField: 'serial_number', width: '50px', cellsalign: 'right', align: 'center'},
				{text: 'Cartegory', dataField: 'category', width: '150px', cellsalign: 'left', align: 'center'},
				{text: 'Owner', dataField: 'owner', width: '270px', cellsalign: 'center', align: 'center'},
				{text: 'Filename', dataField: 'filename', cellsalign: 'center', align: 'center'},
				{text: 'Extension', dataField: 'extension', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'Start', dataField: 'start', cellsformat : 'd', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'Last', dataField: 'last', cellsformat : 'd', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'Size', dataField: 'size', cellsformat : 'd', width: '120px', cellsalign: 'center', align: 'center'}
			];
	
			$('#jqxGrid_Systemlog').on('bindingcomplete', function(event) {
				var localizationobj = {};
				localizationobj.emptydatastring = " ";
	
				$("#jqxGrid_Systemlog").jqxGrid('localizestrings', localizationobj);
			});
	
			$("#jqxGrid_Systemlog").jqxGrid({
				width: '100%',	
				height: 'calc(100% - 7rem)',
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
		});
	})(jQuery);
	
	</script>

</body>
</html>