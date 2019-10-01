<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Time Line</title>

<link href="/carpe/resources/eventdrops/style.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="/carpe/resources/eventdrops/d3.min.js"></script>
<script type="text/javascript" src="/carpe/resources/eventdrops/event-drops.js"></script>
</head>

<body>
	<h1>Event Drops Demo</h1>
	<div id="events" style="width: 90%;"></div>
	<p class="infos">
	    <span id="numberCommits"></span>개 이벤트  <span class="light">발생됨</span> <br />
	    <span id="zoomStart"></span> <span class="light"> ~ </span> <span id="zoomEnd"></span>
	</p>

	<footer>
	</footer>
</body>

<script>
var global = window;

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();

	if (n.length < digits) {
		for (i = 0; i < digits - n.length; i++)
		zero += '0';
	}

	return zero + n;
}

function getTimeStamp(d) {
	var s =
	leadingZeros(d.getFullYear(), 4) + '-' +
	leadingZeros(d.getMonth() + 1, 2) + '-' +
	leadingZeros(d.getDate(), 2) + ' ' +

	leadingZeros(d.getHours(), 2) + ':' +
	leadingZeros(d.getMinutes(), 2) + ':' +
	leadingZeros(d.getSeconds(), 2);

	return s;
}

const numberCommitsContainer = document.getElementById('numberCommits');
const zoomStart = document.getElementById('zoomStart');
const zoomEnd = document.getElementById('zoomEnd');

const updateCommitsInformation = chart => {
    const filteredData = chart
        .filteredData()
        .reduce((total, repo) => total.concat(repo.data), []);

    numberCommitsContainer.textContent = filteredData.length;
    zoomStart.textContent = getTimeStamp(chart.scale().domain()[0]);
    zoomEnd.textContent = getTimeStamp(chart.scale().domain()[1]);
};

var repositoriesData;

$.ajax({
	type: "POST",
	url: "/carpe/timeline_list.do",
	async: false,
	success: function (data, textStatus, jqXHR) {
		repositoriesData = data["list"]
	},
	error: function (jqXHR, textStatus, errorThrown) {
		alert(errorThrown);
	}
});
   
var krLocale = {
  dateTime: "%Y/%m/%d %a %X",
  date: "%Y/%m/%d",
  time: "%H:%M:%S",
  periods: ["오전", "오후"],
  days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
  shortDays: ["일", "월", "화", "수", "목", "금", "토"],
  months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
  shortMonths: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
}

var tooltip = d3
    .select('body')
    .append('div')
    .classed('tooltip', true)
    .style('opacity', 0)
    .style('pointer-events', 'auto');

var chart = eventDrops({
	d3,
	locale: krLocale,
	zoom: {
        onZoomEnd: () => updateCommitsInformation(chart),
    },
    /*range: {
		start: new Date('01/01/2016 12:00:00 AM'),
    	end: new Date('12/31/2016 12:59:59 PM')
  	},*/
	range: {
	start: new Date('01/01/2016 12:00:00 AM'),
	end: new Date('11/16/2016 12:59:59 PM')
	},
  	drop: {
	  	date: d => new Date(d.date),
		onMouseOver: data => {
			tooltip
                .transition()
                .duration(200)
                .style('opacity', 1)
                .style('pointer-events', 'auto');

			tooltip.html('<div class="content"><h3 class="message">' + data.cnt + '</h3></div>')
                .style('left', d3.event.pageX - 30 + 'px')
                .style('top', d3.event.pageY + 20 + 'px');
        },
        onMouseOut: () => {
            tooltip
                .transition()
                .duration(500)
                .style('opacity', 0)
                .style('pointer-events', 'none');
        },
  	},
	axis: {
        formats: {
            milliseconds: '%L',
            seconds: ':%S',
            minutes: '%I:%M',
            //hours: '%I %p',
            hours: '%H',
            days: '%d(%a)',
            weeks: '%b %d',
            months: '%B',
            year: '%Y',
		},
    },
	bound: {
        format: d3.timeFormat('%Y-%m-%d'),
    },
});

d3.select('#events').data([repositoriesData]).call(chart);

updateCommitsInformation(chart);
</script>
</html>
