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
  <div class="wrap bg-theme blue">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>
    <!-- // header -->

    <!-- nav -->
    <c:import url="../common/left_nav.jsp">
      <c:param name="d1" value="analysis"></c:param>
      <c:param name="d2" value="artifact"></c:param>
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
				<li>Artifact</li>
			</ul>
		</div>
      </section>
     <!--  <section class="btn-area">
        <ul>
          <li>
            
          </li>
        </ul>        
      </section> -->
      <article class="container">
        <h4 class="blind">조회된 컨텐츠</h4>
        <!--// Content 영역 //-->
        <div id="jqxSplitter" class="content-box">

          <div class="aside">
            <div id="jqxTree_artifacts" role="tree" data-role="treeview" class="aside-result"><!--// Tree 영역 //--></div>
          </div>

          <div class="content-area">
            <div id="jqxGrid_Systemlog" role="grid" class="cont-result"><!--// Table 영역 //--></div>
            <div id="paing" class="paging-area">
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
      
      
      // ############### lv1 ###############
      
      // lv1_os_win_event_logs
      artifactKind["All"] = {};
      artifactKind["All"].url = "/carpe/eventlogs.do";
      artifactKind["All"].columnSet = [
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
      
      // lv1_os_win_event_logs_antiforensics
      artifactKind["Antiforensics"] = {};
      artifactKind["Antiforensics"].url = "/carpe/eventlogs_antiforensics.do";
      artifactKind["Antiforensics"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}        
      ];
      
      // lv1_os_win_event_logs_applications
      artifactKind["Applications"] = {};
      artifactKind["Applications"].url = "/carpe/eventlogs_apps.do";
      artifactKind["Applications"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'application_name', dataField: 'application_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'resolver_name', dataField: 'resolver_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_event_logs_dns
      artifactKind["DNS"] = {};
      artifactKind["DNS"].url = "/carpe/eventlogs_dns.do";
      artifactKind["DNS"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'query_name', dataField: 'query_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}        
      ];
      
      // lv1_os_win_event_logs_file_handling
      artifactKind["File Handling"] = {};
      artifactKind["File Handling"].url = "/carpe/eventlogs_file_handle.do";
      artifactKind["File Handling"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}        
      ];
      
      // lv1_os_win_event_logs_logonoff
      artifactKind["Log On/Off"] = {};
      artifactKind["Log On/Off"].url = "/carpe/eventlogs_log_onoff.do";
      artifactKind["Log On/Off"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}        
      ];
      
      // lv1_os_win_event_logs_ms_alerts
      artifactKind["MS Alerts"] = {};
      artifactKind["MS Alerts"].url = "/carpe/eventlogs_ms_alerts.do";
      artifactKind["MS Alerts"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'message', dataField: 'message', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'error_type', dataField: 'error_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_version', dataField: 'program_version', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}        
      ];
      
      // lv1_os_win_event_logs_msi_installer
      artifactKind["MSI Installer"] = {};
      artifactKind["MSI Installer"].url = "/carpe/eventlogs_msi.do";
      artifactKind["MSI Installer"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'product_name', dataField: 'product_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'product_version', dataField: 'product_version', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'manufacturer', dataField: 'manufacturer', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_event_logs_network
      artifactKind["Network"] = {};
      artifactKind["Network"].url = "/carpe/eventlogs_network.do";
      artifactKind["Network"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'network_name', dataField: 'network_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'category', dataField: 'category', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}        
      ];
      
      // lv1_os_win_event_logs_others
      artifactKind["Others"] = {};
      artifactKind["Others"].url = "/carpe/eventlogs_others.do";
      artifactKind["Others"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_pconoff
      artifactKind["PC On/Off"] = {};
      artifactKind["PC On/Off"].url = "/carpe/eventlogs_pc_onoff.do";
      artifactKind["PC On/Off"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_printer
      artifactKind["Printer"] = {};
      artifactKind["Printer"].url = "/carpe/eventlogs_printer.do";
      artifactKind["Printer"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'location', dataField: 'location', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'size', dataField: 'size', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'pages', dataField: 'pages', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_process
      artifactKind["Process"] = {};
      artifactKind["Process"].url = "/carpe/eventlogs_process.do";
      artifactKind["Process"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'process_name', dataField: 'process_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_registry_handling
      artifactKind["Registry Handling"] = {};
      artifactKind["Registry Handling"].url = "/carpe/eventlogs_reg_handle.do";
      artifactKind["Registry Handling"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'registry_path', dataField: 'registry_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'registry_value_name', dataField: 'registry_value_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'old_value', dataField: 'old_value', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'new_value', dataField: 'new_value', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_remoteonoff
      artifactKind["Remote On/Off"] = {};
      artifactKind["Remote On/Off"].url = "/carpe/eventlogs_remote_onoff.do";
      artifactKind["Remote On/Off"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'connection', dataField: 'connection', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'address', dataField: 'address', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_screen_saver
      artifactKind["Screen Saver"] = {};
      artifactKind["Screen Saver"].url = "/carpe/eventlogs_screen_saver.do";
      artifactKind["Screen Saver"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_shared_folder
      artifactKind["Shared Folder"] = {};
      artifactKind["Shared Folder"].url = "/carpe/eventlogs_shared.do";
      artifactKind["Shared Folder"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_sleeponoff
      artifactKind["Sleep On/Off"] = {};
      artifactKind["Sleep On/Off"].url = "/carpe/eventlogs_sleep.do";
      artifactKind["Sleep On/Off"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time_sleep', dataField: 'time_sleep', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time_wake', dataField: 'time_wake', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_telemetry
      artifactKind["Telemetry"] = {};
      artifactKind["Telemetry"].url = "/carpe/eventlogs_telemetry.do";
      artifactKind["Telemetry"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_path', dataField: 'program_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_time_changed
      artifactKind["Time Changed"] = {};
      artifactKind["Time Changed"].url = "/carpe/eventlogs_time_changed.do";
      artifactKind["Time Changed"].columnSet = [
        {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time_old', dataField: 'time_old', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time_new', dataField: 'time_new', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
      ];
      
      // lv1_os_win_event_logs_usb_devices
      artifactKind["USB Devices"] = {};
      artifactKind["USB Devices"].url = "/carpe/eventlogs_usb.do";
      artifactKind["USB Devices"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'task', dataField: 'task', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'time', dataField: 'time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'device_instance_id', dataField: 'device_instance_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'manufacturer', dataField: 'manufacturer', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'model', dataField: 'model', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'revision', dataField: 'revision', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'serial_number', dataField: 'serial_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'parentid', dataField: 'parentid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user', dataField: 'user', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_sid', dataField: 'user_sid', width: '40%', cellsalign: 'left', align: 'center'}        
        ,{text: 'event_id', dataField: 'event_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_id_description', dataField: 'event_id_description', width: '10%', cellsalign: 'left', align: 'center'}                
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
      artifactKind["Amcache File"] = {};
      artifactKind["Amcache File"].url = "/carpe/reg_amcache_file_entries.do";
      artifactKind["Amcache File"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'key_last_updated_time', dataField: 'key_last_updated_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_extension', dataField: 'file_extension', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_id', dataField: 'program_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'key_id', dataField: 'key_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'related_programname', dataField: 'related_programname', width: '10%', cellsalign: 'left', align: 'center'}
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
        ,{text: 'publisher', dataField: 'publisher', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      //lv1_os_win_reg_amcache_program_entries
      artifactKind["Amcache Program"] = {};
      artifactKind["Amcache Program"].url = "/carpe/reg_amcache_program_entries.do";
      artifactKind["Amcache Program"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'key_last_updated_time', dataField: 'key_last_updated_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'installed_time', dataField: 'installed_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'version', dataField: 'version', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'publisher', dataField: 'publisher', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'uninstall_time', dataField: 'uninstall_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'os_version_at_install_time', dataField: 'os_version_at_install_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'bundle_manifest_path', dataField: 'bundle_manifest_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'hide_in_control_panel_flag', dataField: 'hide_in_control_panel_flag', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'language_code', dataField: 'language_code', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'manifest_path', dataField: 'manifest_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'msi_package_code', dataField: 'msi_package_code', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'msi_product_code', dataField: 'msi_product_code', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'package_full_name', dataField: 'package_full_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_id', dataField: 'program_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_instance_id', dataField: 'program_instance_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'uninstall_registry_key_path', dataField: 'uninstall_registry_key_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'root_dir_path', dataField: 'root_dir_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_source', dataField: 'program_source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'store_app_type', dataField: 'store_app_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'uninstall_string', dataField: 'uninstall_string', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'inboxmodernapp', dataField: 'inboxmodernapp', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      
      //lv1_os_win_reg_installed_programs
      artifactKind["Installed Programs"] = {};
      artifactKind["Installed Programs"].url = "/carpe/reg_installed_programs.do";
      artifactKind["Installed Programs"].columnSet = [
    	  {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'company', dataField: 'company', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'created_date', dataField: 'created_date', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'key_last_updated_time', dataField: 'key_last_updated_time', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'install_size', dataField: 'install_size', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'version', dataField: 'version', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'potential_location', dataField: 'potential_location', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'useraccount', dataField: 'useraccount', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'backup_flag', dataField: 'backup_flag', width: '10%', cellsalign: 'left', align: 'center'},
    	  {text: 'source_location', dataField: 'source_location', width: '10%', cellsalign: 'left', align: 'center'},
    	  ];
      
   // lv1_os_win_reg_shellbag
      artifactKind["Shellbag"] = {};
      artifactKind["Shellbag"].url = "/carpe/win_reg_shellbag.do";
      artifactKind["Shellbag"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'user_name', dataField: 'user_name', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'bag_path', dataField: 'bag_path', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'shell_type', dataField: 'shell_type', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'modification_time', dataField: 'modification_time', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'access_time', dataField: 'access_time', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'creation_time', dataField: 'creation_time', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'last_written_time', dataField: 'last_written_time', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'size', dataField: 'size', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'mft_entry_number', dataField: 'mft_entry_number', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'mft_sequence', dataField: 'mft_sequence', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'filesystem', dataField: 'filesystem', width: '10%', cellsalign: 'left', align: 'center'},
      ];
      
      //lv1_os_win_reg_os_info
      artifactKind["OS Info"] = {};
      artifactKind["OS Info"].url = "/carpe/reg_os_info.do";
      artifactKind["OS Info"].columnSet = [
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
        ,{text: 'release_id', dataField: 'release_id', width: '10%', cellsalign: 'left', align: 'center'}
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
      artifactKind["USB Devices"] = {};
      artifactKind["USB Devices"].url = "/carpe/reg_usb_devices.do";
      artifactKind["USB Devices"].columnSet = [
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
      artifactKind["User Accounts"] = {};
      artifactKind["User Accounts"].url = "/carpe/reg_user_accounts.do";
      artifactKind["User Accounts"].columnSet = [
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
        ,{text: 'account_created_time', dataField: 'account_created_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'login_count', dataField: 'login_count', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'account_disabled', dataField: 'account_disabled', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'password_required', dataField: 'password_required', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'password_hint', dataField: 'password_hint', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'lm_hash', dataField: 'lm_hash', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'ntlm_hash', dataField: 'ntlm_hash', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_userassist
      artifactKind["UserAssist"] = {};
      artifactKind["UserAssist"].url = "/carpe/reg_userassist.do";
      artifactKind["UserAssist"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'userassist_entry_number', dataField: 'userassist_entry_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_run_count', dataField: 'program_run_count', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'last_run_time', dataField: 'last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'focus_count', dataField: 'focus_count', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'focus_seconds', dataField: 'focus_seconds', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_file_connection
      artifactKind["File Connection"] = {};
      artifactKind["File Connection"].url = "/carpe/reg_file_connection.do";
      artifactKind["File Connection"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_path', dataField: 'file_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'command', dataField: 'command', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_type', dataField: 'file_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_known_dll
      artifactKind["Known Dll"] = {};
      artifactKind["Known Dll"].url = "/carpe/reg_known_dll.do";
      artifactKind["Known Dll"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dll_directory', dataField: 'dll_directory', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dll_directory_32', dataField: 'dll_directory_32', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_mac_address
      artifactKind["Mac Address"] = {};
      artifactKind["Mac Address"].url = "/carpe/reg_mac_address.do";
      artifactKind["Mac Address"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'mac_address', dataField: 'mac_address', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_mru_folder
      artifactKind["MRU Folder"] = {};
      artifactKind["MRU Folder"].url = "/carpe/reg_mru_folder.do";
      artifactKind["MRU Folder"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'accessed_folder', dataField: 'accessed_folder', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'registry_order', dataField: 'registry_order', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
   // lv1_os_win_reg_mru_file
      artifactKind["MRU File"] = {};
      artifactKind["MRU File"].url = "/carpe/win_reg_mru_file.do";
      artifactKind["MRU File"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_path', dataField: 'file_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'extension', dataField: 'extension', width: '10%', cellsalign: 'left', align: 'center'},{text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'useraccount', dataField: 'useraccount', width: '10%', cellsalign: 'left', align: 'center'},{text: 'backup_flag', dataField: 'backup_flag', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source_location', dataField: 'source_location', width: '10%', cellsalign: 'left', align: 'center'}
      ];

   
      // lv1_os_win_reg_mui_cache
      artifactKind["Mui Cache"] = {};
      artifactKind["Mui Cache"].url = "/carpe/reg_mui_cache.do";
      artifactKind["Mui Cache"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_path', dataField: 'file_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'data', dataField: 'data', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_network_drive
      artifactKind["Network Drive"] = {};
      artifactKind["Network Drive"].url = "/carpe/reg_network_drive.do";
      artifactKind["Network Drive"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'network_drive_name', dataField: 'network_drive_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'ordering', dataField: 'ordering', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_network_interface
      artifactKind["Network Interface"] = {};
      artifactKind["Network Interface"].url = "/carpe/reg_network_interface.do";
      artifactKind["Network Interface"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'enable_dhcp', dataField: 'enable_dhcp', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'ipaddress', dataField: 'ipaddress', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_ipaddress', dataField: 'dhcp_ipaddress', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_subnetmask', dataField: 'dhcp_subnetmask', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_server', dataField: 'dhcp_server', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_connforcebroadcastflag', dataField: 'dhcp_connforcebroadcastflag', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_domain', dataField: 'dhcp_domain', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_name_server', dataField: 'dhcp_name_server', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_default_gateway', dataField: 'dhcp_default_gateway', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_subnetmaskopt', dataField: 'dhcp_subnetmaskopt', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_interfaceoptions', dataField: 'dhcp_interfaceoptions', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_gatewayhardware', dataField: 'dhcp_gatewayhardware', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dhcp_gatewayhardwarecount', dataField: 'dhcp_gatewayhardwarecount', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'lease', dataField: 'lease', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'lease_obtained_time', dataField: 'lease_obtained_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'lease_terminate_time', dataField: 'lease_terminate_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 't1', dataField: 't1', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 't2', dataField: 't2', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'address_type', dataField: 'address_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'isservernapaware', dataField: 'isservernapaware', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'registeradaptername', dataField: 'registeradaptername', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'registrationenabled', dataField: 'registrationenabled', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_network_profile
      artifactKind["Network Profile"] = {};
      artifactKind["Network Profile"].url = "/carpe/reg_network_profile.do";
      artifactKind["Network Profile"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'profile_name', dataField: 'profile_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'profile_guid', dataField: 'profile_guid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'datecreated', dataField: 'datecreated', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'datelstconnected', dataField: 'datelstconnected', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dns', dataField: 'dns', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'default_gateway_mac', dataField: 'default_gateway_mac', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_recent_docs
      artifactKind["Recent Docs"] = {};
      artifactKind["Recent Docs"].url = "/carpe/reg_recent_docs.do";
      artifactKind["Recent Docs"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_folder_name', dataField: 'file_folder_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_folder_link', dataField: 'file_folder_link', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'registry_order', dataField: 'registry_order', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_run_command
      artifactKind["Run Command"] = {};
      artifactKind["Run Command"].url = "/carpe/reg_run_command.do";
      artifactKind["Run Command"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'command', dataField: 'command', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'ordering', dataField: 'ordering', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_search_keyword
      artifactKind["Search Keyword"] = {};
      artifactKind["Search Keyword"].url = "/carpe/reg_search_keyword.do";
      artifactKind["Search Keyword"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'keyword', dataField: 'keyword', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'ordering', dataField: 'ordering', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_shim_cache
      artifactKind["Shim Cache"] = {};
      artifactKind["Shim Cache"].url = "/carpe/reg_shim_cache.do";
      artifactKind["Shim Cache"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_path', dataField: 'file_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_start_list
      artifactKind["Start List"] = {};
      artifactKind["Start List"].url = "/carpe/reg_start_list.do";
      artifactKind["Start List"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_os_win_reg_system_service
      artifactKind["System Service"] = {};
      artifactKind["System Service"].url = "/carpe/reg_system_service.do";
      artifactKind["System Service"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'service_name', dataField: 'service_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'service_type', dataField: 'service_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'start_type', dataField: 'start_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'service_location', dataField: 'service_location', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'groups', dataField: 'groups', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'display_name', dataField: 'display_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'dependancy', dataField: 'dependancy', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'user_account', dataField: 'user_account', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'service_detail_information', dataField: 'service_detail_information', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'host_flag', dataField: 'host_flag', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'host_service', dataField: 'host_service', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'hosted_service_parameter', dataField: 'hosted_service_parameter', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'modified_time', dataField: 'modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'error_control', dataField: 'error_control', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'tag', dataField: 'tag', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_app_web_chrome_visit_urls
      artifactKind["Visit Urls"] = {};
      artifactKind["Visit Urls"].url = "/carpe/chrome_visit_urls.do";
      artifactKind["Visit Urls"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'url', dataField: 'url', width: '50%', cellsalign: 'left', align: 'center'}
        ,{text: 'last_visited_time', dataField: 'last_visited_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'visit_count', dataField: 'visit_count', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'typed_count', dataField: 'typed_count', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_win_lnk_file
      artifactKind["LNK File"] = {};
      artifactKind["LNK File"].url = "/carpe/lnk_file.do";
      artifactKind["LNK File"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_path', dataField: 'target_file_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_relative_path', dataField: 'target_file_relative_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_working_dir_path', dataField: 'target_file_working_dir_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_absolute_path', dataField: 'target_file_absolute_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_env_location', dataField: 'target_file_env_location', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_icon_location', dataField: 'target_file_icon_location', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_size', dataField: 'target_file_size', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_created_time', dataField: 'target_file_created_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_last_modified_time', dataField: 'target_file_last_modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_last_accessed_time', dataField: 'target_file_last_accessed_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_file_attributes', dataField: 'target_file_attributes', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'directory_flag', dataField: 'directory_flag', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'drive_type', dataField: 'drive_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'volume_serial_number', dataField: 'volume_serial_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'volume_name', dataField: 'volume_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'net_bios_name', dataField: 'net_bios_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'mac_address', dataField: 'mac_address', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'arguments', dataField: 'arguments', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_mft_entry_number', dataField: 'target_mft_entry_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'target_mft_sequence_number', dataField: 'target_mft_sequence_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'computer_name', dataField: 'computer_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'mac_vendor', dataField: 'mac_vendor', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_birth_droid', dataField: 'file_birth_droid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'volume_birth_droid', dataField: 'volume_birth_droid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_droid', dataField: 'file_droid', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'volume_droid', dataField: 'volume_droid', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      /*
      // lv1_os_win_prefetch
      artifactKind["Prefetch"] = {};
      artifactKind["Prefetch"].url = "/carpe/prefetch.do";
      artifactKind["Prefetch"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_path', dataField: 'program_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'program_run_count', dataField: 'program_run_count', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_created_time', dataField: 'file_created_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'last_run_time', dataField: 'last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_hash', dataField: 'file_hash', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: '2nd_last_run_time', dataField: '2nd_last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: '3rd_last_run_time', dataField: '3rd_last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: '4th_last_run_time', dataField: '4th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: '5th_last_run_time', dataField: '5th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: '6th_last_run_time', dataField: '6th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: '7th_last_run_time', dataField: '7th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: '8th_last_run_time', dataField: '8th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'volume_name', dataField: 'volume_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'volume_created_time', dataField: 'volume_created_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'volume_2_name', dataField: 'volume_2_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'volume_2_created_time', dataField: 'volume_2_created_time', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      */
      /*
      // lv1_app_web_chrome_download
      artifactKind["Download"] = {};
      artifactKind["Download"].url = "/carpe/chrome_download.do";
      artifactKind["Download"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'download_source', dataField: 'download_source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'saved_to', dataField: 'saved_to', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'state', dataField: 'state', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'opened_by_user_flag', dataField: 'opened_by_user_flag', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'start_time', dataField: 'start_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'end_time', dataField: 'end_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'download_bytes', dataField: 'download_bytes', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_size_bytes', dataField: 'file_size_bytes', width: '10%', cellsalign: 'left', align: 'center'}
      ];      
      
      // lv1_app_web_chrome_cookies
      artifactKind["Cookies"] = {};
      artifactKind["Cookies"].url = "/carpe/chrome_cookies.do";
      artifactKind["Cookies"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'host_domain', dataField: 'host_domain', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'secure_flag', dataField: 'secure_flag', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'http_only_flag', dataField: 'http_only_flag', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'created_time', dataField: 'created_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'expiration_time', dataField: 'expiration_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'accessed_time', dataField: 'accessed_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'cookie_path', dataField: 'cookie_path', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_app_web_chrome_cache
      artifactKind["Cache"] = {};
      artifactKind["Cache"].url = "/carpe/chrome_cache.do";
      artifactKind["Cache"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'cache_name', dataField: 'cache_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_type', dataField: 'file_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'cache_url', dataField: 'cache_url', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'last_visited_time', dataField: 'last_visited_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'first_visited_time', dataField: 'first_visited_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'last_sync_time', dataField: 'last_sync_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'server_name', dataField: 'server_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'server_response', dataField: 'server_response', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'server_ip_address', dataField: 'server_ip_address', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'content_encoding', dataField: 'content_encoding', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'cache_control', dataField: 'cache_control', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'etag', dataField: 'etag', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'content_size', dataField: 'content_size', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_app_web_chrome_search_terms
      artifactKind["Search Terms"] = {};
      artifactKind["Search Terms"].url = "/carpe/chrome_search_terms.do";
      artifactKind["Search Terms"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'search_term', dataField: 'search_term', width: '50%', cellsalign: 'left', align: 'center'}
        ,{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'search_url_type', dataField: 'search_url_type', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'searched_time', dataField: 'searched_time', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      */
   // lv1_app_web_chrome_autofill
      artifactKind["Chrome Autofill"] = {};
      artifactKind["Chrome Autofill"].url = "/carpe/web_chrome_autofill.do";
      artifactKind["Chrome Autofill"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'value_lower', dataField: 'value_lower', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_created', dataField: 'date_created', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_last_used', dataField: 'date_last_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'count', dataField: 'count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chrome_bookmarks
      artifactKind["Chrome Bookmarks"] = {};
      artifactKind["Chrome Bookmarks"].url = "/carpe/web_chrome_bookmarks.do";
      artifactKind["Chrome Bookmarks"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_added', dataField: 'date_added', width: '10%', cellsalign: 'left', align: 'center'},{text: 'guid', dataField: 'guid', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_visited_desktop', dataField: 'last_visited_desktop', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chrome_cookies
      artifactKind["Chrome Cookies"] = {};
      artifactKind["Chrome Cookies"].url = "/carpe/web_chrome_cookies.do";
      artifactKind["Chrome Cookies"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'creation_utc', dataField: 'creation_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'host_key', dataField: 'host_key', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'expires_utc', dataField: 'expires_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_secure', dataField: 'is_secure', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_httponly', dataField: 'is_httponly', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_access_utc', dataField: 'last_access_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'has_expires', dataField: 'has_expires', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_persistent', dataField: 'is_persistent', width: '10%', cellsalign: 'left', align: 'center'},{text: 'priority', dataField: 'priority', width: '10%', cellsalign: 'left', align: 'center'},{text: 'encrypted_value', dataField: 'encrypted_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'samesite', dataField: 'samesite', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chrome_download
      artifactKind["Chrome Download"] = {};
      artifactKind["Chrome Download"].url = "/carpe/web_chrome_download.do";
      artifactKind["Chrome Download"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'download_source', dataField: 'download_source', width: '10%', cellsalign: 'left', align: 'center'},{text: 'saved_to', dataField: 'saved_to', width: '10%', cellsalign: 'left', align: 'center'},{text: 'state', dataField: 'state', width: '10%', cellsalign: 'left', align: 'center'},{text: 'interrupt_reason', dataField: 'interrupt_reason', width: '10%', cellsalign: 'left', align: 'center'},{text: 'opened_by_user_flag', dataField: 'opened_by_user_flag', width: '10%', cellsalign: 'left', align: 'center'},{text: 'start_time', dataField: 'start_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'end_time', dataField: 'end_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'download_bytes', dataField: 'download_bytes', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_size_bytes', dataField: 'file_size_bytes', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chrome_favicons
      artifactKind["Chrome Favicons"] = {};
      artifactKind["Chrome Favicons"].url = "/carpe/web_chrome_favicons.do";
      artifactKind["Chrome Favicons"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_id', dataField: 'icon_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_url', dataField: 'icon_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_updated', dataField: 'last_updated', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_requested', dataField: 'last_requested', width: '10%', cellsalign: 'left', align: 'center'},{text: 'image_data', dataField: 'image_data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'width', dataField: 'width', width: '10%', cellsalign: 'left', align: 'center'},{text: 'height', dataField: 'height', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chrome_logindata
      artifactKind["Chrome Login Data"] = {};
      artifactKind["Chrome Login Data"].url = "/carpe/web_chrome_logindata.do";
      artifactKind["Chrome Login Data"].columnSet = [
   	 {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'origin_url', dataField: 'origin_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'action_url', dataField: 'action_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'username_element', dataField: 'username_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'username_value', dataField: 'username_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_element', dataField: 'password_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_value', dataField: 'password_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'signon_realm', dataField: 'signon_realm', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_created', dataField: 'date_created', width: '10%', cellsalign: 'left', align: 'center'},{text: 'form_data', dataField: 'form_data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'blacklisted_by_user', dataField: 'blacklisted_by_user', width: '10%', cellsalign: 'left', align: 'center'},{text: 'scheme', dataField: 'scheme', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_type', dataField: 'password_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'times_used', dataField: 'times_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'dated_synced', dataField: 'dated_synced', width: '10%', cellsalign: 'left', align: 'center'},{text: 'displayed_name', dataField: 'displayed_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_url', dataField: 'icon_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'federation_url', dataField: 'federation_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'skip_zero_click', dataField: 'skip_zero_click', width: '10%', cellsalign: 'left', align: 'center'},{text: 'generation_upload_status', dataField: 'generation_upload_status', width: '10%', cellsalign: 'left', align: 'center'},{text: 'possible_username_pairs', dataField: 'possible_username_pairs', width: '10%', cellsalign: 'left', align: 'center'},{text: 'submit_element', dataField: 'submit_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'preferred', dataField: 'preferred', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_last_used', dataField: 'date_last_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
    	  ];

      // lv1_app_web_chrome_search_terms
      artifactKind["Chrome Search Terms"] = {};
      artifactKind["Chrome Search Terms"].url = "/carpe/web_chrome_search_terms.do";
      artifactKind["Chrome Search Terms"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'search_term', dataField: 'search_term', width: '10%', cellsalign: 'left', align: 'center'},{text: 'searched_time', dataField: 'searched_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'search_url_type', dataField: 'search_url_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chrome_shortcuts
      artifactKind["Chrome Shortcuts"] = {};
      artifactKind["Chrome Shortcuts"].url = "/carpe/web_chrome_shortcuts.do";
      artifactKind["Chrome Shortcuts"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'text', dataField: 'text', width: '10%', cellsalign: 'left', align: 'center'},{text: 'fill_into_edit', dataField: 'fill_into_edit', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'},{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'},{text: 'keyword', dataField: 'keyword', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_access_time', dataField: 'last_access_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'number_of_hits', dataField: 'number_of_hits', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chrome_top_sites
      artifactKind["Chrome Top Sites"] = {};
      artifactKind["Chrome Top Sites"].url = "/carpe/web_chrome_top_sites.do";
      artifactKind["Chrome Top Sites"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url_rank', dataField: 'url_rank', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chrome_visit_urls
      artifactKind["Chrome Visit Urls"] = {};
      artifactKind["Chrome Visit Urls"].url = "/carpe/web_chrome_visit_urls.do";
      artifactKind["Chrome Visit Urls"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_visited_time', dataField: 'last_visited_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'},{text: 'visit_count', dataField: 'visit_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'typed_count', dataField: 'typed_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

   // lv1_app_web_chrome_domain
      artifactKind["Chrome Domain"] = {};
      artifactKind["Chrome Domain"].url = "/carpe/web_chrome_domain.do";
      artifactKind["Chrome Domain"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'domain', dataField: 'domain', width: '10%', cellsalign: 'left', align: 'center'},{text: 'expiration', dataField: 'expiration', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_modified', dataField: 'last_modified', width: '10%', cellsalign: 'left', align: 'center'},{text: 'model', dataField: 'model', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_engagement_time', dataField: 'last_engagement_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_shortcut_launch_time', dataField: 'last_shortcut_launch_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'points_added', dataField: 'points_added', width: '10%', cellsalign: 'left', align: 'center'},{text: 'raw_score', dataField: 'raw_score', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chrome_profile', dataField: 'chrome_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_autofill
      artifactKind["C_Edge Autofillc"] = {};
      artifactKind["C_Edge Autofillc"].url = "/carpe/web_chromium_edge_autofill.do";
      artifactKind["C_Edge Autofillc"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'value_lower', dataField: 'value_lower', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_created', dataField: 'date_created', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_last_used', dataField: 'date_last_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'count', dataField: 'count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_bookmarks
      artifactKind["C_Edge Bookmarks"] = {};
      artifactKind["C_Edge Bookmarks"].url = "/carpe/web_chromium_edge_bookmarks.do";
      artifactKind["C_Edge Bookmarks"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_added', dataField: 'date_added', width: '10%', cellsalign: 'left', align: 'center'},{text: 'guid', dataField: 'guid', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_visited_desktop', dataField: 'last_visited_desktop', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_cookies
      artifactKind["C_Edge Cookies"] = {};
      artifactKind["C_Edge Cookies"].url = "/carpe/web_chromium_edge_cookies.do";
      artifactKind["C_Edge Cookies"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'creation_utc', dataField: 'creation_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'host_key', dataField: 'host_key', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'expires_utc', dataField: 'expires_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_secure', dataField: 'is_secure', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_httponly', dataField: 'is_httponly', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_access_utc', dataField: 'last_access_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'has_expires', dataField: 'has_expires', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_persistent', dataField: 'is_persistent', width: '10%', cellsalign: 'left', align: 'center'},{text: 'priority', dataField: 'priority', width: '10%', cellsalign: 'left', align: 'center'},{text: 'encrypted_value', dataField: 'encrypted_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'samesite', dataField: 'samesite', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_download
      artifactKind["C_Edge Download"] = {};
      artifactKind["C_Edge Download"].url = "/carpe/web_chromium_edge_download.do";
      artifactKind["C_Edge Download"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'download_source', dataField: 'download_source', width: '10%', cellsalign: 'left', align: 'center'},{text: 'saved_to', dataField: 'saved_to', width: '10%', cellsalign: 'left', align: 'center'},{text: 'state', dataField: 'state', width: '10%', cellsalign: 'left', align: 'center'},{text: 'interrupt_reason', dataField: 'interrupt_reason', width: '10%', cellsalign: 'left', align: 'center'},{text: 'opened_by_user_flag', dataField: 'opened_by_user_flag', width: '10%', cellsalign: 'left', align: 'center'},{text: 'start_time', dataField: 'start_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'end_time', dataField: 'end_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'download_bytes', dataField: 'download_bytes', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_size_bytes', dataField: 'file_size_bytes', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_favicons
      artifactKind["C_Edge Favicons"] = {};
      artifactKind["C_Edge Favicons"].url = "/carpe/web_chromium_edge_favicons.do";
      artifactKind["C_Edge Favicons"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_id', dataField: 'icon_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_url', dataField: 'icon_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_updated', dataField: 'last_updated', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_requested', dataField: 'last_requested', width: '10%', cellsalign: 'left', align: 'center'},{text: 'image_data', dataField: 'image_data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'width', dataField: 'width', width: '10%', cellsalign: 'left', align: 'center'},{text: 'height', dataField: 'height', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_logindata
      artifactKind["C_Edge Login Data"] = {};
      artifactKind["C_Edge Login Data"].url = "/carpe/web_chromium_edge_logindata.do";
      artifactKind["C_Edge Login Data"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'origin_url', dataField: 'origin_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'action_url', dataField: 'action_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'username_element', dataField: 'username_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'username_value', dataField: 'username_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_element', dataField: 'password_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_value', dataField: 'password_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'signon_realm', dataField: 'signon_realm', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_created', dataField: 'date_created', width: '10%', cellsalign: 'left', align: 'center'},{text: 'form_data', dataField: 'form_data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'blacklisted_by_user', dataField: 'blacklisted_by_user', width: '10%', cellsalign: 'left', align: 'center'},{text: 'scheme', dataField: 'scheme', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_type', dataField: 'password_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'times_used', dataField: 'times_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'dated_synced', dataField: 'dated_synced', width: '10%', cellsalign: 'left', align: 'center'},{text: 'displayed_name', dataField: 'displayed_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_url', dataField: 'icon_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'federation_url', dataField: 'federation_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'skip_zero_click', dataField: 'skip_zero_click', width: '10%', cellsalign: 'left', align: 'center'},{text: 'generation_upload_status', dataField: 'generation_upload_status', width: '10%', cellsalign: 'left', align: 'center'},{text: 'possible_username_pairs', dataField: 'possible_username_pairs', width: '10%', cellsalign: 'left', align: 'center'},{text: 'submit_element', dataField: 'submit_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'preferred', dataField: 'preferred', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_last_used', dataField: 'date_last_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_search_terms
      artifactKind["C_Edge Search Terms"] = {};
      artifactKind["C_Edge Search Terms"].url = "/carpe/web_chromium_edge_search_terms.do";
      artifactKind["C_Edge Search Terms"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'search_term', dataField: 'search_term', width: '10%', cellsalign: 'left', align: 'center'},{text: 'searched_time', dataField: 'searched_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'search_url_type', dataField: 'search_url_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_shortcuts
      artifactKind["C_Edge Shortcuts"] = {};
      artifactKind["C_Edge Shortcuts"].url = "/carpe/web_chromium_edge_shortcuts.do";
      artifactKind["C_Edge Shortcuts"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'text', dataField: 'text', width: '10%', cellsalign: 'left', align: 'center'},{text: 'fill_into_edit', dataField: 'fill_into_edit', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'},{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'},{text: 'keyword', dataField: 'keyword', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_access_time', dataField: 'last_access_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'number_of_hits', dataField: 'number_of_hits', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_top_sites
      artifactKind["C_Edge Top Sites"] = {};
      artifactKind["C_Edge Top Sites"].url = "/carpe/web_chromium_edge_top_sites.do";
      artifactKind["C_Edge Top Sites"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url_rank', dataField: 'url_rank', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_chromium_edge_visit_urls
      artifactKind["C_Edge Visit Urls"] = {};
      artifactKind["C_Edge Visit Urls"].url = "/carpe/web_chromium_edge_visit_urls.do";
      artifactKind["C_Edge Visit Urls"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_visited_time', dataField: 'last_visited_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'},{text: 'visit_count', dataField: 'visit_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'typed_count', dataField: 'typed_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'edge_profile', dataField: 'edge_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_firefox_domain
      artifactKind["Firefox Domain"] = {};
      artifactKind["Firefox Domain"].url = "/carpe/web_firefox_domain.do";
      artifactKind["Firefox Domain"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'prefix', dataField: 'prefix', width: '10%', cellsalign: 'left', align: 'center'},{text: 'host', dataField: 'host', width: '10%', cellsalign: 'left', align: 'center'},{text: 'frecency', dataField: 'frecency', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'firefox_profile_id', dataField: 'firefox_profile_id', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_firefox_download
      artifactKind["Firefox Download"] = {};
      artifactKind["Firefox Download"].url = "/carpe/web_firefox_download.do";
      artifactKind["Firefox Download"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'download_path', dataField: 'download_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'download_file_size', dataField: 'download_file_size', width: '10%', cellsalign: 'left', align: 'center'},{text: 'state', dataField: 'state', width: '10%', cellsalign: 'left', align: 'center'},{text: 'start_time', dataField: 'start_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'end_time', dataField: 'end_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'flags', dataField: 'flags', width: '10%', cellsalign: 'left', align: 'center'},{text: 'expiration', dataField: 'expiration', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'firefox_profile_id', dataField: 'firefox_profile_id', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_firefox_visit_history
      artifactKind["Firefox Visit History"] = {};
      artifactKind["Firefox Visit History"].url = "/carpe/web_firefox_visit_history.do";
      artifactKind["Firefox Visit History"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'from_url', dataField: 'from_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'to_url', dataField: 'to_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'visit_date', dataField: 'visit_date', width: '10%', cellsalign: 'left', align: 'center'},{text: 'visit_type', dataField: 'visit_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'visit_type_description', dataField: 'visit_type_description', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'firefox_profile_id', dataField: 'firefox_profile_id', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_firefox_visit_urls
      artifactKind["Firefox Visit Urls"] = {};
      artifactKind["Firefox Visit Urls"].url = "/carpe/web_firefox_visit_urls.do";
      artifactKind["Firefox Visit Urls"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'},{text: 'rev_host', dataField: 'rev_host', width: '10%', cellsalign: 'left', align: 'center'},{text: 'visit_count', dataField: 'visit_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'hidden', dataField: 'hidden', width: '10%', cellsalign: 'left', align: 'center'},{text: 'typed', dataField: 'typed', width: '10%', cellsalign: 'left', align: 'center'},{text: 'frecency', dataField: 'frecency', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_visit_date', dataField: 'last_visit_date', width: '10%', cellsalign: 'left', align: 'center'},{text: 'guid', dataField: 'guid', width: '10%', cellsalign: 'left', align: 'center'},{text: 'foreign_count', dataField: 'foreign_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'},{text: 'preview_image_url', dataField: 'preview_image_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'firefox_profile_id', dataField: 'firefox_profile_id', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_autofill
      artifactKind["Whale Autofill"] = {};
      artifactKind["Whale Autofill"].url = "/carpe/web_whale_autofill.do";
      artifactKind["Whale Autofill"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_crated', dataField: 'date_crated', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_last_used', dataField: 'date_last_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'count', dataField: 'count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_bookmarks
      artifactKind["Whale Bookmarks"] = {};
      artifactKind["Whale Bookmarks"].url = "/carpe/web_whale_bookmarks.do";
      artifactKind["Whale Bookmarks"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_added', dataField: 'date_added', width: '10%', cellsalign: 'left', align: 'center'},{text: 'guid', dataField: 'guid', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_visited_desktop', dataField: 'last_visited_desktop', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_cookies
      artifactKind["Whale Cookies"] = {};
      artifactKind["Whale Cookies"].url = "/carpe/web_whale_cookies.do";
      artifactKind["Whale Cookies"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'host_key', dataField: 'host_key', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'value', dataField: 'value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'encrypted_value', dataField: 'encrypted_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'creation_utc', dataField: 'creation_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'expires_utc', dataField: 'expires_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_access_utc', dataField: 'last_access_utc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_download
      artifactKind["Whale Download"] = {};
      artifactKind["Whale Download"].url = "/carpe/web_whale_download.do";
      artifactKind["Whale Download"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'guid', dataField: 'guid', width: '10%', cellsalign: 'left', align: 'center'},{text: 'current_path', dataField: 'current_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'target_path', dataField: 'target_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'start_time', dataField: 'start_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'end_time', dataField: 'end_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'received_bytes', dataField: 'received_bytes', width: '10%', cellsalign: 'left', align: 'center'},{text: 'total_bytes', dataField: 'total_bytes', width: '10%', cellsalign: 'left', align: 'center'},{text: 'state', dataField: 'state', width: '10%', cellsalign: 'left', align: 'center'},{text: 'opened', dataField: 'opened', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_access_time', dataField: 'last_access_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'referrer', dataField: 'referrer', width: '10%', cellsalign: 'left', align: 'center'},{text: 'tab_url', dataField: 'tab_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'tab_referrer_url', dataField: 'tab_referrer_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_favicons
      artifactKind["Whale Favicons"] = {};
      artifactKind["Whale Favicons"].url = "/carpe/web_whale_favicons.do";
      artifactKind["Whale Favicons"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_id', dataField: 'icon_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_url', dataField: 'icon_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_updated', dataField: 'last_updated', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_requested', dataField: 'last_requested', width: '10%', cellsalign: 'left', align: 'center'},{text: 'image_data', dataField: 'image_data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'width', dataField: 'width', width: '10%', cellsalign: 'left', align: 'center'},{text: 'height', dataField: 'height', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_logindata
      artifactKind["Whale Login Data"] = {};
      artifactKind["Whale Login Data"].url = "/carpe/web_whale_logindata.do";
      artifactKind["Whale Login Data"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'origin_url', dataField: 'origin_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'action_url', dataField: 'action_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'username_element', dataField: 'username_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'username_value', dataField: 'username_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_element', dataField: 'password_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_value', dataField: 'password_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'signon_realm', dataField: 'signon_realm', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_created', dataField: 'date_created', width: '10%', cellsalign: 'left', align: 'center'},{text: 'form_data', dataField: 'form_data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'blacklisted_by_user', dataField: 'blacklisted_by_user', width: '10%', cellsalign: 'left', align: 'center'},{text: 'scheme', dataField: 'scheme', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password_type', dataField: 'password_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'times_used', dataField: 'times_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'dated_synced', dataField: 'dated_synced', width: '10%', cellsalign: 'left', align: 'center'},{text: 'displayed_name', dataField: 'displayed_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icon_url', dataField: 'icon_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'federation_url', dataField: 'federation_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'skip_zero_click', dataField: 'skip_zero_click', width: '10%', cellsalign: 'left', align: 'center'},{text: 'generation_upload_status', dataField: 'generation_upload_status', width: '10%', cellsalign: 'left', align: 'center'},{text: 'possible_username_pairs', dataField: 'possible_username_pairs', width: '10%', cellsalign: 'left', align: 'center'},{text: 'submit_element', dataField: 'submit_element', width: '10%', cellsalign: 'left', align: 'center'},{text: 'preferred', dataField: 'preferred', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_last_used', dataField: 'date_last_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_search_terms
      artifactKind["Whale Search Terms"] = {};
      artifactKind["Whale Search Terms"].url = "/carpe/web_whale_search_terms.do";
      artifactKind["Whale Search Terms"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url_id', dataField: 'url_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'term', dataField: 'term', width: '10%', cellsalign: 'left', align: 'center'},{text: 'normalized_term', dataField: 'normalized_term', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_visit_time', dataField: 'last_visit_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_shortcuts
      artifactKind["Whale Shortcuts"] = {};
      artifactKind["Whale Shortcuts"].url = "/carpe/web_whale_shortcuts.do";
      artifactKind["Whale Shortcuts"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'text', dataField: 'text', width: '10%', cellsalign: 'left', align: 'center'},{text: 'fill_into_edit', dataField: 'fill_into_edit', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'},{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'},{text: 'keyword', dataField: 'keyword', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_access_time', dataField: 'last_access_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'number_of_hits', dataField: 'number_of_hits', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_top_sites
      artifactKind["Whale Top Sites"] = {};
      artifactKind["Whale Top Sites"].url = "/carpe/web_whale_top_sites.do";
      artifactKind["Whale Top Sites"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url_rank', dataField: 'url_rank', width: '10%', cellsalign: 'left', align: 'center'},{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_web_whale_visit_urls
      artifactKind["Whale Visit Urls"] = {};
      artifactKind["Whale Visit Urls"].url = "/carpe/web_whale_visit_urls.do";
      artifactKind["Whale Visit Urls"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'title', dataField: 'title', width: '10%', cellsalign: 'left', align: 'center'},{text: 'visit_count', dataField: 'visit_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'typed_count', dataField: 'typed_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_visit_time', dataField: 'last_visit_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'os_account', dataField: 'os_account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'whale_profile', dataField: 'whale_profile', width: '10%', cellsalign: 'left', align: 'center'}
      ];


      /*
      // lv1_fs_ntfs_logfile
      artifactKind["NTFS $LogFile"] = {};
      artifactKind["NTFS $LogFile"].url = "/carpe/ntfs_logfile.do";
      artifactKind["NTFS $LogFile"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_operation', dataField: 'file_operation', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'event_time', dataField: 'event_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'mft_record_number', dataField: 'mft_record_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'mft_reference_number', dataField: 'mft_reference_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'update_sequence_number', dataField: 'update_sequence_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'starting_lsn', dataField: 'starting_lsn', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'original_short_file_name', dataField: 'original_short_file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'original_file_name', dataField: 'original_file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'original_mft_modified_time', dataField: 'original_mft_modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'original_created_time', dataField: 'original_created_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'original_modified_time', dataField: 'original_modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'original_accessed_time', dataField: 'original_accessed_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'original_parent_mft_record_number', dataField: 'original_parent_mft_record_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'original_parent_mft_reference_number', dataField: 'original_parent_mft_reference_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'current_short_file_name', dataField: 'current_short_file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'current_file_name', dataField: 'current_file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'current_mft_modified_time', dataField: 'current_mft_modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'current_created_time', dataField: 'current_created_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'current_modified_time', dataField: 'current_modified_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'current_accessed_time', dataField: 'current_accessed_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'current_parent_mft_record_number', dataField: 'current_parent_mft_record_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'current_parent_mft_reference_number', dataField: 'current_parent_mft_reference_number', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
      // lv1_fs_ntfs_usnjrnl
      artifactKind["NTFS USN Journal"] = {};
      artifactKind["NTFS USN Journal"].url = "/carpe/ntfs_usnjrnl.do";
      artifactKind["NTFS USN Journal"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'usn_value', dataField: 'usn_value', width: '50%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'reason', dataField: 'reason', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'mft_reference_number', dataField: 'mft_reference_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'parent_mft_reference_number', dataField: 'parent_mft_reference_number', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'file_path_from_mft', dataField: 'file_path_from_mft', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      */
      // lv2_os_app_history
      artifactKind["Application History"] = {};
      artifactKind["Application History"].url = "/carpe/app_history.do";
      artifactKind["Application History"].columnSet = [
         {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'process_name', dataField: 'process_name', width: '50%', cellsalign: 'left', align: 'center'}
        ,{text: 'execution_time', dataField: 'execution_time', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'process_path', dataField: 'process_path', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'reference_file', dataField: 'reference_file', width: '10%', cellsalign: 'left', align: 'center'}
        ,{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
      ]
      
   // lv1_os_win_notification
      artifactKind["Notification"] = {};
      artifactKind["Notification"].url = "/carpe/win_notification.do";
      artifactKind["Notification"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_win_prefetch
      artifactKind["Prefetch"] = {};
      artifactKind["Prefetch"].url = "/carpe/win_prefetch.do";
      artifactKind["Prefetch"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'prefetch_name', dataField: 'prefetch_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'program_name', dataField: 'program_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'program_path', dataField: 'program_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'program_run_count', dataField: 'program_run_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_created_time', dataField: 'file_created_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_hash', dataField: 'file_hash', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_run_time', dataField: 'last_run_time', width: '10%', cellsalign: 'left', align: 'center'},{text: '2nd_last_run_time', dataField: '2nd_last_run_time', width: '10%', cellsalign: 'left', align: 'center'},{text: '3rd_last_run_time', dataField: '3rd_last_run_time', width: '10%', cellsalign: 'left', align: 'center'},{text: '4th_last_run_time', dataField: '4th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'},{text: '5th_last_run_time', dataField: '5th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'},{text: '6th_last_run_time', dataField: '6th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'},{text: '7th_last_run_time', dataField: '7th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'},{text: '8th_last_run_time', dataField: '8th_last_run_time', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_win_prefetch_run_info
      artifactKind["Prefetch Run Info"] = {};
      artifactKind["Prefetch Run Info"].url = "/carpe/win_prefetch_run_info.do";
      artifactKind["Prefetch Run Info"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'prefetch_name', dataField: 'prefetch_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_ext', dataField: 'file_ext', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'logical_path', dataField: 'logical_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'device_path', dataField: 'device_path', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_win_prefetch_volume_info
      artifactKind["Prefetch Volume Info"] = {};
      artifactKind["Prefetch Volume Info"].url = "/carpe/win_prefetch_volume_info.do";
      artifactKind["Prefetch Volume Info"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'prefetch_name', dataField: 'prefetch_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'device_path', dataField: 'device_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'creation_time', dataField: 'creation_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'serial_number', dataField: 'serial_number', width: '10%', cellsalign: 'left', align: 'center'},{text: 'directories', dataField: 'directories', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_win_recyclebin
      artifactKind["Recycle Bin"] = {};
      artifactKind["Recycle Bin"].url = "/carpe/win_recyclebin.do";
      artifactKind["Recycle Bin"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'size', dataField: 'size', width: '10%', cellsalign: 'left', align: 'center'},{text: 'deleted_time', dataField: 'deleted_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'i_file_name', dataField: 'i_file_name', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_win_sticky_note
      artifactKind["Sticky Note"] = {};
      artifactKind["Sticky Note"].url = "/carpe/win_sticky_note.do";
      artifactKind["Sticky Note"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'note_id', dataField: 'note_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'content', dataField: 'content', width: '10%', cellsalign: 'left', align: 'center'},{text: 'activated', dataField: 'activated', width: '10%', cellsalign: 'left', align: 'center'},{text: 'createdtime', dataField: 'createdtime', width: '10%', cellsalign: 'left', align: 'center'},{text: 'modifiedtime', dataField: 'modifiedtime', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_win_windows_timeline
      artifactKind["Windows Timeline"] = {};
      artifactKind["Windows Timeline"].url = "/carpe/win_windows_timeline.do";
      artifactKind["Windows Timeline"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'program_name​', dataField: 'program_name​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'display_name​', dataField: 'display_name​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'content​', dataField: 'content​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'activity_type​', dataField: 'activity_type​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'focus_seconds​', dataField: 'focus_seconds​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'start_time​', dataField: 'start_time​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'end_time​', dataField: 'end_time​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'activity_id', dataField: 'activity_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'platform​', dataField: 'platform​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'created_time​', dataField: 'created_time​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'created_in_cloud_time​', dataField: 'created_in_cloud_time​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_modified_time​', dataField: 'last_modified_time​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_modified_on_client_time​', dataField: 'last_modified_on_client_time​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'original_last_modified_on_client_time​', dataField: 'original_last_modified_on_client_time​', width: '10%', cellsalign: 'left', align: 'center'},{text: 'local_only_flag​', dataField: 'local_only_flag​', width: '10%', cellsalign: 'left', align: 'center'}
      ];

   // lv1_os_win_icon_cache
      artifactKind["Icon Cache"] = {};
      artifactKind["Icon Cache"].url = "/carpe/win_icon_cache.do";
      artifactKind["Icon Cache"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'owner', dataField: 'owner', width: '10%', cellsalign: 'left', align: 'center'},{text: 'filename', dataField: 'filename', width: '10%', cellsalign: 'left', align: 'center'},{text: 'filesize', dataField: 'filesize', width: '10%', cellsalign: 'left', align: 'center'},{text: 'imagetype', dataField: 'imagetype', width: '10%', cellsalign: 'left', align: 'center'},{text: 'data', dataField: 'data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'sha1', dataField: 'sha1', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_win_jumplist_automatics
      artifactKind["Jumplist Automatics"] = {};
      artifactKind["Jumplist Automatics"].url = "/carpe/win_jumplist_automatics.do";
      artifactKind["Jumplist Automatics"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_path', dataField: 'file_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'record_time', dataField: 'record_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'access_count', dataField: 'access_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'entry_id', dataField: 'entry_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_ext', dataField: 'file_ext', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_attribute', dataField: 'file_attribute', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_size', dataField: 'file_size', width: '10%', cellsalign: 'left', align: 'center'},{text: 'app_id', dataField: 'app_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'application_name', dataField: 'application_name', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      
     
      // lv1_os_win_thumbnail_cache
      artifactKind["Thumbnail Cache"] = {};
      artifactKind["Thumbnail Cache"].url = "/carpe/win_thumbnail_cache.do";
      artifactKind["Thumbnail Cache"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'owner', dataField: 'owner', width: '10%', cellsalign: 'left', align: 'center'},{text: 'filename', dataField: 'filename', width: '10%', cellsalign: 'left', align: 'center'},{text: 'filesize', dataField: 'filesize', width: '10%', cellsalign: 'left', align: 'center'},{text: 'imagetype', dataField: 'imagetype', width: '10%', cellsalign: 'left', align: 'center'},{text: 'data', dataField: 'data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'sha1', dataField: 'sha1', width: '10%', cellsalign: 'left', align: 'center'}
      ];




   	// lv1_app_kakaotalk_new_chatLogs
      artifactKind["New Chatlogs"] = {};
      artifactKind["New Chatlogs"].url = "/carpe/app_kakaotalk_new_chatLogs.do";
      artifactKind["New Chatlogs"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'logId', dataField: 'logId', width: '10%', cellsalign: 'left', align: 'center'},{text: 'authorId', dataField: 'authorId', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'clientMsgId', dataField: 'clientMsgId', width: '10%', cellsalign: 'left', align: 'center'},{text: 'sendAt', dataField: 'sendAt', width: '10%', cellsalign: 'left', align: 'center'},{text: 'message', dataField: 'message', width: '10%', cellsalign: 'left', align: 'center'},{text: 'attachment', dataField: 'attachment', width: '10%', cellsalign: 'left', align: 'center'},{text: 'pc_logout', dataField: 'pc_logout', width: '10%', cellsalign: 'left', align: 'center'},{text: 'prev_msg_missing', dataField: 'prev_msg_missing', width: '10%', cellsalign: 'left', align: 'center'},{text: 'next_msg_missing', dataField: 'next_msg_missing', width: '10%', cellsalign: 'left', align: 'center'},{text: 'deleted', dataField: 'deleted', width: '10%', cellsalign: 'left', align: 'center'},{text: 'prevLogId', dataField: 'prevLogId', width: '10%', cellsalign: 'left', align: 'center'},{text: 'feed_flags', dataField: 'feed_flags', width: '10%', cellsalign: 'left', align: 'center'},{text: 'write_on_pc', dataField: 'write_on_pc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_link_message', dataField: 'is_link_message', width: '10%', cellsalign: 'left', align: 'center'},{text: 'referrer', dataField: 'referrer', width: '10%', cellsalign: 'left', align: 'center'},{text: 'supplement', dataField: 'supplement', width: '10%', cellsalign: 'left', align: 'center'},{text: 'rewrite', dataField: 'rewrite', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_encrypt_delete_msg', dataField: 'is_encrypt_delete_msg', width: '10%', cellsalign: 'left', align: 'center'}
      ];
      
   // lv1_app_kakaotalk_chatLogs
      artifactKind["Kakaotalk Chatlogs"] = {};
      artifactKind["Kakaotalk Chatlogs"].url = "/carpe/app_kakaotalk_chatLogs.do";
      artifactKind["Kakaotalk Chatlogs"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'logId', dataField: 'logId', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'authorId', dataField: 'authorId', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'clientMsgId', dataField: 'clientMsgId', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'sendAt', dataField: 'sendAt', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'message', dataField: 'message', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'attachement', dataField: 'attachement', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'pc_logout', dataField: 'pc_logout', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'prev_msg_missing', dataField: 'prev_msg_missing', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'next_msg_missing', dataField: 'next_msg_missing', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'deleted', dataField: 'deleted', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'prevLogId', dataField: 'prevLogId', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'feed_flags', dataField: 'feed_flags', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'write_on_pc', dataField: 'write_on_pc', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'is_link_message', dataField: 'is_link_message', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'referer', dataField: 'referer', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'supplement', dataField: 'supplement', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'rewrite', dataField: 'rewrite', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'is_encrypt_delete_msg', dataField: 'is_encrypt_delete_msg', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_kakaotalk_chatLog_attachment
      artifactKind["Kakaotalk Chatlog Attachment"] = {};
      artifactKind["Kakaotalk Chatlog Attachment"].url = "/carpe/app_kakaotalk_chatLog_attachment.do";
      artifactKind["Kakaotalk Chatlog Attachment"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'logId', dataField: 'logId', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'attach_thumbnailData', dataField: 'attach_thumbnailData', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'attach_fullData', dataField: 'attach_fullData', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'attach_downloadLocalFile', dataField: 'attach_downloadLocalFile', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'attach_lastWriteTime', dataField: 'attach_lastWriteTime', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'serverStatusCode', dataField: 'serverStatusCode', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'sendLogStatus', dataField: 'sendLogStatus', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_kakaotalk_chatLogDrafts
      artifactKind["Kakaotalk Chatlog Drafts"] = {};
      artifactKind["Kakaotalk Chatlog Drafts"].url = "/carpe/app_kakaotalk_chatLogDrafts.do";
      artifactKind["Kakaotalk Chatlog Drafts"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'clientMsgId', dataField: 'clientMsgId', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'message', dataField: 'message', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'extra', dataField: 'extra', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'attach_data', dataField: 'attach_data', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'supplement', dataField: 'supplement', width: '10%', cellsalign: 'left', align: 'center'},
      {text: 'lastknownstate', dataField: 'lastknownstate', width: '10%', cellsalign: 'left', align: 'center'}
      ];


   // lv1_fs_ntfs_logfile_log_record
      artifactKind["Log Record"] = {};
      artifactKind["Log Record"].url = "/carpe/ntfs_logfile_log_record.do";
      artifactKind["Log Record"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'lsn', dataField: 'lsn', width: '10%', cellsalign: 'left', align: 'center'},{text: 'transaction_id', dataField: 'transaction_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'redo_op', dataField: 'redo_op', width: '10%', cellsalign: 'left', align: 'center'},{text: 'undo_op', dataField: 'undo_op', width: '10%', cellsalign: 'left', align: 'center'},{text: 'target_file_number', dataField: 'target_file_number', width: '10%', cellsalign: 'left', align: 'center'},{text: 'target_reference', dataField: 'target_reference', width: '10%', cellsalign: 'left', align: 'center'},{text: 'target_attribute_name', dataField: 'target_attribute_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_path', dataField: 'file_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'offset_in_target', dataField: 'offset_in_target', width: '10%', cellsalign: 'left', align: 'center'},{text: 'lcn', dataField: 'lcn', width: '10%', cellsalign: 'left', align: 'center'},{text: 'redo_data', dataField: 'redo_data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'undo_data', dataField: 'undo_data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'attribute', dataField: 'attribute', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_fs_ntfs_logfile_restart_area
      artifactKind["Restart Area"] = {};
      artifactKind["Restart Area"].url = "/carpe/ntfs_logfile_restart_area.do";
      artifactKind["Restart Area"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'lsn', dataField: 'lsn', width: '10%', cellsalign: 'left', align: 'center'},{text: 'version', dataField: 'version', width: '10%', cellsalign: 'left', align: 'center'},{text: 'start_of_checkpoint', dataField: 'start_of_checkpoint', width: '10%', cellsalign: 'left', align: 'center'},{text: 'open_attribute_table_lsn', dataField: 'open_attribute_table_lsn', width: '10%', cellsalign: 'left', align: 'center'},{text: 'open_attribute_table_length', dataField: 'open_attribute_table_length', width: '10%', cellsalign: 'left', align: 'center'},{text: 'attributes_names_lsn', dataField: 'attributes_names_lsn', width: '10%', cellsalign: 'left', align: 'center'},{text: 'attributes_names_length', dataField: 'attributes_names_length', width: '10%', cellsalign: 'left', align: 'center'},{text: 'dirty_page_table_lsn', dataField: 'dirty_page_table_lsn', width: '10%', cellsalign: 'left', align: 'center'},{text: 'dirty_page_table_length', dataField: 'dirty_page_table_length', width: '10%', cellsalign: 'left', align: 'center'},{text: 'transaction_table_lsn', dataField: 'transaction_table_lsn', width: '10%', cellsalign: 'left', align: 'center'},{text: 'transaction_table_length', dataField: 'transaction_table_length', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_fs_ntfs_mft
      artifactKind["MFT"] = {};
      artifactKind["MFT"].url = "/carpe/ntfs_mft.do";
      artifactKind["MFT"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'},{text: 'mft_reference_number', dataField: 'mft_reference_number', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_in_use', dataField: 'is_in_use', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_directory', dataField: 'is_directory', width: '10%', cellsalign: 'left', align: 'center'},{text: 'lsn', dataField: 'lsn', width: '10%', cellsalign: 'left', align: 'center'},{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'},{text: '$SI_mtime', dataField: '$SI_mtime', width: '10%', cellsalign: 'left', align: 'center'},{text: '$SI_atime', dataField: '$SI_atime', width: '10%', cellsalign: 'left', align: 'center'},{text: '$SI_ctime', dataField: '$SI_ctime', width: '10%', cellsalign: 'left', align: 'center'},{text: '$SI_etime', dataField: '$SI_etime', width: '10%', cellsalign: 'left', align: 'center'},{text: '$SI_usn', dataField: '$SI_usn', width: '10%', cellsalign: 'left', align: 'center'},{text: '$FN_mtime', dataField: '$FN_mtime', width: '10%', cellsalign: 'left', align: 'center'},{text: '$FN_atime', dataField: '$FN_atime', width: '10%', cellsalign: 'left', align: 'center'},{text: '$FN_ctime', dataField: '$FN_ctime', width: '10%', cellsalign: 'left', align: 'center'},{text: '$FN_etime', dataField: '$FN_etime', width: '10%', cellsalign: 'left', align: 'center'},{text: '$OBJID_timestamp', dataField: '$OBJID_timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_size', dataField: 'file_size', width: '10%', cellsalign: 'left', align: 'center'},{text: 'ads_list', dataField: 'ads_list', width: '10%', cellsalign: 'left', align: 'center'},{text: 'wsl_mtime', dataField: 'wsl_mtime', width: '10%', cellsalign: 'left', align: 'center'},{text: 'wsl_atime', dataField: 'wsl_atime', width: '10%', cellsalign: 'left', align: 'center'},{text: 'wsl_chtime', dataField: 'wsl_chtime', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_fs_ntfs_usnjrnl
      artifactKind["UsnJrnl"] = {};
      artifactKind["UsnJrnl"].url = "/carpe/ntfs_usnjrnl.do";
      artifactKind["UsnJrnl"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'usn_value', dataField: 'usn_value', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'},{text: 'reason', dataField: 'reason', width: '10%', cellsalign: 'left', align: 'center'},{text: 'mft_reference_number', dataField: 'mft_reference_number', width: '10%', cellsalign: 'left', align: 'center'},{text: 'parent_mft_reference_number', dataField: 'parent_mft_reference_number', width: '10%', cellsalign: 'left', align: 'center'},{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_name', dataField: 'file_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file_path_from_mft', dataField: 'file_path_from_mft', width: '10%', cellsalign: 'left', align: 'center'}
      ];

   // lv1_app_kakaotalk_mobile_chatlogs
      artifactKind["Chatlogs"] = {};
      artifactKind["Chatlogs"].url = "/carpe/app_kakaotalk_mobile_chatlogs.do";
      artifactKind["Chatlogs"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: '_id', dataField: '_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'chat_id', dataField: 'chat_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'user_id', dataField: 'user_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'message', dataField: 'message', width: '10%', cellsalign: 'left', align: 'center'},{text: 'attachment', dataField: 'attachment', width: '10%', cellsalign: 'left', align: 'center'},{text: 'created_at', dataField: 'created_at', width: '10%', cellsalign: 'left', align: 'center'},{text: 'deleted_at', dataField: 'deleted_at', width: '10%', cellsalign: 'left', align: 'center'},{text: 'client_message_id', dataField: 'client_message_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'prev_id', dataField: 'prev_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'v', dataField: 'v', width: '10%', cellsalign: 'left', align: 'center'}
      ];

   // lv1_app_kakaotalk_mobile_chatrooms
      artifactKind["Chatrooms"] = {};
      artifactKind["Chatrooms"].url = "/carpe/app_kakaotalk_mobile_chatrooms.do";
      artifactKind["Chatrooms"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: '_id', dataField: '_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'members', dataField: 'members', width: '10%', cellsalign: 'left', align: 'center'},{text: 'active_member_ids', dataField: 'active_member_ids', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_log_id', dataField: 'last_log_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_message', dataField: 'last_message', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_updated_at', dataField: 'last_updated_at', width: '10%', cellsalign: 'left', align: 'center'},{text: 'unread_count', dataField: 'unread_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'watermarks', dataField: 'watermarks', width: '10%', cellsalign: 'left', align: 'center'},{text: 'temporary_message', dataField: 'temporary_message', width: '10%', cellsalign: 'left', align: 'center'},{text: 'v', dataField: 'v', width: '10%', cellsalign: 'left', align: 'center'},{text: 'ext', dataField: 'ext', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_read_log_id', dataField: 'last_read_log_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_update_seen_id', dataField: 'last_update_seen_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'active_members_count', dataField: 'active_members_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'meta', dataField: 'meta', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_hint', dataField: 'is_hint', width: '10%', cellsalign: 'left', align: 'center'},{text: 'private_meta', dataField: 'private_meta', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_chat_log_type', dataField: 'last_chat_log_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'schat_token', dataField: 'schat_token', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_skey_token', dataField: 'last_skey_token', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_pk_tokens', dataField: 'last_pk_tokens', width: '10%', cellsalign: 'left', align: 'center'},{text: 'link_id', dataField: 'link_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'moim_meta', dataField: 'moim_meta', width: '10%', cellsalign: 'left', align: 'center'},{text: 'invite_info', dataField: 'invite_info', width: '10%', cellsalign: 'left', align: 'center'},{text: 'blinded_member_ids', dataField: 'blinded_member_ids', width: '10%', cellsalign: 'left', align: 'center'},{text: 'mute_until_at', dataField: 'mute_until_at', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_joined_log_id', dataField: 'last_joined_log_id', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_app_kakaotalk_mobile_friends
      artifactKind["Friends"] = {};
      artifactKind["Friends"].url = "/carpe/app_kakaotalk_mobile_friends.do";
      artifactKind["Friends"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: '_id', dataField: '_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'id', dataField: 'id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'members', dataField: 'members', width: '10%', cellsalign: 'left', align: 'center'},{text: 'active_member_ids', dataField: 'active_member_ids', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_log_id', dataField: 'last_log_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_message', dataField: 'last_message', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_updated_at', dataField: 'last_updated_at', width: '10%', cellsalign: 'left', align: 'center'},{text: 'unread_count', dataField: 'unread_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'watermarks', dataField: 'watermarks', width: '10%', cellsalign: 'left', align: 'center'},{text: 'temporary_message', dataField: 'temporary_message', width: '10%', cellsalign: 'left', align: 'center'},{text: 'v', dataField: 'v', width: '10%', cellsalign: 'left', align: 'center'},{text: 'ext', dataField: 'ext', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_read_log_id', dataField: 'last_read_log_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_update_seen_id', dataField: 'last_update_seen_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'active_members_count', dataField: 'active_members_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'meta', dataField: 'meta', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_hint', dataField: 'is_hint', width: '10%', cellsalign: 'left', align: 'center'},{text: 'private_meta', dataField: 'private_meta', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_chat_log_type', dataField: 'last_chat_log_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'schat_token', dataField: 'schat_token', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_skey_token', dataField: 'last_skey_token', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_pk_tokens', dataField: 'last_pk_tokens', width: '10%', cellsalign: 'left', align: 'center'},{text: 'link_id', dataField: 'link_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'moim_meta', dataField: 'moim_meta', width: '10%', cellsalign: 'left', align: 'center'},{text: 'invite_info', dataField: 'invite_info', width: '10%', cellsalign: 'left', align: 'center'},{text: 'blinded_member_ids', dataField: 'blinded_member_ids', width: '10%', cellsalign: 'left', align: 'center'},{text: 'mute_until_at', dataField: 'mute_until_at', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_joined_log_id', dataField: 'last_joined_log_id', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_app_list
      artifactKind["App List"] = {};
      artifactKind["App List"].url = "/carpe/and_app_list.do";
      artifactKind["App List"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_deleted', dataField: 'is_deleted', width: '10%', cellsalign: 'left', align: 'center'},{text: 'category', dataField: 'category', width: '10%', cellsalign: 'left', align: 'center'},{text: 'package_name', dataField: 'package_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'app_name', dataField: 'app_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'version', dataField: 'version', width: '10%', cellsalign: 'left', align: 'center'},{text: 'installed_time', dataField: 'installed_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'apk_changed_time', dataField: 'apk_changed_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'updated_time', dataField: 'updated_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'deleted_time', dataField: 'deleted_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'fs_ctime', dataField: 'fs_ctime', width: '10%', cellsalign: 'left', align: 'center'},{text: 'fs_crtime', dataField: 'fs_crtime', width: '10%', cellsalign: 'left', align: 'center'},{text: 'fs_atime', dataField: 'fs_atime', width: '10%', cellsalign: 'left', align: 'center'},{text: 'fs_mtime', dataField: 'fs_mtime', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_updated', dataField: 'is_updated', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_call_history
      artifactKind["Call History"] = {};
      artifactKind["Call History"].url = "/carpe/and_call_history.do";
      artifactKind["Call History"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'package_name', dataField: 'package_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'time_duration', dataField: 'time_duration', width: '10%', cellsalign: 'left', align: 'center'},{text: 'phonenumber', dataField: 'phonenumber', width: '10%', cellsalign: 'left', align: 'center'},{text: 'account', dataField: 'account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'digit_positive', dataField: 'digit_positive', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file', dataField: 'file', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_emb_file
      artifactKind["Emb File"] = {};
      artifactKind["Emb File"].url = "/carpe/and_emb_file.do";
      artifactKind["Emb File"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'is_compressed', dataField: 'is_compressed', width: '10%', cellsalign: 'left', align: 'center'},{text: 'parent_path', dataField: 'parent_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'extension', dataField: 'extension', width: '10%', cellsalign: 'left', align: 'center'},{text: 'mod_time', dataField: 'mod_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'size', dataField: 'size', width: '10%', cellsalign: 'left', align: 'center'},{text: 'compressed_size', dataField: 'compressed_size', width: '10%', cellsalign: 'left', align: 'center'},{text: 'CRC', dataField: 'CRC', width: '10%', cellsalign: 'left', align: 'center'},{text: 'created_system', dataField: 'created_system', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source_path', dataField: 'source_path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_file_history
      artifactKind["File History"] = {};
      artifactKind["File History"].url = "/carpe/and_file_history.do";
      artifactKind["File History"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'package_name', dataField: 'package_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file', dataField: 'file', width: '10%', cellsalign: 'left', align: 'center'},{text: 'phonenumber', dataField: 'phonenumber', width: '10%', cellsalign: 'left', align: 'center'},{text: 'account', dataField: 'account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_geodata
      artifactKind["Geodata"] = {};
      artifactKind["Geodata"].url = "/carpe/and_geodata.do";
      artifactKind["Geodata"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'package_name', dataField: 'package_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'geodata', dataField: 'geodata', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file', dataField: 'file', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_id_pw_hash
      artifactKind["Id&pw hash"] = {};
      artifactKind["Id&pw hash"].url = "/carpe/and_id_pw_hash.do";
      artifactKind["Id&pw hash"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'package_name', dataField: 'package_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'account', dataField: 'account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'pwd', dataField: 'pwd', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'},{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_web_browser_history
      artifactKind["Web Browser History"] = {};
      artifactKind["Web Browser History"].url = "/carpe/and_web_browser_history.do";
      artifactKind["Web Browser History"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'package_name', dataField: 'package_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'url', dataField: 'url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'account', dataField: 'account', width: '10%', cellsalign: 'left', align: 'center'},{text: 'digit_positive', dataField: 'digit_positive', width: '10%', cellsalign: 'left', align: 'center'},{text: 'file', dataField: 'file', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contents', dataField: 'contents', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'}
      ];


   // lv1_os_and_basic_app_accounts_ce_0
      artifactKind["Accounts CE 0"] = {};
      artifactKind["Accounts CE 0"].url = "/carpe/and_basic_app_accounts_ce_0.do";
      artifactKind["Accounts CE 0"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password', dataField: 'password', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_accounts_de_0
      artifactKind["Accounts DE 0"] = {};
      artifactKind["Accounts DE 0"].url = "/carpe/and_basic_app_accounts_de_0.do";
      artifactKind["Accounts DE 0"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_password_entry', dataField: 'last_password_entry', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_call_logs
      artifactKind["Call Logs"] = {};
      artifactKind["Call Logs"].url = "/carpe/and_basic_app_call_logs.do";
      artifactKind["Call Logs"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'phone_account_address', dataField: 'phone_account_address', width: '10%', cellsalign: 'left', align: 'center'},{text: 'partner', dataField: 'partner', width: '10%', cellsalign: 'left', align: 'center'},{text: 'call_date', dataField: 'call_date', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'duration_in_secs', dataField: 'duration_in_secs', width: '10%', cellsalign: 'left', align: 'center'},{text: 'partner_location', dataField: 'partner_location', width: '10%', cellsalign: 'left', align: 'center'},{text: 'country_iso', dataField: 'country_iso', width: '10%', cellsalign: 'left', align: 'center'},{text: 'data', dataField: 'data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'mime_type', dataField: 'mime_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'transcription', dataField: 'transcription', width: '10%', cellsalign: 'left', align: 'center'},{text: 'deleted', dataField: 'deleted', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_file_cache
      artifactKind["File Cache"] = {};
      artifactKind["File Cache"].url = "/carpe/and_basic_app_file_cache.do";
      artifactKind["File Cache"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'storage', dataField: 'storage', width: '10%', cellsalign: 'left', align: 'center'},{text: 'path', dataField: 'path', width: '10%', cellsalign: 'left', align: 'center'},{text: 'size', dataField: 'size', width: '10%', cellsalign: 'left', align: 'center'},{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'latest', dataField: 'latest', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_mms
      artifactKind["MMS"] = {};
      artifactKind["MMS"].url = "/carpe/and_basic_app_mms.do";
      artifactKind["MMS"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'mms_id', dataField: 'mms_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'thread_id', dataField: 'thread_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date', dataField: 'date', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_sent', dataField: 'date_sent', width: '10%', cellsalign: 'left', align: 'center'},{text: 'read', dataField: 'read', width: '10%', cellsalign: 'left', align: 'center'},{text: 'from', dataField: 'from', width: '10%', cellsalign: 'left', align: 'center'},{text: 'to', dataField: 'to', width: '10%', cellsalign: 'left', align: 'center'},{text: 'cc', dataField: 'cc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'bcc', dataField: 'bcc', width: '10%', cellsalign: 'left', align: 'center'},{text: 'body', dataField: 'body', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_recent_files
      artifactKind["Recent Files"] = {};
      artifactKind["Recent Files"].url = "/carpe/and_basic_app_recent_files.do";
      artifactKind["Recent Files"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'name', dataField: 'name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'size', dataField: 'size', width: '10%', cellsalign: 'left', align: 'center'},{text: 'timestamp', dataField: 'timestamp', width: '10%', cellsalign: 'left', align: 'center'},{text: 'data', dataField: 'data', width: '10%', cellsalign: 'left', align: 'center'},{text: 'ext', dataField: 'ext', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'},{text: 'description', dataField: 'description', width: '10%', cellsalign: 'left', align: 'center'},{text: 'recent_timestamp', dataField: 'recent_timestamp', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_sim_info
      artifactKind["Sim Info"] = {};
      artifactKind["Sim Info"].url = "/carpe/and_basic_app_sim_info.do";
      artifactKind["Sim Info"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'icc_id', dataField: 'icc_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'sim_id', dataField: 'sim_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'display_name', dataField: 'display_name', width: '10%', cellsalign: 'left', align: 'center'},{text: 'carrier_name', dataField: 'carrier_name', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_sim_info_dat
      artifactKind["Sim Info Dat"] = {};
      artifactKind["Sim Info Dat"].url = "/carpe/and_basic_app_sim_info_dat.do";
      artifactKind["Sim Info Dat"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'PreviousSimCountryIso', dataField: 'PreviousSimCountryIso', width: '10%', cellsalign: 'left', align: 'center'},{text: 'PreviousSimOperator', dataField: 'PreviousSimOperator', width: '10%', cellsalign: 'left', align: 'center'},{text: 'PreviousSimOperatorName', dataField: 'PreviousSimOperatorName', width: '10%', cellsalign: 'left', align: 'center'},{text: 'PreviousSimSerialNumber', dataField: 'PreviousSimSerialNumber', width: '10%', cellsalign: 'left', align: 'center'},{text: 'PreviousSimPhoneNumber', dataField: 'PreviousSimPhoneNumber', width: '10%', cellsalign: 'left', align: 'center'},{text: 'CurrentSimCountryIso', dataField: 'CurrentSimCountryIso', width: '10%', cellsalign: 'left', align: 'center'},{text: 'CurrentSimOperator', dataField: 'CurrentSimOperator', width: '10%', cellsalign: 'left', align: 'center'},{text: 'CurrentSimOperatorName', dataField: 'CurrentSimOperatorName', width: '10%', cellsalign: 'left', align: 'center'},{text: 'CurrentSimSerialNumber', dataField: 'CurrentSimSerialNumber', width: '10%', cellsalign: 'left', align: 'center'},{text: 'CurrentSimPhoneNumber', dataField: 'CurrentSimPhoneNumber', width: '10%', cellsalign: 'left', align: 'center'},{text: 'SimChangeTime', dataField: 'SimChangeTime', width: '10%', cellsalign: 'left', align: 'center'},{text: 'SimChangeOperation', dataField: 'SimChangeOperation', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_sms
      artifactKind["SMS"] = {};
      artifactKind["SMS"].url = "/carpe/and_basic_app_sms.do";
      artifactKind["SMS"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'msg_id', dataField: 'msg_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'thread_id', dataField: 'thread_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'address', dataField: 'address', width: '10%', cellsalign: 'left', align: 'center'},{text: 'contact_id', dataField: 'contact_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date', dataField: 'date', width: '10%', cellsalign: 'left', align: 'center'},{text: 'date_sent', dataField: 'date_sent', width: '10%', cellsalign: 'left', align: 'center'},{text: 'read', dataField: 'read', width: '10%', cellsalign: 'left', align: 'center'},{text: 'type', dataField: 'type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'body', dataField: 'body', width: '10%', cellsalign: 'left', align: 'center'},{text: 'service_center', dataField: 'service_center', width: '10%', cellsalign: 'left', align: 'center'},{text: 'error_code', dataField: 'error_code', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_usagestats_0
      artifactKind["Usagestats 0"] = {};
      artifactKind["Usagestats 0"].url = "/carpe/and_basic_app_usagestats_0.do";
      artifactKind["Usagestats 0"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'usage_type', dataField: 'usage_type', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_time_active', dataField: 'last_time_active', width: '10%', cellsalign: 'left', align: 'center'},{text: 'time_active_in_msecs', dataField: 'time_active_in_msecs', width: '10%', cellsalign: 'left', align: 'center'},{text: 'time_active_in_secs', dataField: 'time_active_in_secs', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_time_service_used', dataField: 'last_time_service_used', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_time_visible', dataField: 'last_time_visible', width: '10%', cellsalign: 'left', align: 'center'},{text: 'total_time_visible', dataField: 'total_time_visible', width: '10%', cellsalign: 'left', align: 'center'},{text: 'app_launch_count', dataField: 'app_launch_count', width: '10%', cellsalign: 'left', align: 'center'},{text: 'package', dataField: 'package', width: '10%', cellsalign: 'left', align: 'center'},{text: 'types', dataField: 'types', width: '10%', cellsalign: 'left', align: 'center'},{text: 'class', dataField: 'class', width: '10%', cellsalign: 'left', align: 'center'},{text: 'source', dataField: 'source', width: '10%', cellsalign: 'left', align: 'center'},{text: 'all_attributes', dataField: 'all_attributes', width: '10%', cellsalign: 'left', align: 'center'}
      ];

      // lv1_os_and_basic_app_wifi_info
      artifactKind["Wifi Info"] = {};
      artifactKind["Wifi Info"].url = "/carpe/and_basic_app_wifi_info.do";
      artifactKind["Wifi Info"].columnSet = [
      {text: 'par_id', dataField: 'par_id', width: '10%', cellsalign: 'left', align: 'center'},{text: 'security_mode', dataField: 'security_mode', width: '10%', cellsalign: 'left', align: 'center'},{text: 'ssid', dataField: 'ssid', width: '10%', cellsalign: 'left', align: 'center'},{text: 'pre_shared_key', dataField: 'pre_shared_key', width: '10%', cellsalign: 'left', align: 'center'},{text: 'wep_keys', dataField: 'wep_keys', width: '10%', cellsalign: 'left', align: 'center'},{text: 'password', dataField: 'password', width: '10%', cellsalign: 'left', align: 'center'},{text: 'identity', dataField: 'identity', width: '10%', cellsalign: 'left', align: 'center'},{text: 'default_gw_mac_address', dataField: 'default_gw_mac_address', width: '10%', cellsalign: 'left', align: 'center'},{text: 'sem_creation_time', dataField: 'sem_creation_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'sem_update_time', dataField: 'sem_update_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'last_connected_time', dataField: 'last_connected_time', width: '10%', cellsalign: 'left', align: 'center'},{text: 'captive_portal', dataField: 'captive_portal', width: '10%', cellsalign: 'left', align: 'center'},{text: 'login_url', dataField: 'login_url', width: '10%', cellsalign: 'left', align: 'center'},{text: 'ip_assignment', dataField: 'ip_assignment', width: '10%', cellsalign: 'left', align: 'center'}
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
        $("#jqxTree_artifacts").jqxTree({ source: treeRootDir, allowDrag:false, width:'calc(100%)', height:'calc(100%)'});
  
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