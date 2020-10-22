<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <style>
  .list-h a:hover {text-decoration: underline;}
  </style>

  <c:set var="d1" value="${param.d1}" />
  <c:set var="d2" value="${param.d2}" />
  <div class="location-area">
    <ul class="list-h">
      <li><a href="/carpe/case.do">Case</a></li>
      <c:if test="${d1 eq 'overview'}"><li><a href="/carpe/overview.do">Overview</a></li></c:if>
      <c:if test="${d1 eq 'evidence'}"><li><a href="/carpe/evdnc.do">Evidence</a></li></c:if>
      <c:if test="${d1 eq 'analysis'}"><li><a href="/carpe/filesystem.do">Analysis</a></li></c:if>
      <c:if test="${d1 eq 'recovery'}"><li><a href="/carpe/carving.do">Recovery</a></li></c:if>
      <c:if test="${d1 eq 'visualization'}"><li><a href="/carpe/communication.do">Visualization</a></li></c:if>
      <c:if test="${d1 eq 'report'}"><li><a href="#">Report</a></li></c:if>
      <c:if test="${d2 eq 'filesystem'}"><li><a href="/carpe/filesystem.do">Filesystem</a></li></c:if>
      <c:if test="${d2 eq 'artifact'}"><li><a href="/carpe/artifact.do">Artifact</a></li></c:if>
      <c:if test="${d2 eq 'stringsearch'}"><li><a href="/carpe/search.do">String Search</a></li></c:if>
      <c:if test="${d2 eq 'deletedfiles'}"><li><a href="/carpe/carving.do">Deleted Files</a></li></c:if>
      <c:if test="${d2 eq 'filecarving'}"><li><a href="/carpe/carving.do">File Carving</a></li></c:if>
      <c:if test="${d2 eq 'recordcarving'}"><li><a href="/carpe/carving.do">Record Carving</a></li></c:if>
      <c:if test="${d2 eq 'timeline'}"><li><a href="/carpe/timeline/timeline_chart.do">Timeline</a></li></c:if>
      <c:if test="${d2 eq 'communication'}"><li><a href="/carpe/communication.do">Communication</a></li></c:if>
      <c:if test="${d2 eq 'usagehistory'}"><li><a href="/carpe/usage.do">Usage history</a></li></c:if>
      <c:if test="${d2 eq 'locationmap'}"><li><a href="/carpe/gps/gps.do">Location map</a></li></c:if>
      <c:if test="${d2 eq 'recyclebin'}"><li><a href="/carpe/recyclebin/recyclebin.do">RecycleBin History</a></li></c:if>
      <c:if test="${d2 eq 'apphistory'}"><li><a href="/carpe/application/application.do">App History</a></li></c:if>
      <c:if test="${d2 eq 'mfthistory'}"><li><a href="/carpe/mft/mfthistory.do">MFT History</a></li></c:if>
      <c:if test="${d2 eq 'ntfsloghistory'}"><li><a href="/carpe/ntfs/ntfsloghistory.do">NTFS Log History</a></li></c:if>
    </ul>
  </div>
