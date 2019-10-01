<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>File Name - Word Cloud</title>
<link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>

<script src="/carpe/resources/amcharts_4.5.3/amcharts4/core.js"></script>
<script src="/carpe/resources/amcharts_4.5.3/amcharts4/charts.js"></script>
<script src="/carpe/resources/amcharts_4.5.3/amcharts4/themes/animated.js"></script>
<script src="index.js"></script>

<style>
	body {
	  font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
	  background-color: #ffffff;
	  overflow: hidden;
	  margin: 0;
	}

	#chartdiv {
	  width: 100%;
	  max-height: 600px;
	  height: 100vh;
	}
</style>

</head>

<body>
    <div id="chartdiv"></div>

<script>
(function($) {
	$(document).ready(function() {
		am4core.useTheme(am4themes_animated);
		var chart = am4core.create("chartdiv", am4charts.TreeMap);
		chart.layoutAlgorithm = chart.squarify;
		chart.dataFields.value = "value";
		chart.dataFields.name = "name";

		var bgColor = new am4core.InterfaceColorSet().getFor("background");

		var level1SeriesTemplate = chart.seriesTemplates.create("0");
		var level1ColumnTemplate = level1SeriesTemplate.columns.template;
		level1SeriesTemplate.tooltip.animationDuration = 0;
		level1SeriesTemplate.strokeOpacity = 1;
		level1ColumnTemplate.column.cornerRadius(10, 10, 10, 10)
		level1ColumnTemplate.fillOpacity = 1;
		level1ColumnTemplate.strokeWidth = 4;
		level1ColumnTemplate.stroke = bgColor;
		var bullet1 = level1SeriesTemplate.bullets.push(new am4charts.LabelBullet());
		bullet1.locationY = 0.5;
		bullet1.locationX = 0.5;
		bullet1.label.text = "{name}";
		bullet1.label.fill = am4core.color("#ffffff");
		bullet1.label.fontSize = 12;

		$.ajax({
			type: "POST",
			url: "/carpe/get_date_treemap.do",
			async: false,
			data: 'id=${id}',
			success: function (data, textStatus, jqXHR) {
				chart.data = data["list"]
			},
			error: function (jqXHR, textStatus, errorThrown) {
				alert(errorThrown);
			}
		});

/*		chart.data =  [{"name":"", "value":1},
		{"name":"1970-01-01", "value":1},
		{"name":"2011-04-19", "value":2},
		{"name":"2011-06-01", "value":2},
		{"name":"2012-09-26", "value":4},
		{"name":"2014-05-15", "value":231},
		{"name":"2016-11-24", "value":14},
		{"name":"2017-01-06", "value":100},
		{"name":"2017-05-04", "value":376},
		{"name":"2017-07-25", "value":4},
		{"name":"2017-10-30", "value":16},
		{"name":"2018-04-11", "value":18},
		{"name":"2018-04-12", "value":617},
		{"name":"2018-04-26", "value":75},
		{"name":"2018-07-13", "value":4},
		{"name":"2019-02-13", "value":18}
		];

		*/
	});
})(jQuery);

</script>

</body>
</html>