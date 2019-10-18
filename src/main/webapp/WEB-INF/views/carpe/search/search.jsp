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
						<li class="level02 on"><a href="/carpe/search.do">검색</a></li>
					<li><a href="#" class="icon visualization">Visualization</a></li>
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
			<article class="container">
				<h4 class="blind">조회된 컨텐츠</h4>
				<div class="jqx-reset jqx-splitter jqx-widget jqx-widget-content content-box">
					<div class="jqx-widget-content jqx-splitter-panel jqx-reset content-area">				
						<!--// Content 영역 //-->	
						<div class="btn-area">
							<ul class="search-item-area">
								<li>
									<div class="checkbox checkbox-type-1">
										<input id="checkbox_filename" name="checkbox_filename" type="checkbox">
										<label for="filename"><span class="text">파일명</span></label>
									</div>
								</li>
								<li>
									<div class="checkbox checkbox-type-1">
										<input id="checkbox_content" name="checkbox_content" type="checkbox">
										<label for="filename"><span class="text">내용</span></label>
									</div>
								</li>
								<li>
									<div class="input-text input-text-type-1 fl w300">
										<input id="search_word" name="search_word" type="text" placeholder="검색어를 입력해주세요.">
									</div>
									<button type="button" id="btnSearch" class="btn-case-01 btn-search">
										<span class="icon ico-search">검색</span>
									</button>
								</li>
								<li>
									<button type="button" class="btn-case-01" id="btnViewList">
										<span class="icon ico-view-list">목록보기</span>
									</button>
								</li>
								<li>
									<button type="button" class="btn-case-01" id="btnViewSummary">
										<span class="icon ico-view-summary">요약보기</span>
									</button>
								</li>
							</ul>
						</div>
						<div id="jqxGrid_Systemlog" role="grid" align="left" class="jqx-grid jqx-reset jqx-rc-all jqx-widget jqx-widget-content empty-area">
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
	        var pagesize = <%=Consts.PAGE_SZIE%>;
			var currentPage = 1;
			var lastPage = 1;
			var currentRowCount = 0;
			var currentPageOffset = 1;

			$("#checkbox_filename").jqxCheckBox({ width: 65, height: 25, checked: true });
			$("#checkbox_content").jqxCheckBox({ width: 55, height: 25, checked: true });
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
					{ name: 'content', type: 'content' },
				],
	            type : "POST",
	            contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/carpe/search_list.do"
			};

			var dataAdapter = new $.jqx.dataAdapter(source, {
				contentType : 'application/json; charset=utf-8',
				formatData : function(data) {
					console.log(data);
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

					$('#paing').empty();

					if (totalcount < 1) {
						return;
					}

					var $divpageele = $('<div class="paginate">');
					var $firstele = $('<button type="button" class="btn-paging icon ico-first"><span class="ir">처음</span></button>');
					var $prevele = $('<button type="button" class="btn-paging icon ico-prev"><span class="ir">이전</span></button>');
					var $spanele = $('<span class="num">');
					var $nextele = $('<button class="btn-paging icon ico-next"><span class="ir">다음</span></button>');
					var $lastele = $('<button class="btn-paging icon ico-last"><span class="ir">마지막</span></button>');
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
					alert(error);
				}
			});

			var columnSet_list = [
				{text: '파일명', datafield: 'name', width: '350px', cellsalign: 'left', align: 'center',
					cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
						var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
						var highlight_nm = dataRecord.highlight_nm;
						return '<div style="margin: 7px; overflow: hidden; text-overflow: ellipsis;">' + highlight_nm + '</div>';
					}
				}
			   ,{text: '크기', dataField: 'size', cellsformat : 'd', width: '150px', cellsalign: 'right', align: 'center'}
			   ,{text: 'Author', width: '150px', datafield: 'author', cellsalign: 'center', align: 'center'}
			   ,{text: '최종수정일시일시', width: '200px', datafield: 'last_written_time', cellsalign: 'center', align: 'center'}
			   ,{text: '파일경로', datafield: 'path', cellsalign: 'left', align: 'center'}
			];

			var columnSet_summary = [
				{text: '', dataField: 'name', width: '94%', cellsalign: 'left',align: 'center',
					cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
						var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
						var strHtml = "<ul class='unfold-ist'><li class='title'><div class='tit'>";
						strHtml += "<span style='font-size:11pt;'>&nbsp;" + dataRecord.highlight_nm + "</span></div></li>";

						var last_written_time = "시간정보가 없습니다.";
						if(dataRecord.last_written_time){
							last_written_time = dataRecord.last_written_time;
						}

						strHtml += "<li class='dates'>";
						strHtml += "<span><strong>수정</strong> : " + last_written_time + "</span>";
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

			$('#btnViewList').click(function(e) {
				$('#jqxGrid_Systemlog').jqxGrid({
					autorowheight: false,
					columns: columnSet_list
				});
			});
			
			$('#btnViewSummary').click(function(e) {
				$('#jqxGrid_Systemlog').jqxGrid({
					autorowheight: true,
					columns: columnSet_summary
				}); 
			});
			
			$('#btnSearch').click(function(e) {
				$("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
			});
			
		});
	})(jQuery);
	</script>
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>