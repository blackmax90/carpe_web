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
</head>
<body>

	<!-- wrap -->
	<div class="wrap usage-m bg-theme blue">

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
					2Depth Menu Class : 1Depth Menu = unselected 상태일 경우에는 class="hide" // 2019-10-20 추가
				//-->
				<ul>
					<li><a href="/carpe/overview.do" class="icon overview">Overview</a></li>
					<li><a href="/carpe/evdnc.do" class="icon evidence">Evidence</a></li>
					<li><a href="#" class="icon analysis">Analysis</a></li>
						<!-- 2Depth Menu //-->
						<li class="level02 hide"><a href="#">Filesystem</a></li> 
						<li class="level02 hide"><a href="#">Artifact</a></li>
						<li class="level02 hide"><a href="#">String Search</a></li>
						<!--// 2Depth Menu -->
					<li><a href="/carpe/carving.do" class="icon recovery">Recovery</a></li>	
					<li class="on"><a href="/carpe/communication.do" class="icon visualization">Visualization</a></li>						
						<!-- 2Depth Menu //-->
						<li class="level02"><a href="/carpe/timeline_chart.do">Timeline</a></li>
						<li class="level02"><a href="/carpe/communication.do">Communication</a></li> 
						<li class="level02 on"><a href="/carpe/usage.do">Usage history</a></li>
						<li class="level02"><a href="/carpe/gps.do">Location map</a></li>
						<!--// 2Depth Menu -->
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
				<h4 class="blind">Usage History Month</h4>
				<!--// Content 영역 //-->
				<div id="jqxSplitter" class="content-box">
					<div class="content-area">
						<div class="tit-area">
							<h3>
								2019년 
								<span class="hide">7월</span>								
							</h3>
							<div class="select">
								<select name="" id="">
									<option value="1월">1월</option>
									<option value="2월">2월</option>
									<option value="3월">3월</option>
									<option value="4월">4월</option>
									<option value="5월">5월</option>
									<option value="6월">6월</option>
									<option value="7월" selected="selected">7월</option>
									<option value="8월">8월</option>
									<option value="9월">9월</option>
									<option value="10월">10월</option>
									<option value="11월">11월</option>
									<option value="12월">12월</option>
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
																<option value="01:00">01:00</option>
																<option value="02:00">02:00</option>
																<option value="03:00">03:00</option>
																<option value="04:00">04:00</option>
																<option value="05:00">05:00</option>
																<option value="06:00">06:00</option>
																<option value="07:00">07:00</option>
																<option value="08:00">08:00</option>
																<option value="09:00" selected>09:00</option>
																<option value="10:00">10:00</option>
																<option value="11:00">11:00</option>
																<option value="12:00">12:00</option>
																<option value="13:00">13:00</option>
																<option value="14:00">14:00</option>
																<option value="15:00">15:00</option>
																<option value="16:00">16:00</option>
																<option value="17:00">17:00</option>
																<option value="18:00">18:00</option>
																<option value="19:00">19:00</option>
																<option value="20:00">20:00</option>
																<option value="21:00">21:00</option>
																<option value="22:00">22:00</option>
																<option value="23:00">23:00</option>
																<option value="00:00">00:00</option>
															</select>
														</div>
													</dd>
												</dl>
												<dl>
													<dt>업무종료</dt>
													<dd>
														<div class="select">
															<select name="setTimeOff" id="end_time">
																<option value="01:00">01:00</option>
																<option value="02:00">02:00</option>
																<option value="03:00">03:00</option>
																<option value="04:00">04:00</option>
																<option value="05:00">05:00</option>
																<option value="06:00">06:00</option>
																<option value="07:00">07:00</option>
																<option value="08:00">08:00</option>
																<option value="09:00">09:00</option>
																<option value="10:00">10:00</option>
																<option value="11:00">11:00</option>
																<option value="12:00">12:00</option>
																<option value="13:00">13:00</option>
																<option value="14:00">14:00</option>
																<option value="15:00">15:00</option>
																<option value="16:00">16:00</option>
																<option value="17:00">17:00</option>
																<option value="18:00" selected>18:00</option>
																<option value="19:00">19:00</option>
																<option value="20:00">20:00</option>
																<option value="21:00">21:00</option>
																<option value="22:00">22:00</option>
																<option value="23:00">23:00</option>
																<option value="00:00">00:00</option>
															</select>
														</div>
													</dd>
												</dl>
											</div><!--// content-box -->
									</div><!-- // pop-content end -->
								</div><!-- // pop-up end -->
						</div>
						<div id="jqxGrid_Systemlog" role="grid" class="cont-result ofy-auto" style="width: calc(100% - 4rem); height:calc(100% - 8rem);"><!-- // Table 영역 // -->
							<!--// Table Sample - Size Check //-->
							<table class="tbl-grid tbl-data-check ">
								<colgroup>
									<col width="*"/>
								</colgroup>
								<thead>
									<tr>
										<th></th>
										<th style="cursor:pointer" onClick="dayMove('1');">1</th>
										<th style="cursor:pointer" onClick="dayMove('2');">2</th>
										<th style="cursor:pointer" onClick="dayMove('3');">3</th>
										<th style="cursor:pointer" onClick="dayMove('4');">4</th>
										<th style="cursor:pointer" onClick="dayMove('5');">5</th>
										<th style="cursor:pointer" onClick="dayMove('6');">6</th>
										<th style="cursor:pointer" onClick="dayMove('7');">7</th>
										<th style="cursor:pointer" onClick="dayMove('8');">8</th>
										<th style="cursor:pointer" onClick="dayMove('9');">9</th>
										<th style="cursor:pointer" onClick="dayMove('10');">10</th>
										<th style="cursor:pointer" onClick="dayMove('11');">11</th>
										<th style="cursor:pointer" onClick="dayMove('12');">12</th>
										<th style="cursor:pointer" onClick="dayMove('13');">13</th>
										<th style="cursor:pointer" onClick="dayMove('14');">14</th>
										<th style="cursor:pointer" onClick="dayMove('15');">15</th>
										<th style="cursor:pointer" onClick="dayMove('16');">16</th>
										<th style="cursor:pointer" onClick="dayMove('17');">17</th>
										<th style="cursor:pointer" onClick="dayMove('18');">18</th>
										<th style="cursor:pointer" onClick="dayMove('19');">19</th>
										<th style="cursor:pointer" onClick="dayMove('20');">20</th>
										<th style="cursor:pointer" onClick="dayMove('21');">21</th>
										<th style="cursor:pointer" onClick="dayMove('22');">22</th>
										<th style="cursor:pointer" onClick="dayMove('23');">23</th>
										<th style="cursor:pointer" onClick="dayMove('24');">24</th>
										<th style="cursor:pointer" onClick="dayMove('25');">25</th>
										<th style="cursor:pointer" onClick="dayMove('26');">26</th>
										<th style="cursor:pointer" onClick="dayMove('27');">27</th>
										<th style="cursor:pointer" onClick="dayMove('20');">28</th>
										<th style="cursor:pointer" onClick="dayMove('29');">29</th>
										<th style="cursor:pointer" onClick="dayMove('30');">30</th>
										<th style="cursor:pointer" onClick="dayMove('31');">31</th>
									</tr>
								</thead>
								<tbody id="usage_body">								
								</tbody>
							</table>
						</div>
					</div>
					<div class="aside">
						<div class="tit-area">
							<h3><span>7월</span> 통계결과</h3>
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
	function dayMove(day) {
		
		location.href = '/carpe/usage_day.do?year=' + ${year} + '&month=' + ${month} + '&day=' + day;
	}
	
	function getData() {
		$.ajax({
			url: "/carpe/usage_month_list.do",
	        dataType:'json',
	        data: { year : '2019'
	        	   ,month : '07'
	        	  },
	        async:false,
	        contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
	        success:function(data){		        	
	        	dataRender(data);
	        }
	    });
	}
	
	function dataRender(data) {				
		var list = "";
		var regtime = ""; 
		var nightCnt = 0;
		var workCnt = 0;		
		var nightDayArr = {};
		for(var i = 0; i < data.list.length; i++) {						
			regTime = data.list[i].regtime;						
			var tmpArr = {};
			tmpArr[1] = data.list[i].day1;
			tmpArr[2] = data.list[i].day2;
			tmpArr[3] = data.list[i].day3;
			tmpArr[4] = data.list[i].day4;
			tmpArr[5] = data.list[i].day5;
			tmpArr[6] = data.list[i].day6;
			tmpArr[7] = data.list[i].day7;
			tmpArr[8] = data.list[i].day8;
			tmpArr[9] = data.list[i].day9;
			tmpArr[10] = data.list[i].day10;
			tmpArr[11] = data.list[i].day11;
			tmpArr[12] = data.list[i].day12;
			tmpArr[13] = data.list[i].day13;
			tmpArr[14] = data.list[i].day14;
			tmpArr[15] = data.list[i].day15;
			tmpArr[16] = data.list[i].day16;
			tmpArr[17] = data.list[i].day17;
			tmpArr[18] = data.list[i].day18;
			tmpArr[19] = data.list[i].day19;
			tmpArr[20] = data.list[i].day20;
			tmpArr[21] = data.list[i].day21;
			tmpArr[22] = data.list[i].day22;
			tmpArr[23] = data.list[i].day23;
			tmpArr[24] = data.list[i].day24;
			tmpArr[25] = data.list[i].day25;
			tmpArr[26] = data.list[i].day26;
			tmpArr[27] = data.list[i].day27;
			tmpArr[28] = data.list[i].day28;
			tmpArr[29] = data.list[i].day29;
			tmpArr[30] = data.list[i].day30;
			tmpArr[31] = data.list[i].day31;
										
			list += "\n                  <tr> ";
			list += "\n										<th>" + regTime + "</th> ";			
			for (var f=1; f<= 31; f++) {				
				if (tmpArr[f] == 1) {
					list += "\n										<td class=\"ing on\"></td> ";
					//workCnt ++;
				} else if (tmpArr[f] == 2) {
					if (regTime < $("#start_time").val()) {						
						list += "\n										<td class=\"over\"></td> ";						
						nightCnt ++;						
						nightDayArr[f] = 1;
					} else if (regTime > $("#end_time").val()) {
						list += "\n										<td class=\"over\"></td> ";						
						nightDayArr[f] = 1;
						nightCnt ++;						
					} else {
						list += "\n										<td class=\"ing\"></td> ";
						workCnt ++;
					} 
				} else {
					list += "\n										<td></td> ";	
				}
			}
			list += "\n                  </tr> ";			
		}
		$("#usage_body").html(list);
		$("#nightCnt").html(nightCnt);
		$("#workCnt").html(workCnt);
		$("#nightDay").html(Object.keys(nightDayArr).length);		
	}
	
	(function($) {
		$(document).ready(function() {
			// splitter
			$('#jqxSplitter').jqxSplitter({ width: '100%', height: '100%', panels: [{ min: 300, size: '70%' }, { min: 200 }] });		
			
			getData();
		    $('#show_time_set').click(function(){
		    	  $("#time_set").show();
		    });
			
			$('#close_time_set').click(function(){
		    	  $("#time_set").hide();
		    });

			$('#start_time').change(function() {
				if ($("#start_time").val() > $("#end_time").val()) {
					alert('업무 시작시간이 업무 종료시간보다 늦은 시각입니다.\n 시간값을 확인해 주세요');
					return;
				}
				getData();
			});
			$('#end_time').change(function() {
				if ($("#start_time").val() > $("#end_time").val()) {
					alert('업무 종료시간이 업무 시작시간보다 빠른 시각입니다.\n 시간값을 확인해 주세요');
					return;
				}
				getData();
			});
		});
	})(jQuery);
	</script>
	<!-- // 현재 페이지에 필요한 js -->

</body>
</html>