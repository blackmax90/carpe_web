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
  <style type="text/css">
  th.holiday, td.holiday {
    background-color: rgba(255, 0, 0, 0.08)
  }
  </style>
</head>
<body>

  <!-- wrap -->
  <div class="wrap usage-m bg-theme blue">

    <!-- header -->
    <%@ include file="../common/header.jsp" %>
    <!-- // header -->

    <!-- nav -->
		<c:import url="../common/left_nav.jsp">
		  <c:param name="d1" value="visualization"></c:param>
		  <c:param name="d2" value="usagehistory"></c:param>
		</c:import>
    <!-- // nav -->

    <!-- main -->
    <main class="main">
      <section class="tit-area">
        <h3>Current Case : <%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></h3>
        <a href="/carpe/case.do"><button type="button" class="btn-transparent icon ico-case-out"><span>case out</span></button></a>
      </section>
      <article class="container">
        <h4 class="blind">Usage History Month</h4>
        <!--// Content 영역 //-->
        <div id="jqxSplitter" class="content-box">
          <div class="content-area">
            <div class="tit-area">
              <h3 class="unit">
                ${year}년 
              </h3>
              <div class="select">
                <select name="" id="selMonth">
                  <c:forEach var="i" begin="1" end="12">
                    <fmt:formatNumber var="monthStr" minIntegerDigits="2" value="${i}" type="number"/>
                    <option value="${monthStr}" <c:if test="${i == month}">selected</c:if> >${i}월</option>
                  </c:forEach>
                </select>
              </div>
              <ul>
                <li>
                  <button type="button" class="btn-case-01" id="show_time_set"><span class="icon ico-clock">업무시간</span></button>
                </li>
              </ul>
              <!-- pop-up // 업무시간 버튼 선택 시, 팝업 // -->
                <div id="time_set" class="pop wrap-pop jqx-window jqx-popup" style="position: absolute; top: 4rem; right:9rem; width: 21rem; height: auto; display:none;">
                  <div id="" class="pop-header jqx-window-header">
                    <h1>업무시간 설정</h1>
                    <div class="jqx-window-close-button-background">
                      <div class="jqx-window-close-button jqx-icon-close" id="close_time_set"></div>
                    </div>
                  </div>
                  <div id="" class="pop-content">
                      <!--// Content 영역 //-->
                      <div class="set-wtime">
                        <dl>
                          <dt>업무시작</dt>
                          <dd>
                            <div class="select">
                              <select name="setTimeOn" id="start_time">                                
                                <c:forEach var="i" begin="1" end="24">
                                  <fmt:formatNumber var="timeStr" minIntegerDigits="2" value="${i}" type="number"/>
                                  <option value="${i}" <c:if test="${i == 9}">selected</c:if>>${timeStr}:00</option>
                                </c:forEach>
                              </select>
                            </div>
                          </dd>
                        </dl>
                        <dl>
                          <dt>업무종료</dt>
                          <dd>
                            <div class="select">
                              <select name="setTimeOff" id="end_time">
                                <c:forEach var="i" begin="1" end="24">
                                  <fmt:formatNumber var="timeStr" minIntegerDigits="2" value="${i}" type="number"/>
                                  <option value="${i}" <c:if test="${i == 18}">selected</c:if>>${timeStr}:00</option>
                                </c:forEach>
                              </select>
                            </div>
                          </dd>
                        </dl>
                      </div><!--// content-box -->
                  </div><!-- // pop-content end -->
                </div><!-- // pop-up end -->
            </div>
            <div id="jqxGrid_Systemlog" role="grid" class="cont-result" style="width: calc(100% - 4rem); height:calc(100% - 8rem);"><!-- // Table 영역 // -->
              <!--// Table Sample - Size Check //-->
              <table class="tbl-grid tbl-data-check ">
                <colgroup>
                  <col width="*"/>
                </colgroup>
                <thead>
                  <tr>
                    <th></th>
                    <c:forEach var="i" begin="1" end="31">
                      <fmt:formatNumber var="monthStr" minIntegerDigits="2" value="${i}" type="number"/>
                      <th style="cursor:pointer" onClick="dayMove('${i}');" id="tr_${monthStr}">${i}</th>
                    </c:forEach>
                  </tr>
                </thead>
                <tbody id="usage_body">
                </tbody>
              </table>
            </div>
          </div>
          <div class="aside">
            <div class="tit-area">
              <h3 class="unit"><span>7월</span> 통계결과</h3>
            </div>
            <div id="ContentPanel" class="aside-result">
              <!--// Content 영역 //-->
              <div class="statistical-result">
                <dl>
                  <dt>야근일수</dt>
                  <dd><strong id="nightDay"></strong>일 / <span>31</span>일</dd>
                </dl>
                <dl>
                  <dt>업무시간</dt>
                  <dd><strong id="workCnt"></strong>시간 / <span>272(270)</span>시간</dd>
                </dl>
                <dl>
                  <dt>업무시간 이외시간</dt>
                  <dd><strong id="nightCnt"></strong>시간 / <span>465(450)</span>시간</dd>
                </dl>
              </div>
              <div class="info-box">
                <ul>
                  <li>272(270) = 31(30) X 9 (업무시간)</li>
                  <li>465(450) = 31(30) X 15 (비업무시간)</li>
                </ul>
              </div>
            </div>
          </div>
        </div><!-- Content 영역 //-->
      </article>
    </main>
    <!-- // main -->
  </div>
  <!-- // wrap -->
  <!-- 현재 페이지에 필요한 js -->
  <script>
  var currData;

  function dayMove(day) {
    location.href = '/carpe/usage_day.do?year=' + ${year} + '&month=' + ${month} + '&day=' + day;
  }
  
  function getData() {
    $.ajax({
      url: "/carpe/usage_month_list.do",
      dataType:'json',
      data: {
        year : ${year},
        month : $("#selMonth").val()
      },
      async:false,
      contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
      success:function(data) {
         currData = data;
         dataRender(data);
      }
    });
  }
  
  function dataRender(data) {        
    var list = "";
    var regTime = 0; 
    var nightCnt = 0;
    var workCnt = 0;    
    var nightDayArr = {};
    var dataArr = new Array(24);
    var sIdx = new Array(31);   //시작시간
    var eIdx = new Array(31);   //종료시간

    for (var h = 0; h < dataArr.length; h++) {
      dataArr[h] = new Array(31);
    }

    //데이터 정렬
    for (var h = 0; h < data.list.length; h++) {
      for (var d = 0; d < 31; d++) {
        dataArr[h][d] = data.list[h]["day" + (d + 1)];

        if (dataArr[h][d] > 0) {
          if (sIdx[d] == undefined) {
            sIdx[d] = h;
          } else {
            eIdx[d] = h;
          }
        }
      }
    }

    for (var h = 0; h < dataArr.length; h++) {        
      var time = "";

      if (h + 1 < 10) {
        time = "0";
      }

      time += (h + 1) + ":00";
      regTime = h + 1;

      list += "\n                  <tr> ";
      list += "\n                    <th>" + time + "</th> ";      

      for (var d = 0; d < dataArr[h].length; d++) {        
        var dayStr = d + 1;

        if (dayStr < 10) {
            dayStr = "0" + dayStr;
        }

        if (dataArr[h][d] > 0) {
          if (regTime < parseInt($("#start_time").val()) ||
              regTime > parseInt($("#end_time").val())) {
            nightCnt++;            
            nightDayArr[d] = 1;
          } else {
            workCnt++;
          }
        }
        
        if (dataArr[h][d] == 2) {
          list += "\n                    <td class=\"ing on\"><span></span></td> ";
        } else if (dataArr[h][d] == 3) {
          list += "\n                    <td class=\"ing off\"><span></span></td> ";
        } else if (dataArr[h][d] == 4) {
          list += "\n                    <td class=\"ing onoff\"><span></span></td> ";
        } else if (dataArr[h][d] == 1) {
          if (regTime < parseInt($("#start_time").val()) ||
              regTime > parseInt($("#end_time").val())) {
            list += "\n                    <td class=\"over\"></td> ";            
          } else {
            list += "\n                    <td class=\"ing\"></td> ";
          }
        } else {
          list += "\n                    <td id=\"td_" + dayStr + "\"></td> ";
        }
      }

      list += "\n                  </tr> ";
    }

    $("#usage_body").html(list);
    $("#nightCnt").html(nightCnt);
    $("#workCnt").html(workCnt);
    $("#nightDay").html(Object.keys(nightDayArr).length);    

    changeHoliday(data.spcdeList);
  }

  //휴일 셋팅
  function changeHoliday(list) {
	  $("[id^='tr_']").removeClass("holiday");

	  for (var i = 0; i < list.length; i++) {
		  if (list[i].isHoliday != "Y") {
			  continue;
			}

		  var d = list[i].locdate.substr(6, 2);
		  console.log(d + ", " + list[i].dateName);
		  $("#tr_" + d).addClass("holiday");
		  $("[id='td_" + d + "']").addClass("holiday");
		}

		for (var i = 1; i <= 31; i++) {
			var dayStr = i;

			if (dayStr < 10) {
				dayStr = "0" + dayStr;
			}

			var d = ${year} + "-" + $("#selMonth").val() + "-" + dayStr;
			var dow = new Date(d).getDay();

			if (dow == 0 || dow == 6) {
		    $("#tr_" + dayStr).addClass("holiday");
		    $("[id='td_" + dayStr + "']").addClass("holiday");
			}
		}
	}
  
  (function($) {
    $(document).ready(function() {
      getData();

      // splitter
      $('#jqxSplitter').jqxSplitter({
        width: '100%', 
        height: '100%', 
        panels: [{ 
          min: 300, 
          size: '70%' 
        }, 
        {
          min: 200
        }]
      });    
      
      $('#show_time_set').click(function(){
        $("#time_set").show();
      });
      
      $('#close_time_set').click(function(){
        $("#time_set").hide();
      });

      $('#start_time').change(function() {
        if (parseInt($("#start_time").val()) > parseInt($("#end_time").val())) {
          alert('업무 시작시간이 업무 종료시간보다 늦은 시각입니다.\n 시간값을 확인해 주세요');
          return;
        }

        dataRender(currData);
      });

      $('#end_time').change(function() {
        if (parseInt($("#start_time").val()) > parseInt($("#end_time").val())) {
          alert('업무 종료시간이 업무 시작시간보다 빠른 시각입니다.\n 시간값을 확인해 주세요');
          return;
        }

        dataRender(currData);
      });

      $("#selMonth").change(function() {
          getData();
      });
    });
  })(jQuery);
  </script>
  <!-- // 현재 페이지에 필요한 js -->

</body>
</html>