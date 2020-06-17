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
	<div class="wrap overview bg-theme blue">

		<!-- header -->
		<%@ include file="../common/header.jsp" %>
		<!-- // header -->

		<!-- nav -->
		<c:import url="../common/left_nav.jsp">
		  <c:param name="d1" value="overview"></c:param>
		  <c:param name="d2" value=""></c:param>
		</c:import>
		<!-- // nav -->

		<!-- main -->
		<main class="main">
			<section class="desc-area bg-unit">
				<h3>Current Case : ${caseName}</h3>
				<p>${desc}</p>
			</section>
			<article class="container">
				
				<aside id="jqxpanel" class="content-area bg-unit">
					<h3>Current Info</h3>
					<p>Case State : ${procStat}</p>
					<p>Last analysis Time : - </p>
					<p># of Evidence : ${evidenceCnt}</p>
					<p># of members : ${caseUserCnt}</p>
					<div id="jqxGrid_EvidenceList"></div>
<%-- 					<c:forEach items="${evidenceList }" var="evidenceList">
						
						<p>${evidenceList.evd_name }</p>
						<p>${evidenceList.evd_path }</p>
					</c:forEach> --%>
				</aside>
				<div class="content-area bg-unit">					
					<h3>Evidence별 파일 비율</h3>
					<%-- <p><fmt:formatNumber value="${logtimelineCnt }"/> 건 발견</p> --%>
					<div class="cont-result" id="chartDiv">
						<ul>
							<li>
								<div id="chartdiv-s2" class="chart-area">
									<!-- Chart 영역 //-->
								</div>
							</li>
							<li>
								<div id="chartdiv-s2" class="chart-area">
									<!-- Chart 영역 //-->
								</div>
							</li>
							<li>
								<div id="chartdiv-s3" class="chart-area">
									<!-- Chart 영역 //-->
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="content-area bg-unit">
					<h3>Case Log</h3>
					<c:forEach items="${caseUserList }" var="userList">
						<p>${userList.user_id }</p>
					</c:forEach>
				</div>
			</article>
		</main>
		<!-- // main -->

	</div>
	<!-- // wrap -->
	<!-- 현재 페이지에 필요한 js -->
	<script>
 	(function($) {
	    $(document).ready(function() {


            var evdList = new Array();
            <c:forEach items="${evidenceList}" var="evidence">
            	var obj = new Object();
            	obj.evd_id = "${evidence.evd_id}";
           		obj.evd_name = "${evidence.evd_name}";
           		obj.evd_path = "${evidence.evd_path}";
           		obj.sub_type = "${evidence.sub_type}";
           		obj.timezone = "${evidence.timezone}";
           		obj.acquired_date = "${evidence.acquired_date}";
           		obj.evd_md5 = "${evidence.evd_md5}";
           		obj.evd_sha1 = "${evidence.evd_sha1}";
           		obj.evd_sha3 = "${evidence.evd_sha3}";
           		obj.process_state = "${evidence.process_state}";
           		obj.par_id = "${evidence.par_id}";
           		obj.par_name = "${evidence.par_name}";
           		obj.par_size = (parseInt("${evidence.par_size}")/1024/1024/1024).toFixed(2)+"GB";
           		obj.sector_size = "${evidence.sector_size}";
           		obj.par_md5 = "${evidence.par_md5}";
           		obj.par_sha1 = "${evidence.par_sha1}";
           		obj.par_sha3 = "${evidence.par_sha3}";
           		obj.start_sector = "${evidence.start_sector}";
           		obj.filesystem = "${evidence.filesystem}";
           		obj.par_label = "${evidence.par_label}";
            	evdList.push(obj);
            </c:forEach>
            function getUniqueObjectArray(array, key) {
  			  var tempArray = [];
  			  for(var i = 0; i < array.length; i++) {
  			    var item = array[i]
  			    if(tempArray.indexOf(item[key]) == -1) {
  			    	tempArray.push(item[key]);
  			    } 
  			  }
  			  return tempArray;
  			}
            uniqueEvdIdList = getUniqueObjectArray(evdList, "evd_id");
            
            var resultArray = {};
            
            
            var tmp = "";
            for(var i = 0; i < uniqueEvdIdList.length; i++){
            	resultArray[uniqueEvdIdList[i]] = new Array();
            	/* tmp += "<table id='"+uniqueEvdIdList[i]+"'><td>partition name</td><td>partition label</td><td>capacity</td>"
            	+"<td>filesystem</td><td>start sector</td><td>sector size</td><td>sha1</td></table>"; */
            	tmp += "<h3>Partition information of "+uniqueEvdIdList[i]+"</h3><br><div id='"+uniqueEvdIdList[i]+"'></div><br>";
            }
            
            $('#jqxGrid_EvidenceList').append(tmp);

            for(var i=0; i < evdList.length; i++){
            	for(var j=0; j < uniqueEvdIdList.length; j++){
            		if(uniqueEvdIdList[j]==evdList[i]["evd_id"]){
            			resultArray[uniqueEvdIdList[j]].push(evdList[i]);
					}
            	}
            }
            console.log(resultArray);
            
            /*
            tmp = "";
            for(var i = 0; i < evdList.length; i++){
            	
            	tmp += "<tr>"
            	tmp += "<td>"+evdList[i].par_name+"</td>";
            	tmp += "<td>"+evdList[i].par_label+"</td>";
            	tmp += "<td>"+(((parseInt(evdList[i].par_size)/1024)/1024)/1024).toFixed(2)+"GB</td>";
            	tmp += "<td>"+evdList[i].filesystem+"</td>";
            	tmp += "<td>"+evdList[i].start_sector+"</td>";
            	tmp += "<td>"+evdList[i].sector_size+"</td>";
            	tmp += "<td>"+evdList[i].par_sha1+"</td>";
            	tmp += "</tr>"
           		$('#'+evdList[i].evd_id).append(tmp)
           	} */
            
            /* var tmp = "";
            for(var i = 0; i < uniqueEvdIdList.length; i++){
            	tmp += "<p id='"+uniqueEvdIdList[i]+"'><h3>"+uniqueEvdIdList[i]+"</h3></p></br>";
            }
            $('#jqxpanel').append(tmp);
            
            tmp = "";
            for(var i = 0; i < evdList.length; i++){
            	
            	tmp += "partition name: "+evdList[i].par_name+"</br>";
            	tmp += "filesystem: "+evdList[i].filesystem+"</br>";
            	tmp += "start sector: "+evdList[i].start_sector+"</br>";
            	tmp += "sector size: "+evdList[i].sector_size+"</br>";
            	tmp += "partition label: "+evdList[i].par_label+"</br>";
            	tmp += "capacity: "+(((parseInt(evdList[i].par_size)/1024)/1024)/1024).toFixed(2)+"GB</br>";
            	tmp += "acquired_date: "+evdList[i].acquired_date+"</br></br>";
            	
           		$('#'+evdList[i].evd_id).append(tmp)
           	} */
           	for(var i=0; i < uniqueEvdIdList.length; i++){
           		var source = {
                        localdata : resultArray[uniqueEvdIdList[i]],
                        datatype : 'array',
                        datafields :
                        [
                            {name: 'par_name'},
                            {name: 'filesystem'},
                            {name: 'start_sector'},
                            {name: 'par_label'},
                            {name: 'par_size'},
                            {name: 'acquired_date'}
                        ],
                        updaterow : function ( rowid, rowdata ) {
                            console.log(rowid + " : " + rowdata);
                        }
                    };
    			var columnSet = [
    				{text: 'par_name', dataField: 'par_name', width: '5%', cellsalign: 'cebter', align: 'center'},
                    {text: 'filesystem', dataField: 'filesystem', width: '30%', cellsalign: 'center', align: 'center'},
                    {text: 'start sector', dataField: 'start_sector', width: '10%', cellsalign: 'center', align: 'center'},
                    {text: 'partition label', dataField: 'par_label', width: '25%', cellsalign: 'center', align: 'center'},
                    {text: 'capacity', dataField: 'par_size', width: '10%', cellsalign: 'center', align: 'center'},
                    {text: 'acquired_date', dataField: 'acquired_date', width: '20%', cellsalign: 'center', align: 'center'}
    			];
               	var dataAdapter = new $.jqx.dataAdapter(source, {
                    //loadComplete : function (data) { alert("데이터 로드가 완료되었습니다.") },
                    //loadError : function (xhr, status, error) { alert("데이터를 로드할 수 없습니다."); }
                });

               	$("#"+uniqueEvdIdList[i]).jqxGrid({
                    width: 'calc(95% + 2rem)',
                    source: dataAdapter,
                    //selectionmode: 'checkbox', // 'none',
                    columnsresize: true,
                    autoheight: true,
                    //pagerheight: 0,
                    //pageable: true,
                    pagerrenderer: function() { return  ''; },
                    altrows: true,
                    //scrollbarsize: 12,
                    autoshowloadelement: true,
                    ready: function() {},
                    enablebrowserselection: true,
                    columnsresize: true,
                    columns: columnSet
                  });
           	}
           	
            $("#jqxpanel").jqxPanel({

            });
            $(".jqx-widget-content").css("background", "transparent");
	    });
	})(jQuery);
 	
	<!-- Chart code -->
	am4core.ready(function() {

	// Themes begin
	am4core.useTheme(am4themes_animated);
	am4core.options.commercialLicense = true;
	// Themes end

	// Create chart instance
	var chart = am4core.create("chartDiv", am4charts.PieChart);

	// Add data
	chart.data = [ {
	  "country": "Processing",
	  "litres": 7
	}, {
	  "country": "Complete",
	  "litres": 15
	}, {
	  "country": "Ready",
	  "litres": 5
	}];

	// Set inner radius
	chart.innerRadius = am4core.percent(50);

	// Add and configure Series
	var pieSeries = chart.series.push(new am4charts.PieSeries());
	pieSeries.dataFields.value = "litres";
	pieSeries.dataFields.category = "country";
	pieSeries.slices.template.stroke = am4core.color("#fff");
	pieSeries.slices.template.strokeWidth = 2;
	pieSeries.slices.template.strokeOpacity = 1;

	// This creates initial animation
	pieSeries.hiddenState.properties.opacity = 1;
	pieSeries.hiddenState.properties.endAngle = -90;
	pieSeries.hiddenState.properties.startAngle = -90;

	}); // end am4core.ready()
</script>
<!-- // 현재 페이지에 필요한 js -->

</body>
</html>