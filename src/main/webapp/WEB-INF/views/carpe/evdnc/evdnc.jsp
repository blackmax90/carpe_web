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
					<li class="on"><a href="/carpe/evdnc.do" class="icon evidence">Evidence</a></li>
					<li><a href="#" class="icon analysis">Analysis</a></li>
					<!-- 2Depth Menu //-->
						<li class="level02 hide"><a href="#">Filesystem</a></li> 
						<li class="level02 hide"><a href="#">Artifact</a></li>
					<!--// 2Depth Menu -->
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
						<div class="btn-area">
							<ul>
								<li>
									<button type="button" class="btn-case-01" id="btnNewEvdnc"><span class="icon ico-plus">Add Evidence</span></button>
								</li>
								<li>
									<button type="button" class="btn-case-01" id="btnDeleteEvdncs"><span class="icon ico-minus">Delete Evidence</span></button>
								</li>
							</ul>
						</div>				
						<div id="jqxGrid_Systemlog" role="grid" align="left" class="cont-result">						
							<!--// Grid Table 영역 //-->
						</div>
						<div id="paing" class="paging-area">
							<!--// Table Paging 영역 - 위치고정 //-->
							<div class="paginate">
								<button type="button" class="btn-paging icon ico-first"><span class="ir">처음</span></button>
								<button type="button" class="btn-paging icon ico-prev"><span class="ir">이전</span></button>
								<span class="num">
									<a href="#">81</a>
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
	
	<div id="addEvdncWindow" class="pop wrap-pop">
		<div id="addEvdncWindowHeader" class="pop-header" >
			<h1>Create Evidence</h1>
		</div>
		<div id="addEvdncWindowContent" class="pop-content">
		    <form action="/carpe/add_evdnc.do" method="post" enctype="multipart/form-data">
				<div class="data-type-1">
					<dl>
						<dt>Evidence Type :</dt>
						<dd>
							<div class="select">
								<select name="newEvdncSubType" id="newEvdncSubType">
									<option>EWF</option>
									<option>AFF</option>
									<option>RAW</option>
									<option>VMDK</option>
									<option>VHD</option>
								</select>
							</div>
						</dd>
					</dl>
					<dl>
						<dt>Name :</dt>
						<dd>
							<div class="input-text input-text-type-1">
								<input name="newEvdncName" id="newEvdncName" type="text" />
							</div>
						</dd>
					</dl>	
					<dl>
						<dt>파일 선택 :</dt>
						<dd>
							<div class="file-area">
								<input type="file" id="evdnc_file" name="evdnc_file"/>
	                			<div style='margin-top: 10px; overflow: hidden;' id='colorRanges'></div>
							</div>
						</dd>
					</dl>
				</div>
	            <div class="btn-area">
	                <ul>
			            <li><button type="button" class="btn-case-01" id="cancel" value="Cancel" >Cancel</button></li>
	                	<li><button type="button" class="btn-case-01" id="ok" value="OK">OK</button></li>
			        </ul>
	            </div>
			</form>
		</div>
	</div>

	<script>
	(function($) {
		$(document).ready(function() {
			var source = {
				datatype: "json",
				datafields: [
					{ name: 'serial_number', type: 'number' },
					{ name: 'evd_id', type: 'string' },
					{ name: 'evd_name', type: 'string' },
					{ name: 'evd_path', type: 'string' },
					{ name: 'tmp_path', type: 'string' },
					{ name: 'case_id', type: 'string' },
					{ name: 'main_type', type: 'string' },
					{ name: 'sub_type', type: 'string' },
					{ name: 'timezone', type: 'string' },
					{ name: 'acquired_date', type: 'string' },
					{ name: 'md5', type: 'string' },
					{ name: 'sha1', type: 'string' },
					{ name: 'sha256', type: 'string' },
					{ name: 'process_state', type: 'number' }
				],
	            type : "POST",
	            contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
				url: "/carpe/evdnc_list.do"
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
				{text: 'Evidence Name', dataField: 'evd_name', width: '150px', cellsalign: 'left', align: 'center',
					cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
						var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
						var evdncInfo = {};
						evdncInfo.id = dataRecord.evd_id;
						evdncInfo.name = value;
						var param = encodeQueryData(evdncInfo);
	
						return '<span style="padding: 7px; float: ' + columnproperties.cellsalign + '; color: #ff0000;"><a href="/carpe/select_evdnc.do?' + param + '">' + value + '</a></span>';
					}
				},
				{text: 'Main Type', dataField: 'main_type', width: '90px', cellsalign: 'center', align: 'center',
					renderer: function () {
		            	return '<div style="margin: 3px; text-align: center;">Main<br />Type</div>';
		        	}
				},
				{text: 'Sub Type', dataField: 'sub_type', width: '90px', cellsalign: 'center', align: 'center',
					renderer: function () {
		            	return '<div style="margin: 3px; text-align: center;">Sub<br />Type</div>';
		        	}
				},
				{text: 'Acquired Date', dataField: 'acquired_date', width: '170px', cellsalign: 'center', align: 'center'},
				{text: 'MD5', dataField: 'md5', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'SHA1', dataField: 'sha1', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'SHA256', dataField: 'sha256', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'Process State', dataField: 'process_state', width: '120px', cellsalign: 'center', align: 'center'},
				{text: 'Evidence Path', dataField: 'evd_path', cellsalign: 'left', align: 'center',
					cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
						var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
						var evdncInfo = {};
						evdncInfo.id = dataRecord.evd_id;
						var param = encodeQueryData(evdncInfo);
	
						return '<span style="width: 100%; display: block; overflow: hidden; text-overflow: ellipsis;  white-space: nowrap; margin: 7px; float: ' + columnproperties.cellsalign + '; color: #ff0000;"><a title="' + value + '" target="_blank" href="/carpe/download_evdnc.do?' + param + '">' + value + '</a></span>';
					}
				}
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
	
			$('#addEvdncWindow').jqxWindow({  width: 400, height: 300, resizable: false
				, cancelButton: $('#cancel'), autoOpen: false, resizable: false, isModal: true, modalOpacity: 0.3
	        });
	
			$('#btnNewEvdnc').click(function(e) {
				$("#newEvdncSubType option:eq(0)").prop("selected", true);
	        	$('#newEvdncName').val('');
	        	$('input[type=file]').val('');
				
	        	$('#ok').prop('disabled',false);
	        	$("#colorRanges").val(0);
	
	        	$('#addEvdncWindow').jqxWindow('open');
			});
	
			$('#ok').click(function(e) {
				e.preventDefault();
	
				if (!checkInput('Name', '#newEvdncName')) {
	        		return;
	        	}
	
			    if (!$("#evdnc_file")[0].files.length) {
					alert('파일을 선택해 주십시오.');
					$("#evdnc_file").focus();
			    	return;
			    }
	
			    var that = $(this);
	
				that.prop('disabled',true);
	
				var form = document.forms[0];
				var formData = new FormData(form);
	
				var ajaxReq = $.ajax({
					url : '/carpe/add_evdnc.do',
					type : 'POST',
					data : formData,
					cache : false,
					contentType : false,
					processData : false,
					xhr: function(){
						//Get XmlHttpRequest object
						 var xhr = $.ajaxSettings.xhr() ;
	
						//Set onprogress event handler
						 xhr.upload.onprogress = function(event){
							var perc = Math.round((event.loaded / event.total) * 100);
				        	$("#colorRanges").val(perc);
						 };
						 return xhr ;
					},
					beforeSend: function( xhr ) {
						//Reset progress bar
			        	$("#colorRanges").val(0);
	                }
				});
	
				ajaxReq.done(function(data) {
					$('#addEvdncWindow').jqxWindow('close');
					$("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
	
					alert(data.msg);
				});
	
				ajaxReq.fail(function(jqXHR) {
		        	$("#colorRanges").val(0);
					
		        	that.prop('disabled',false);
	
					alert(jqXHR.responseJSON.msg + '('+ jqXHR.status + ' - ' + jqXHR.statusText + ')');
				});
	
				$("#colorRanges").jqxProgressBar({
					showText: true,
					renderText: function (text, value) {
						if (value < 60) {
							return "<span class='jqx-rc-all' style='color: #333;'>" + text + "</span>";
						} else {
							return "<span class='jqx-rc-all' style='color: #fff;'>" + text + "</span>";
						}
					},
					colorRanges: [{ stop: 20, color: "#33b5e5" }, { stop: 50, color: "#98ca00" }, { stop: 80, color: "#ff4444" }, { stop: 100, color: "#aa66cc" }],
					width: 222,
					height: 24,
					value: 0
				});
			});
		});
	})(jQuery);
	
	</script>

</body>
</html>