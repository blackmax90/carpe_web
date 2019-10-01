<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CARPE 검색</title>
<link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
<script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
<script type="text/javascript" src="/carpe/resources/js/common.js"></script>
<script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>

</head>

<body>
	<header class='outer'>
		<h1 style="display: inline;">CARPE</h1>
		<h3 style="display: inline; margin-left:20px;">
			Case [ <span style="color: #1f07f1;"><%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></span> ]
			> Evidence [ <span style="color: #ca0065;"><%=(String)session.getAttribute(Consts.SESSION_EVDNC_NAME)%></span> ]
		</h3>
	</header>
	<div class='outer'>
		<article class='outer'>
			<header class='inner'>
				<div id="checkbox_filename" style="display: inline-block;">파일명</div>
				<div id="checkbox_content" style="display: inline-block;">내용</div>
				<input type="text" id="search_word"/>
				&nbsp;&nbsp;&nbsp;<button type="button" id="btnViewList">목록보기</button>
				<button type="button" id="btnViewSummary">요약보기</button>
				&nbsp;&nbsp;&nbsp;<button type="button" id="btnSearch">검색</button>
			</header>
			<div class='inner'>
				<article class='inner'>
					<div id="jqxGrid_search"></div>
				</article>
			</div>
			<footer class='inner'>
				<div id="paing"></div>
			</footer>
		</article>
		<nav class='outer'>
			<ul>
				<li><a href="/carpe/case.do">Case</a></li>
				<li class="on"><a href="/carpe/evdnc.do">Evidence</a>
					<ul>
						<li><a href="/carpe/filesystem.do">File System</a></li>
						<li><a href="/carpe/artifact.do">Artifact</a></li>
						<li><a href="/carpe/search.do">검색</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	</div>
	<footer class='outer'>Footer</footer>

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
			$("#jqxGrid_search").jqxGrid('updateBoundData');
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
				alert(error);
			}
		});

		var columnSet_list = [
			{text: '파일명', datafield: 'name', width: '350px', cellsalign: 'left', align: 'center',
				cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
					var dataRecord = $("#jqxGrid_search").jqxGrid('getrowdata', row);
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
					var dataRecord = $("#jqxGrid_search").jqxGrid('getrowdata', row);
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

		$('#jqxGrid_search').on('bindingcomplete', function(event) {
			var localizationobj = {};
			localizationobj.emptydatastring = " ";

			$("#jqxGrid_search").jqxGrid('localizestrings', localizationobj);
			$("#jqxGrid_search").jqxGrid('pagesize', currentRowCount);
		});

		$("#jqxGrid_search").jqxGrid({
			width: '100%',
			height: '100%',
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
			$('#jqxGrid_search').jqxGrid({
				autorowheight: false,
				columns: columnSet_list
			});
		});
		
		$('#btnViewSummary').click(function(e) {
			$('#jqxGrid_search').jqxGrid({
				autorowheight: true,
				columns: columnSet_summary
			}); 
		});
		
		$('#btnSearch').click(function(e) {
			$("#jqxGrid_search").jqxGrid('updateBoundData');
		});
		
	});
})(jQuery);

</script>

</body>
</html>