<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>지도</title>
<link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=cef6cb47be07d53310c6414a32217460"></script>

</head>

<body>
    <div id="map" style="width:100%;height:400px;"></div>
	<p><button id="btnSetBounds">지도 범위 재설정 하기</button></p>

<script>
(function($) {
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
		level: 3 // 지도의 확대 레벨
	};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 버튼을 클릭하면 아래 배열의 좌표들이 모두 보이게 지도 범위를 재설정합니다
	var points = [
		new kakao.maps.LatLng(33.452278, 126.567803),
		new kakao.maps.LatLng(33.452671, 126.574792),
		new kakao.maps.LatLng(33.451744, 126.572441)
	];
	
	// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
	var bounds = new kakao.maps.LatLngBounds();
	
	var i, marker;
	for (i = 0; i < points.length; i++) {
		// 배열의 좌표들이 잘 보이게 마커를 지도에 추가합니다
		marker = new kakao.maps.Marker({ title: "장소-" + (i+1) , position : points[i] });
		marker.setMap(map);
	
		// LatLngBounds 객체에 좌표를 추가합니다
		bounds.extend(points[i]);
	}
	
	$('#btnSetBounds').click(function(e) {
		// LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
		// 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
		map.setBounds(bounds);
	});

})(jQuery);

</script>

</body>
</html>