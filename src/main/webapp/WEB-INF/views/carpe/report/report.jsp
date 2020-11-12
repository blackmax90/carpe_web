<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/core.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/charts.js"></script>
  <script src="/carpe/resources/amcharts_4.5.3/amcharts4/themes/animated.js"></script>
</head>
<body>

  <!-- wrap -->
  <div class="wrap report bg-theme blue">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>

    <!-- // header -->

    <!-- nav -->
   <c:import url="../common/left_nav.jsp">
      <c:param name="d1" value="report"></c:param>
      <c:param name="d2" value=""></c:param>
    </c:import>
    <!-- // nav -->

    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : ${caseName}</h3>
        <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
        <c:import url="../common/location_area.jsp">
          <c:param name="d1" value="report"></c:param>
          <c:param name="d2" value=""></c:param>
        </c:import>
      </section>

      <article class="container">
        <aside id="jqxpanel" class="content-area bg-unit">
          <iframe name="reportFrame" src="/carpe/report_view.do" width="100%" height="100%" border="0"></iframe>
        </aside>
        <div class="content-area bg-unit">  
          <h3>Current Info</h3>
          <p>Case Name : ${caseName}</p>
          <p>Administrator : ${administrator}</p>
          <p>Create Date : ${createDate}</p>
          <p>Description : ${desc}</p>
          <p>Case State : ${procStat}</p>
<!--           <p>Last analysis Time : - </p> -->
          <p># of Evidence : ${evidenceCnt}</p>
          <p># of members : ${caseUserCnt}</p>
<!--           <h3>Case User</h3> -->
<%--           <c:forEach items="${caseUserList }" var="userList"> --%>
<%--             <p>${userList.id }</p> --%>
<%--           </c:forEach> --%>
        </div>
        <div class="content-area bg-unit">
          <h3>Report</h3>
          <div class="cont-result">
            <div class="report_info">
                <div class="checkbox checkbox-type-1">
                  <input id="analysis_info" name="analysis_info" type="checkbox" readonly="readonly" />
                  <label for="analysis_info"><span class="text">기본 분석 정보</span></label>
                </div>
            </div>
            <div class="btn-area">
              <ul>
                <li>
                  <button type="button" class="btn-case-01" id="btnPrint"><span class="icon ico-export">Report Print</span></button>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </article>
    </main>
    <!-- // main -->

  </div>
  <!-- // wrap -->
  <!-- 현재 페이지에 필요한 js -->
  <script>
  $(document).ready(function() {
    $("#btnPrint").click(function() {
      window.frames["reportFrame"].focus();
      window.frames["reportFrame"].print();
    });

    $("#analysis_info").jqxCheckBox({ width: 28, height: 28, checked: true, disabled: true });
  });
  </script>
<!-- // 현재 페이지에 필요한 js -->

</body>
</html>
