﻿<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<div class="wrap srch-page bg-theme blue">

		<!-- header -->
		<%@ include file="../common/header.jsp" %>
		<!-- // header -->

		<!-- nav -->
		<c:import url="../common/left_nav.jsp">
		  <c:param name="d1" value="analysis"></c:param>
		  <c:param name="d2" value="stringsearch"></c:param>
		</c:import>
		<!-- // nav -->
		
		<!-- main -->
		<main class="main">
			<section class="tit-area">
				<h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%> </h3>
				<h3>Evidence : <%=(String)session.getAttribute(Consts.SESSION_EVDNC_NAME)%> </h3>
				<button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button>
		        <div class="location-area">
					<ul class="list-h">
						<li>Home</li>
						<li>Analysis</li>
						<li>String Search</li>
					</ul>
				</div>
			</section>
			<section class="search-area bg-unit">
				<h4 class="blind">조회조건 선택</h4>
				<form action="" id="" name="" method="" onSubmit="return false">
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
							<button type="button" class="btn-case-01" id="btnViewList"><span class="icon ico-view-list">List View</span></button>
						</li>
						<li>
							<button type="button" class="btn-case-01" id="btnViewSummary"><span class="icon ico-view-summary">Summary View</span></button>
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
						return '<div style="padding: 7px; overflow: hidden; text-overflow: ellipsis;"><a href="/carpe/download_search.do?path=' + dataRecord.download_path + '" target="_blank">' + viewname + '</a></div>';
					}
				}
			   ,{text: 'File Size', dataField: 'size', cellsformat : 'd', width: '150px', cellsalign: 'center', align: 'center',
					cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
						var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
						return '<div style="padding: 7px; overflow: hidden; text-overflow: ellipsis; text-align:center">'+ fileSizeSI(dataRecord.size) + '</div>';
						
					}
				}
			   ,{text: 'Author', width: '100px', datafield: 'author', cellsalign: 'center', align: 'center'}
			   ,{text: 'Last saved by', width: '100px', datafield: 'lastsavedby', cellsalign: 'center', align: 'center'}
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
				height: 'calc(100% - 3rem)',
				source: dataAdapter,
				//selectionmode: 'checkbox',
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
			
			$("#search_word").keypress(function(e) { 
			    if (e.keyCode == 13){
			    	$("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
			    }    
			});
		});
	})(jQuery);
	</script>
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>