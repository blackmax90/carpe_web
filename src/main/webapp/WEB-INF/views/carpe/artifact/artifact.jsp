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
		    
			artifactKind["Operating System"] = {};
			artifactKind["Operating System"].url = "/carpe/operating_system.do";
			artifactKind["Operating System"].columnSet = [
				{text: 'par_id', dataField: 'par_id', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'os_type', dataField: 'os_type', width: '100px', cellsalign: 'center', align: 'center'}
			  , {text: 'product_name', dataField: 'product_name', width: '180px', cellsalign: 'center', align: 'center'}
			  , {text: 'release_id', dataField: 'release_id', width: '90px', cellsalign: 'center', align: 'center'}
			  , {text: 'os_version', dataField: 'os_version', width: '90px', cellsalign: 'center', align: 'center'}
			  , {text: 'build_version', dataField: 'build_version', width: '200px', cellsalign: 'left', align: 'center'}
			  , {text: 'product_id', dataField: 'product_id', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'owner', dataField: 'owner', width: '100px', cellsalign: 'center', align: 'center'}
			  , {text: 'install_date (UTC+0)', dataField: 'install_date', width: '170px', cellsalign: 'center', align: 'center'}
			];
			
			artifactKind["Installed Application"] = {};
			artifactKind["Installed Application"].url = "/carpe/installed_app.do";
			artifactKind["Installed Application"].columnSet = [
				{text: 'par_id', dataField: 'par_id', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'app_name', dataField: 'app_name', width: '100px', cellsalign: 'center', align: 'center'}
			  , {text: 'app_version', dataField: 'app_version', width: '180px', cellsalign: 'center', align: 'center'}
			  , {text: 'publisher', dataField: 'publisher', width: '90px', cellsalign: 'center', align: 'center'}
			  , {text: 'installation_path', dataField: 'installation_path', width: '90px', cellsalign: 'center', align: 'center'}
			  , {text: 'source_path', dataField: 'source_path', width: '200px', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Storage Device"] = {};
			artifactKind["Storage Device"].url = "/carpe/storage_device.do";
			artifactKind["Storage Device"].columnSet = [
				{text: 'par_id', dataField: 'par_id', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'storage_type', dataField: 'storage_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'device_type', dataField: 'device_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'device_name', dataField: 'device_name', width: '250px', cellsalign: 'left', align: 'center'}
			  , {text: 'serial_number', dataField: 'serial_number', width: '180px', cellsalign: 'left', align: 'center'}			  
			  , {text: 'first_connect_time (UTC+0)', dataField: 'first_connect_time', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'first_disconnect_time (UTC+0)', dataField: 'first_disconnect_time', width: '100px', cellsalign: 'center', align: 'center'}
			  , {text: 'first_connect_time_after_last_boot (UTC+0)', dataField: 'first_connect_time_after_last_boot', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'first_disconnect_time_after_last_boot (UTC+0)', dataField: 'first_disconnect_time_after_last_boot', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'last_connect_time (UTC+0)', dataField: 'last_connect_time', width: '170px', cellsalign: 'center', align: 'center'}
			];
			
			artifactKind["History"] = {};
			artifactKind["History"].url = "/carpe/web_history.do";
			artifactKind["History"].columnSet = [
				{text: 'par_id', dataField: 'par_id', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'browser_type', dataField: 'browser_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'time_type', dataField: 'time_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'time (UTC+0)', dataField: 'time', width: '250px', cellsalign: 'left', align: 'center'}
			  , {text: 'visit_url', dataField: 'visit_url', width: '180px', cellsalign: 'left', align: 'center'}			  
			  , {text: 'title', dataField: 'title', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'visit_count', dataField: 'visit_count', width: '100px', cellsalign: 'center', align: 'center'}
			];
			
			artifactKind["Download"] = {};
			artifactKind["Download"].url = "/carpe/web_download.do";
			artifactKind["Download"].columnSet = [
				{text: 'par_id', dataField: 'par_id', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'browser_type', dataField: 'browser_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'time_type', dataField: 'time_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'download_time (UTC+0)', dataField: 'down_time', width: '250px', cellsalign: 'left', align: 'center'}
			  , {text: 'download_url', dataField: 'down_url', width: '180px', cellsalign: 'left', align: 'center'}			  
			  , {text: 'saved_path', dataField: 'save_path', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'file_size', dataField: 'file_size', width: '100px', cellsalign: 'center', align: 'center'}
			];
			
			artifactKind["Cache"] = {};
			artifactKind["Cache"].url = "/carpe/web_cache.do";
			artifactKind["Cache"].columnSet = [
				{text: 'par_id', dataField: 'par_id', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'browser_type', dataField: 'browser_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'time_type', dataField: 'time_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'time', dataField: 'time', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'cache_url', dataField: 'cache_url', width: '250px', cellsalign: 'left', align: 'center'}
			  , {text: 'cache_name', dataField: 'cache_name', width: '180px', cellsalign: 'left', align: 'center'}			  
			  , {text: 'cache_size', dataField: 'cache_size', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'mimie_type', dataField: 'mimie_type', width: '100px', cellsalign: 'center', align: 'center'}
			];
			
			artifactKind["Cookie"] = {};
			artifactKind["Cookie"].url = "/carpe/web_cookie.do";
			artifactKind["Cookie"].columnSet = [
				{text: 'par_id', dataField: 'par_id', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'browser_type', dataField: 'browser_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'time_type', dataField: 'time_type', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'time', dataField: 'time', width: '120px', cellsalign: 'center', align: 'center'}
			  , {text: 'host_url', dataField: 'host_url', width: '250px', cellsalign: 'left', align: 'center'}
			  , {text: 'path', dataField: 'cache_name', width: '180px', cellsalign: 'left', align: 'center'}			  
			  , {text: 'cookie_key', dataField: 'cookie_key', width: '170px', cellsalign: 'center', align: 'center'}
			  , {text: 'cookie_value', dataField: 'cookie_value', width: '100px', cellsalign: 'center', align: 'center'}
			];
			
			artifactKind["Application List"] = {};
			artifactKind["Application List"].url = "/carpe/sqlite_list.do?div=application_list";
			artifactKind["Application List"].columnSet = [
				 {text: 'is_deleted', dataField: 'is_deleted', width: '5%', cellsalign: 'left', align: 'center'}
				,{text: 'category', dataField: 'category', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'package_name', dataField: 'package_name', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'app_name', dataField: 'app_name', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'version', dataField: 'version', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'installed_time', dataField: 'installed_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'apk_changed_time', dataField: 'apk_changed_time', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'updated_time', dataField: 'updated_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'deleted_time', dataField: 'deleted_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'fs_ctime', dataField: 'fs_ctime', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'fs_crtime', dataField: 'fs_crtime', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'fs_atime', dataField: 'fs_atime', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'fs_mtime', dataField: 'fs_mtime', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'is_updated', dataField: 'is_updated', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'source', dataField: 'source', width: '5%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Call History"] = {};
			artifactKind["Call History"].url = "/carpe/sqlite_list.do?div=call_history";
			artifactKind["Call History"].columnSet = [
				 {text: 'package_name', dataField: 'package_name', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp', dataField: 'timestamp', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'time_duration', dataField: 'time_duration', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'phonenumber', dataField: 'phonenumber', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'account', dataField: 'account', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'digit_positive', dataField: 'digit_positive', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'file', dataField: 'file', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'contents', dataField: 'contents', width: '5%', cellsalign: 'left', align: 'center'}
				,{text: 'source', dataField: 'source', width: '5%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["File History"] = {};
			artifactKind["File History"].url = "/carpe/sqlite_list.do?div=web_browser";
			artifactKind["File History"].columnSet = [
				 {text: 'package_name', dataField: 'package_name', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp', dataField: 'timestamp', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'file', dataField: 'file', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'phonenumber', dataField: 'phonenumber', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'account', dataField: 'account', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'contents', dataField: 'contents', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Geo Data"] = {};
			artifactKind["Geo Data"].url = "/carpe/sqlite_list.do?div=geodata";
			artifactKind["Geo Data"].columnSet = [
				 {text: 'package_name', dataField: 'package_name', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp', dataField: 'timestamp', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'geodata', dataField: 'geodata', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["ID/Password Hash"] = {};
			artifactKind["ID/Password Hash"].url = "/carpe/sqlite_list.do?div=id_password_hash";
			artifactKind["ID/Password Hash"].columnSet = [
				 {text: 'package_name', dataField: 'package_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'url', dataField: 'url', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'account', dataField: 'account', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'pwd', dataField: 'pwd', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			artifactKind["Web Browser"] = {};
			artifactKind["Web Browser"].url = "/carpe/sqlite_list.do?div=web_browser";
			artifactKind["Web Browser"].columnSet = [
				 {text: 'package_name', dataField: 'package_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'url', dataField: 'url', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'account', dataField: 'account', width: '20%', cellsalign: 'left', align: 'center'}
				,{text: 'digit_positive', dataField: 'digit_positive', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'file', dataField: 'file', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			// lv1
			// lv1_os_win_event_logs
			artifactKind["EventLogs"] = {};
			artifactKind["EventLogs"].url = "/carpe/eventlogs.do";
			artifactKind["EventLogs"].columnSet = [
				 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'event_type', dataField: 'event_type', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'security_user_id', dataField: 'security_user_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'created_time', dataField: 'created_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'event_description_summary', dataField: 'event_description_summary', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'error_level', dataField: 'error_level', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'keywords', dataField: 'keywords', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'provider_name', dataField: 'provider_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'task_category', dataField: 'task_category', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'computer_name', dataField: 'computer_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'event_data', dataField: 'event_data', width: '40%', cellsalign: 'left', align: 'center'}				
			];
			
			//lv1_os_win_jumplist
			artifactKind["JumpList"] = {};
			artifactKind["JumpList"].url = "/carpe/jumplist.do";
			artifactKind["JumpList"].columnSet = [
				 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'app_id', dataField: 'app_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'app_name', dataField: 'app_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_file_path', dataField: 'target_file_path', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'arguments', dataField: 'arguments', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'volume_name', dataField: 'volume_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'volume_serial_number', dataField: 'volume_serial_number', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_file_created_time', dataField: 'target_file_created_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_file_last_modified_time', dataField: 'target_file_last_modified_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_file_last_accessed_time', dataField: 'target_file_last_accessed_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'jump_list_type', dataField: 'jump_list_type', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'drive_type', dataField: 'drive_type', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'computer_name', dataField: 'computer_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_mac_address', dataField: 'target_mac_address', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_file_size', dataField: 'target_file_size', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'entry_created_time', dataField: 'entry_created_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'entry_last_accessed_time', dataField: 'entry_last_accessed_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'entry_id', dataField: 'entry_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'most_recent_used', dataField: 'most_recent_used', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'interaction_count', dataField: 'interaction_count', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_file_attributes', dataField: 'target_file_attributes', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_id_absolute_path', dataField: 'target_id_absolute_path', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_mft_entry_number', dataField: 'target_mft_entry_number', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'target_mft_sequence_number', dataField: 'target_mft_sequence_number', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'pin_status', dataField: 'pin_status', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'file_birth_droid', dataField: 'file_birth_droid', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'volume_birth_droid', dataField: 'volume_birth_droid', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'file_droid', dataField: 'file_droid', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'volume_droid', dataField: 'volume_droid', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			//lv1_os_win_reg_amcache_file_entries
			artifactKind["Reg Amcache File Entries"] = {};
			artifactKind["Reg Amcache File Entries"].url = "/carpe/reg_amcache_file_entries.do";
			artifactKind["Reg Amcache File Entries"].columnSet = [
				 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'key_last_updated_time', dataField: 'key_last_updated_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'file_extension', dataField: 'file_extension', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'program_id', dataField: 'program_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'key_id', dataField: 'key_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'sha1_hash', dataField: 'sha1_hash', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'os_component_flag', dataField: 'os_component_flag', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'full_path', dataField: 'full_path', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'link_date', dataField: 'link_date', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'product_name', dataField: 'product_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'size', dataField: 'size', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'version', dataField: 'version', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'product_version', dataField: 'product_version', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'long_path_hash', dataField: 'long_path_hash', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'binary_type', dataField: 'binary_type', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'pe_file_flag', dataField: 'pe_file_flag', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'binary_file_version', dataField: 'binary_file_version', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'binary_product_version', dataField: 'binary_product_version', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'language_code', dataField: 'language_code', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'usn', dataField: 'usn', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'legacy_flag', dataField: 'legacy_flag', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'volume_guid', dataField: 'volume_guid', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'publisher', dataField: 'publisher', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'switch_back_context', dataField: 'switch_back_context', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_modified_time', dataField: 'last_modified_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'created_time', dataField: 'created_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_modified_2_time', dataField: 'last_modified_2_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'pe_header_filed_size_of_image', dataField: 'pe_header_filed_size_of_image', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'pe_header_hash', dataField: 'pe_header_hash', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'pe_header_checksum', dataField: 'pe_header_checksum', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			//lv1_os_win_reg_installed_programs
			artifactKind["Reg Installed Programs"] = {};
			artifactKind["Reg Installed Programs"].url = "/carpe/reg_installed_programs.do";
			artifactKind["Reg Installed Programs"].columnSet = [
				 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'company', dataField: 'company', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'created_date', dataField: 'created_date', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'key_last_updated_time', dataField: 'key_last_updated_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'install_size', dataField: 'install_size', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'version', dataField: 'version', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'potential_location', dataField: 'potential_location', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			//lv1_os_win_reg_os_info
			artifactKind["Reg OS Info"] = {};
			artifactKind["Reg OS Info"].url = "/carpe/reg_os_info.do";
			artifactKind["Reg OS Info"].columnSet = [
				 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'operating_system', dataField: 'operating_system', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'version_number', dataField: 'version_number', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'install_time', dataField: 'install_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'product_key', dataField: 'product_key', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'owner', dataField: 'owner', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'display_computer_name', dataField: 'display_computer_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'computer_name', dataField: 'computer_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'dhcp_dns_server', dataField: 'dhcp_dns_server', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'operating_system_version', dataField: 'operating_system_version', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'build_number', dataField: 'build_number', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'product_id', dataField: 'product_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_service_pack', dataField: 'last_service_pack', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'organization', dataField: 'organization', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_shutdown_time', dataField: 'last_shutdown_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'system_root', dataField: 'system_root', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_access_time_flag', dataField: 'last_access_time_flag', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'timezone_utc', dataField: 'timezone_utc', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'display_timezone_name', dataField: 'display_timezone_name', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			//lv1_os_win_reg_usb_devices
			artifactKind["Reg USB Devices"] = {};
			artifactKind["Reg USB Devices"].url = "/carpe/reg_usb_devices.do";
			artifactKind["Reg USB Devices"].columnSet = [
				 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'device_class_id', dataField: 'device_class_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'serial_number', dataField: 'serial_number', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_connected_time', dataField: 'last_connected_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'device_description', dataField: 'device_description', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'friendly_name', dataField: 'friendly_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'manufacturer', dataField: 'manufacturer', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_assigned_drive_letter', dataField: 'last_assigned_drive_letter', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'volume_GUID', dataField: 'volume_GUID', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'volume_serial_number_decimal', dataField: 'volume_serial_number_decimal', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'volume_serial_number_hex', dataField: 'volume_serial_number_hex', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'associated_user_accounts', dataField: 'associated_user_accounts', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'first_connected_time', dataField: 'first_connected_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'first_connected_since_reboot_time', dataField: 'first_connected_since_reboot_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'driver_install_time', dataField: 'driver_install_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'first_install_time', dataField: 'first_install_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_insertion_time', dataField: 'last_insertion_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_removal_time', dataField: 'last_removal_time', width: '10%', cellsalign: 'left', align: 'center'}
			];
			
			//lv1_os_win_reg_user_accounts
			artifactKind["Reg User Accounts"] = {};
			artifactKind["Reg User Accounts"].url = "/carpe/reg_user_accounts.do";
			artifactKind["Reg User Accounts"].columnSet = [
				 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'user_name', dataField: 'user_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'full_name', dataField: 'full_name', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'type_of_user', dataField: 'type_of_user', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'account_description', dataField: 'account_description', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'security_identifier', dataField: 'security_identifier', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'user_group', dataField: 'user_group', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'login_script', dataField: 'login_script', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'profile_path', dataField: 'profile_path', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_login_time', dataField: 'last_login_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_password_change_time', dataField: 'last_password_change_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'last_incorrect_password_login_time', dataField: 'last_incorrect_password_login_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'login_count', dataField: 'login_count', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'account_disabled', dataField: 'account_disabled', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'password_required', dataField: 'password_required', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'password_hint', dataField: 'password_hint', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'lm_hash', dataField: 'lm_hash', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'ntlm_hash', dataField: 'ntlm_hash', width: '10%', cellsalign: 'left', align: 'center'}
			];	
			
			// lv1_app_web_chrome_visit_urls
			artifactKind["Chrome Visit Urls"] = {};
			artifactKind["Chrome Visit Urls"].url = "/carpe/chrome_visit_urls.do";
			artifactKind["Chrome Visit Urls"].columnSet = [
				 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'url', dataField: 'url', width: '50%', cellsalign: 'left', align: 'center'}
				,{text: 'last_visited_time', dataField: 'last_visited_time', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'visit_count', dataField: 'visit_count', width: '10%', cellsalign: 'left', align: 'center'}
				,{text: 'typed_count', dataField: 'typed_count', width: '10%', cellsalign: 'left', align: 'center'}
			]
			
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