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
						<li class="level02 on"><a href="/carpe/filesystem.do">Filesystem</a></li> 
						<li class="level02"><a href="/carpe/artifact.do">Artifact</a></li>
						<li class="level02"><a href="/carpe/search.do">String Search</a></li>
					<li><a href="/carpe/carving.do" class="icon recovery">Recovery</a></li>	
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
						<button type="button" class="btn-case-02" id="btnFileNameWordCloud"><span>Word Cloud</span></button>
					</li>
					<li>
						<button type="button" class="btn-case-02" id="btnDateTreeMap"><span>Data Tree Map</span></button>
					</li>
					<li>
						<button type="button" class="btn-case-02" id="btnHexView"><span>HEX VIEW</span></button>
					</li>
				</ul>				
			</section>
			<article class="container">
				<h4 class="blind">조회된 컨텐츠</h4>

				<!--// Content 영역 //-->
				<div id="jqxSplitter" class="content-box">

					<div class="aside">
						<div id="jqxTree_dirs" role="tree" data-role="treeview" class="aside-result"><!--// Tree 영역 //--></div>
					</div>

					<div class="content-area">
						<div id="jqxGrid_files" role="grid" class="cont-result"><!--// Table 영역 //--></div>
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
			// Word Cloud
			$('#btnFileNameWordCloud').click(function(e) {
				var popUrl = "/carpe/filename_wordcloud.do";
				var popOption = "width=900, height=750, resizable=no, scrollbars=no, status=no;";
				window.open(popUrl,"",popOption);
			});

			// Data Tree Map
			$('#btnDateTreeMap').click(function(e) {
				var node = $('#jqxTree_dirs').jqxTree('getSelectedItem');
				var dir_id;
				if (node) {
					var dir_id = node.value["id"];
				} else {
					return;
				}
				
				var popUrl = "/carpe/date_treemap.do?id=" + dir_id;
				var popOption = "width=900, height=750, resizable=no, scrollbars=no, status=no;";
				window.open(popUrl,"",popOption);
			});

			// Hex View
			$('#btnHexView').click(function(e) {
				var popUrl = "/carpe/hexview.do";
				var popOption = "width=1050, height=750, resizable=no, scrollbars=no, status=no;";
				window.open(popUrl,"",popOption);
			});

			// splitter
			$('#jqxSplitter').jqxSplitter({ width: '100%', height: '100%', panels: [{ min: 150, size: 200 }, { min: 300,}] });

			// tree
			function expandDirTree(node) {
				var param = {}, querystr, list;
				if (node && node.value) {
					param.id = node.value["id"];
					param.attr = node.value["attr"];
				} else {
					param.id = "";
				}
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
		    $("#jqxTree_dirs").jqxTree({ source: treeRootDir, allowDrag:false, width:'calc(100%)', height:'calc(100%)'});

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
				{text: 'Name', dataField: 'name', width: 'auto', cellsalign: 'left', align: 'center'}
			  , {text: 'Size', dataField: 'size', cellsformat : 'd', width: '120px', cellsalign: 'right', align: 'center'}
			  , {text: 'MD5', dataField: 'md5', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'Category', dataField: 'dir_type', width: '120px', cellsalign: 'center', align: 'center',
					cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
						var tmp = 'etc';
						if (value === 3) {
							tmp = 'Directory';
						} else if (value === 5) {
							tmp = 'File';
						}

						return '<div style="margin-top: 8px; text-align: center;">' + tmp + '</div>';
					}
			    }
			  , {text: 'Modified Time', dataField: 'mtime', width: '150px', cellsalign: 'center', align: 'center'}
			  , {text: 'Created Time', dataField: 'ctime', width: '150px', cellsalign: 'center', align: 'center'}
			  , {text: 'Accessed Time', dataField: 'atime', width: '150px', cellsalign: 'center', align: 'center'}
			];

			var dataAdapter = new $.jqx.dataAdapter(source, {
				contentType : 'application/json; charset=utf-8',
				formatData : function(data) {
					var node = $('#jqxTree_dirs').jqxTree('getSelectedItem');
					if (node) {
						data["id"] = node.value["id"];
						data["attr"] = node.value["attr"];
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
				width: 'calc(100% - 4rem)',
				height: 'calc(100% - 7rem)',
				source: dataAdapter,
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
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>