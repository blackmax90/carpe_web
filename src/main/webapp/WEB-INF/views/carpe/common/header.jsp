<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <c:set var="ADMIN_GRADE" value="<%=Consts.ADMIN_GRADE%>"/>
		<header class="header">
			<a href="/carpe/case.do"><h1 class="logo ir">CARPE</h1></a>
			<h2><strong>Digial Forensic Platform ver.0.1.0</strong></h2>
			<section class="top bg-unit">
				<ul>
        <c:if test="${userInfo.grade == ADMIN_GRADE}">
					<li><a href="/carpe/config/config.do" class="icon setting"><span class="ir">Config</span></a></li>
        </c:if>
					<li><a href="#" class="icon noti new"><span class="ir">알림</span></a></li>
					<li><a href="#" class="icon email new text-ellipsis"><span>${userInfo.email}</span></a></li>
					<li><a href="/carpe/logout.do" class="icon logout"><span>LOGOUT</span></a></li>
				</ul>
			</section>
		</header>
