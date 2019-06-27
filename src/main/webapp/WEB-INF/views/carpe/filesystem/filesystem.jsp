<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CARPE File System</title>
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
				<button type="button" id="btnNewCase">New</button>
				<button type="button" id="btnDeleteCases">Delete</button>
			</header>
			<div class='inner'>
				<article class='inner'>
					<div id='jqxSplitter'>
						<div><div id="jqxTree_dirs"></div></div>
						<div><div id="jqxGrid_files"></div></div>
					</div>
				</article>
			</div>
			<footer class='inner'>Footer</footer>
		</article>
		<nav class='outer'>
			<ul>
				<li><a href="/carpe/case.do">Case</a></li>
				<li class="on"><a href="/carpe/evdnc.do">Evidence</a>
					<ul>
						<li><a href="/carpe/filesystem.do">File System</a></li>
						<li><a href="/carpe/artifact.do">Artifact</a></li>
					</ul>
				</li>
			</ul>
		</nav>
	</div>
	<footer class='outer'>Footer</footer>

<script>
(function($) {
	$(document).ready(function() {
		// splitter
		$('#jqxSplitter').jqxSplitter({ width: '100%', height: '100%', panels: [{ min: 150, size: 200 }, { min: 300 }] });

		// tree
		function expandDirTree(node) {
			var param = {}, querystr, list;
			param.id = ((node && node.value) ? node.value["id"] : <%=Consts.TREE_ROOT_ID%>);
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
	    $("#jqxTree_dirs").jqxTree({ source: treeRootDir, allowDrag:false, width:'100%', height:'100%'});

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
	    if (treeItems && treeItems.length) {
		    var firstItem = treeItems[0];

		    $('#jqxTree_dirs').jqxTree('selectItem', firstItem);
	    }

	    var source = {
			datatype: "json",
			datafields: [
				{ name: 'id', type: 'string' },
				{ name: 'name', type: 'string' },
				{ name: 'size', type: 'number' },
				{ name: 'md5', type: 'string' },
				{ name: 'dir_type', type: 'number' },
				{ name: 'ctime', type: 'string' },
				{ name: 'atime', type: 'string' },
				{ name: 'mtime', type: 'string' }
			],
            type: "POST",
            contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
			url: "/carpe/file_list.do"
		};

		var columnSet = [
			{text: '파일명', dataField: 'name', width: '170px', cellsalign: 'left', align: 'center'}
		  , {text: '크기', dataField: 'size', cellsformat : 'd', width: '150px', cellsalign: 'right', align: 'center'}
		  , {text: 'MD5', dataField: 'md5', width: '100px', cellsalign: 'center', align: 'center'}
		  , {text: 'Category', dataField: 'dir_type', width: '100px', cellsalign: 'center', align: 'center',
				cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
					var tmp = '기타';
					if (value === 3) {
						tmp = '폴더';
					} else if (value === 5) {
						tmp = '파일';
					}

					return '<div style="margin-top: 8px; text-align: center;">' + tmp + '</div>';
				}
		    }
		  , {text: '수정일시', dataField: 'mtime', width: '170px', cellsalign: 'center', align: 'center'}
		  , {text: '생성일시', dataField: 'ctime', width: '170px', cellsalign: 'center', align: 'center'}
		  , {text: '접근일시', dataField: 'atime', width: '170px', cellsalign: 'center', align: 'center'}
		];

		var dataAdapter = new $.jqx.dataAdapter(source, {
			contentType : 'application/json; charset=utf-8',
			formatData : function(data) {
				var node = $('#jqxTree_dirs').jqxTree('getSelectedItem');
				if (node) {
					data["id"] = node.value["id"];
				}
				//data["id"] = 5;
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
			width: '100%',
			height: '100%',
			source: dataAdapter,
			selectionmode: 'checkbox', // 'none',
			columnsresize: true,
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
			columns: columnSet
		});

		$("#jqxTree_dirs").on('select',function (event){
			$("#jqxGrid_files").jqxGrid('updateBoundData');
		});
	});
})(jQuery);

</script>

</body>
</html>