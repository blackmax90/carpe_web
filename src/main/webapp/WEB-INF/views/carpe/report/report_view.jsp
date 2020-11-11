<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title>Examination Report</title>
    <style>
      @page { size:210mm 297mm; /*A4*/ margin:0; }
      @media print{
        * { box-sizing: border-box; }
            html { font-size: 8pt; }
            html, body { width:210mm; height:297mm; margin: 0; page-break-after: avoid; page-break-before: avoid; }
            tr { page-break-inside: avoid; }
      .report_page { position:relative; margin: -1px 0 0 0; background: #FFF; overflow:hidden; page-break-inside: avoid; page-break-before: always; }
      .report_page:first-child { page-break-before: auto; page-break-inside: avoid; }
      }
      
    /* Common */
    * { margin:0; padding:0; box-sizing:border-box; }
      html{ font-size:10px; word-break:break-all;  background: #FFF; }
      body{ width: 100%; height: 100%; margin: 0; padding: 0; color:#000; font-family:'Malgun Gothic','맑은 고딕', '돋움'; font-size:inherit; font-weight:normal; line-height:1.2; overflow:auto; -webkit-font-smoothing:antialiased; -webkit-print-color-adjust: exact; }
      table { position: relative; float: left; width: 100%; margin-top:0.5rem; border-spacing:0; border-collapse:collapse; word-break:break-all; table-layout: fixed; }
      article, section, .desc { position: relative; display: block; float: left; width: 100%; }
      header { position: absolute; top: 10mm; left: 10mm; width: 190mm; height: 6rem; }
      section { padding-top: 6rem; }
    .report_page { position: relative; display: block; float: left; width: 210mm; min-height: 297mm; padding: 10mm; margin: -1px auto 0; font-size:1.4rem; }
      
    h1 { position: relative; display:block; width:100%; margin: 40mm auto; line-height:1; text-align: center; }
      h1 img { display:block; width:48rem; height:auto; margin: 0 auto; padding: 1rem; }
      h2 { display:inline-block; width: auto; font-size:1.6rem; }
    h3 { display:block; float:left; width:100%; font-size: 2rem; line-height:3rem; }
    h4 { display:block; float:left; width:100%; padding-left: 2rem; font-size: 1.6rem; font-weight:400; line-height:3rem; }

    .mt15 { margin-top: 1.5rem !important; }

        /* Content */
        .cover .tit-area { display: block; padding: 0; line-height: 3rem; text-align: center; border-bottom: 0;}
        .cover .tit-area h2 { display: block; width:100%; font-size: 4.8rem; line-height: 6rem; }
        .cover .tit-area p { display: block; color:#666; font-size: 1.8rem; line-height:3rem; }
        .cover .case-info { width: 60%; min-width: 48rem; margin-top: 60mm; }

        .tit-area { padding-bottom: 0.5rem; margin-bottom: 0.5rem; line-height:2.4rem; border-bottom: 0.2rem solid #666; }
        .page-top p { display:inline-block; float: right; font-size: 1.6rem; font-weight:700; }
        .tit-area p span:before { content:":"; margin-left: 0.8rem; margin-right: 0.8rem; }
        .page-top .page-count { font-size: 1.4rem; font-weight: 400; }

        .desc { padding: 2rem; font-size: 1.4rem; line-height: 2.4rem; }

        table .center { text-align: center !important; }
        .tbl-list thead { display: table-row-group; }
        .tbl-list thead th { background: #e0e0e0; }
        .tbl-list thead th, .tbl-list tbody th, .tbl-list tbody td { padding:0.5rem 1rem; font-size:1.4rem; line-height:2.4rem; border: 0.1rem solid #d9d9d9; }
        .tbl-list tbody th { font-weight: 400; text-align:left; background: #f2f2f2; word-break: break-word; }
    .tbl-list tbody td p span:before { content:":"; margin-left: 0.5rem; margin-right: 0.5rem; }
    </style>
</head>
<body>
    <c:set var="idx" value="1" />
    <div class="report_page">
    <section class="cover">
      <h1><img src="/carpe/resources/images/logo_carpe.png" alt="carpe forensics" /></h1>
      <article class="tit-area">
        <h2>Examination Report</h2>
        <p>Report Created Date<span>${reportTime}</span></p>
      </article>
      <article class="case-info">
        <h3>${idx}. Case Information</h3>
        <table class="tbl-list">
          <colgroup>
            <col width="140">
            <col width="*">
          </colgroup>
          <tbody>
            <tr>
              <th>Case Name</th>
              <td>${caseInfo.case_name}</td>
            </tr>
            <tr>
              <th>Administrator</th>
              <td>${caseInfo.administrator}</td>
            </tr>
            <tr>
              <th>Description</th>
              <td>${caseInfo.description}</td>
            </tr>
            <tr>
              <th>Timezone</th>
              <td>${caseInfo.timezone}</td>
            </tr>
            <tr>
              <th>Case Created Date</th>
              <td>${caseInfo.create_date}</td>
            </tr>
          </tbody>
        </table>
      </article>
    </section>
  </div>
  
  <c:forEach var="evdnc" items="${evdncList}">
    <c:set var="evdncFile" value="${fn:split(evdnc.evd_path, '/')}" />
    <div class="report_page">
      <header class="page-top">
        <div class="tit-area">
        <h2>Examination Report</h2>
        <p>Case<span>${caseInfo.case_name}</span></p>
        </div>
      </header>
    <section>
      <c:set var="idx" value="${idx + 1}" />
      <h3>${idx}. Evidence Information</h3>
      <article>
        <table class="tbl-list">
          <colgroup>
            <col width="140">
            <col width="*">
          </colgroup>
          <thead>
            <tr>
              <th colspan="2">Evidence</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th>Evidence ID</th>
              <td>${evdnc.evd_id}</td>
            </tr>
            <tr>
              <th>Evidence Name</th>
              <td>${evdnc.evd_name}</td>
            </tr>
            <tr>
              <th>Evidence File</th>
              <td>${evdncFile[fn:length(evdncFile)-1]}</td>
            </tr>
            <tr>
              <th>Evidence Type</th>
              <td>${evdnc.main_type}/${evdnc.sub_type}</td>
            </tr>
            <tr>
              <th>Timezone</th>
              <td>${evdnc.timezone}</td>
            </tr>
            <tr>
              <th>Acquired Date</th>
              <td>${evdnc.acquired_date}</td>
            </tr>
            <tr>
              <th>Hash</th>
              <td>
                <p>md5<span>${evdnc.md5}</span></p>
                <p>sha1<span>${evdnc.sha1}</span></p>
                <p>sha3<span>${evdnc.sha3}</span></p>
              </td>
            </tr>
          </tbody>
        </table>
      </article>
      <article class="mt15">
        <table class="tbl-list">
          <colgroup>
            <col width="50">
            <col width="140">
            <col width="*">
          </colgroup>
          <thead>
            <tr>
              <th colspan="3">Partition</th>
            </tr>
          </thead>
          <tbody>

          <c:forEach var="parInfo" items="${evdnc.parList}">
            <tr>
              <th rowspan="7" class="center"><strong>${parInfo.par_name}</strong></th>
              <th>Partition ID</th>
              <td>${parInfo.par_id}</td>
            </tr>
            <tr>
              <th>Sector Size</th>
              <td>${parInfo.sector_size}</td>
            </tr>
            <tr>
              <th>Partition Size</th>
              <td>${parInfo.par_size}</td>
            </tr>
            <tr>
              <th>Start Sector</th>
              <td>${parInfo.start_sector}</td>
            </tr>
            <tr>
              <th>Number of files</th>
              <td>${parInfo.file_cnt}</td>
            </tr>
            <tr>
              <th>File System</th>
              <td>${parInfo.filesystem}</td>
            </tr>
            <tr>
              <th>Partition Label</th>
              <td>${parInfo.par_label}</td>
            </tr>
          </c:forEach>

          </tbody>
        </table>
      </article>
    </section>
  </div>

    <div class="report_page">
      <header class="page-top">
        <div class="tit-area">
        <h2>Examination Report</h2>
        <p>Case<span>${caseInfo.case_name}</span></p>
        </div>
      </header>
    <section>
      <c:set var="idx" value="${idx + 1}" />
      <h3>${idx}. Basic Analysis Information</h3>
      <article>
        <h4>${idx}.1. Operating System</h4>

        <c:forEach var="osInfo" items="${evdnc.osList}">
        <table class="tbl-list">
          <colgroup>
            <col width="160">
            <col width="*">
          </colgroup>
          <thead>
            <tr>
              <th colspan="2">Evidence</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th>Evidence ID</th>
              <td>${evdnc.evd_id}</td>
            </tr>
            <tr>
              <th>Evidence Name</th>
              <td>${evdnc.evd_name}</td>
            </tr>
            <tr>
              <th>Partition ID</th>
              <td>${osInfo.par_id}</td>
            </tr>
            <tr>
              <th>Operating System</th>
              <td>${osInfo.operating_system}</td>
            </tr>
            <tr>
              <th>Release ID</th>
              <td>${osInfo.release_id}</td>
            </tr>
            <tr>
              <th>Version Number</th>
              <td>${osInfo.version_number}</td>
            </tr>
            <tr>
              <th>Install Time</th>
              <td>${osInfo.install_time}</td>
            </tr>
            <tr>
              <th>Product Key</th>
              <td>${osInfo.product_key}</td>
            </tr>
            <tr>
              <th>Owner</th>
              <td>${osInfo.owner}</td>
            </tr>
            <tr>
              <th>Display Computer Name</th>
              <td>${osInfo.display_computer_name}</td>
            </tr>
            <tr>
              <th>Computer Name</th>
              <td>${osInfo.computer_name}</td>
            </tr>
            <tr>
              <th>DHCP DNS Server</th>
              <td>${osInfo.dhcp_dns_server}</td>
            </tr>
            <tr>
              <th>Operating System Version</th>
              <td>${osInfo.operating_system_version}</td>
            </tr>
            <tr>
              <th>Build Number</th>
              <td>${osInfo.build_number}</td>
            </tr>
            <tr>
              <th>Product ID</th>
              <td>${osInfo.product_id}</td>
            </tr>
            <tr>
              <th>System Root</th>
              <td>${osInfo.system_root}</td>
            </tr>
            <tr>
              <th>Timezone</th>
              <td>${osInfo.timezone_utc}</td>
            </tr>
            <tr>
              <th>Display Timezone</th>
              <td>${osInfo.display_timezone_name}</td>
            </tr>
          </tbody>
        </table>
        </c:forEach>
      </article>
    </section>
  </div>

    <div class="report_page">
      <header class="page-top">
        <div class="tit-area">
        <h2>Examination Report</h2>
        <p>Case<span>${caseInfo.case_name}</span></p>
        </div>
      </header>
    <section>
      <article>
        <h4>${idx}.2. User account(s)</h4>

        <c:forEach var="parInfo" items="${evdnc.parList}">
        <table class="tbl-list">
          <colgroup>
            <col width="160">
            <col width="*">
          </colgroup>
          <thead>
            <tr>
              <th colspan="2">Evidence</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <th>Evidence ID</th>
              <td>${evdnc.evd_id}</td>
            </tr>
            <tr>
              <th>Evidence Name</th>
              <td>${evdnc.evd_name}</td>
            </tr>
            <tr>
              <th>Partition ID</th>
              <td>${parInfo.par_id}</td>
            </tr>
          </tbody>
        </table>
      </article>
      <article class="mt15">
        <c:forEach var="uaInfo" items="${parInfo.uaList}">
        <table class="tbl-list">
          <colgroup>
            <col width="160">
            <col width="*">
          </colgroup>
          <tbody>
            <tr>
              <th>User Name</th>
              <td>${uaInfo.user_name}</td>
            </tr>
            <tr>
              <th>Full Name</th>
              <td>${uaInfo.full_name}</td>
            </tr>
            <tr>
              <th>User Type</th>
              <td>${uaInfo.type_of_user}</td>
            </tr>
            <tr>
              <th>Account Description</th>
              <td>${uaInfo.account_description}</td>
            </tr>
            <tr>
              <th>Security ID</th>
              <td>${uaInfo.security_identifier}</td>
            </tr>
            <tr>
              <th>User Group</th>
              <td>${uaInfo.user_group}</td>
            </tr>
            <tr>
              <th>Login Script</th>
              <td>${uaInfo.login_script}</td>
            </tr>
            <tr>
              <th>Profile Path</th>
              <td>${uaInfo.profile_path}</td>
            </tr>
            <tr>
              <th>Created Time</th>
              <td>${uaInfo.account_created_time}</td>
            </tr>
            <tr>
              <th>Last Login Time</th>
              <td>${uaInfo.last_login_time}</td>
            </tr>
            <tr>
              <th>Last Password Changed Time</th>
              <td>${uaInfo.last_password_change_time}</td>
            </tr>
            <tr>
              <th>Last Incorrect Password Login Time</th>
              <td>${uaInfo.last_incorrect_password_login_time}</td>
            </tr>
            <tr>
              <th>Login Count</th>
              <td>${uaInfo.login_count}</td>
            </tr>
            <tr>
              <th>Account Disabled</th>
              <td>${uaInfo.account_disabled}</td>
            </tr>
            <tr>
              <th>Password Required</th>
              <td>${uaInfo.password_required}</td>
            </tr>
            <tr>
              <th>Password Hint</th>
              <td>${uaInfo.password_hint}</td>
            </tr>
            <tr>
              <th>LM Hash</th>
              <td>${uaInfo.lm_hash}</td>
            </tr>
            <tr>
              <th>LTLM Hash</th>
              <td>${uaInfo.ntlm_hash}</td>
            </tr>
            <tr>
              <th>Backup Flag</th>
              <td>${uaInfo.backup_flag}</td>
            </tr>
          </tbody>
        </table>
        </c:forEach>
      </c:forEach>
      </article>
    </section>
  </div>
  </c:forEach>
    
</body>
</html>