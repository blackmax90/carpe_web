<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CARPE Artifact</title>
<link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
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
				<button type="button" id="btnTimeLine">Time Line</button>
			</header>
			<div class='inner'>
				<article class='inner'>
					<div id='jqxSplitter'>
						<div><div id="jqxTree_artifacts"></div></div>
						<div><div id="jqxGrid_artifact"></div></div>
					</div>
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
			{text: 'aaa', dataField: 'MACB', width: '70px', cellsalign: 'left', align: 'center'}
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
			$("#jqxGrid_artifact").jqxGrid('updateBoundData');
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

		$('#jqxGrid_artifact').on('bindingcomplete', function(event) {
			var localizationobj = {};
			localizationobj.emptydatastring = " ";

			$("#jqxGrid_artifact").jqxGrid('localizestrings', localizationobj);
			$("#jqxGrid_artifact").jqxGrid('pagesize', currentRowCount);
		});

		$("#jqxGrid_artifact").jqxGrid({
			width: '100%',
			height: '100%',
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
			$('#jqxGrid_artifact').jqxGrid({ columns: columnSet });

			currentPage = 1;

			$("#jqxGrid_artifact").jqxGrid('updateBoundData');
		});
	});
})(jQuery);

</script>

</body>
</html>