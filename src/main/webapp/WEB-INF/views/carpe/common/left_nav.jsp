<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
		<nav class="nav bg-unit">
			<div class="bg-img-nav">
        <c:set var="d1" value="${param.d1}" />
        <c:set var="d2" value="${param.d2}" />
				<!--//
					목록 추가는 <li> 생성
					1Depth Menu class : 없음
					2Depth Menu class="level02"
					1Depth/2Depth Selected class="on"
					2Depth Menu Class : 1Depth Menu = unselected 상태일 경우에는 class="hide" // 2019-10-20 추가
				//-->
				<ul>
					<li class="<c:if test="${d1 eq 'overview'}">on</c:if>"><a href="/carpe/overview.do" class="icon overview">Overview</a></li>
					<li class="<c:if test="${d1 eq 'evidence'}">on</c:if>"><a href="/carpe/evdnc.do" class="icon evidence">Evidence</a></li>
					<li class="<c:if test="${d1 eq 'analysis'}">on</c:if>"><a href="/carpe/filesystem.do" class="icon analysis">Analysis</a></li>
            <c:set var="hideClass" value="" />
            <c:if test="${d1 ne 'analysis'}"><c:set var="hideClass" value="hide" /></c:if>
						<!-- 2Depth Menu //-->
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'filesystem'}">on</c:if>"><a href="/carpe/filesystem.do">Filesystem</a></li> 
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'artifact'}">on</c:if>"><a href="/carpe/artifact.do">Artifact</a></li>
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'stringsearch'}">on</c:if>"><a href="/carpe/search.do">String Search</a></li>
						<!--// 2Depth Menu -->
					<li class="<c:if test="${d1 eq 'recovery'}">on</c:if>"><a href="/carpe/carving.do" class="icon recovery">Recovery</a></li>						
            <c:set var="hideClass" value="" />
            <c:if test="${d1 ne 'recovery'}"><c:set var="hideClass" value="hide" /></c:if>
<%-- 						<li class="level02 ${hideClass} <c:if test="${d2 eq 'deletedfiles'}">on</c:if>"><a href="/carpe/carving.do">Deleted Files</a></li> --%>
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'filecarving'}">on</c:if>"><a href="/carpe/carving.do">File Carving</a></li>
<%-- 						<li class="level02 ${hideClass} <c:if test="${d2 eq 'recordcarving'}">on</c:if>"><a href="/carpe/carving.do">Record Carving</a></li> --%>
					<li class="<c:if test="${d1 eq 'visualization'}">on</c:if>"><a href="/carpe/communication.do" class="icon visualization">Visualization</a></li>						
            <c:set var="hideClass" value="" />
            <c:if test="${d1 ne 'visualization'}"><c:set var="hideClass" value="hide" /></c:if>
						<!-- 2Depth Menu //-->
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'timeline'}">on</c:if>"><a href="/carpe/timeline/timeline_chart.do">Timeline</a></li>
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'communication'}">on</c:if>"><a href="/carpe/communication.do">Communication</a></li> 
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'usagehistory'}">on</c:if>"><a href="/carpe/usage.do">Usage history</a></li>
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'locationmap'}">on</c:if>"><a href="/carpe/gps/gps.do">Location map</a></li>
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'recyclebin'}">on</c:if>"><a href="/carpe/recyclebin/recyclebin.do">RecycleBin History</a></li>
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'apphistory'}">on</c:if>"><a href="/carpe/application/application.do">App History</a></li>
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'mfthistory'}">on</c:if>"><a href="/carpe/mft/mfthistory.do">MFT History</a></li>
						<li class="level02 ${hideClass} <c:if test="${d2 eq 'ntfsloghistory'}">on</c:if>"><a href="/carpe/ntfs/ntfsloghistory.do">NTFS Log History</a></li>
						<!--// 2Depth Menu -->
<%-- 					<li class="<c:if test="${d1 eq 'report'}">on</c:if>"><a href="#" class="icon report">Report</a></li> --%>
				</ul>
			</div>
		</nav>
