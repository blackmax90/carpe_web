<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>File: ${fileName}</title>
<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
<link href="/carpe/resources/hexview/css.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/hexview/style.css" rel="stylesheet" type="text/css">
</head>

<body>
  <input type="hidden" id="id" name="id" value="${id}" >
  <input type="hidden" id="seq" name="seq" value="${seq}" >
<header>
  <div class="content">
  </div>
</header>
<div id="body">
  <h2>파일[${fileName}] HEX VIEW</h2>
  <pre>
    <div id="container" style="text-align: -webkit-center;">
      <table>
        <colgroup>
          <col style="15%">
          <col>
          <col style="15%">
        </colgroup>
        <tbody id="hexView">
        </tbody>
      </table>
    </div>
  </pre>
</div>
<footer>
	<div class="content">
	</div>
</footer>

<script>
var offset = 0;
var readFlag = false;
var FONT_SIZE = 16;
var PAGE_LINE = 500;
var PAGE_HEIGHT = FONT_SIZE * PAGE_LINE;
var fileLen = ${fileLen};
var initFlag = false;
var lastFunc = false;

$(document).ready(function() {
  init();

  if (fileLen > 0) {
    pageCheck();
  } else if (fileLen == -1) {
    alert("${filePath} 파일을 찾을 수 없습니다.");
  }

  $(window).scroll(function(e) {
    if (fileLen == 0) {
      return;
    }

    lastFunc = false;

    if (readFlag == true) {
      lastFunc = true;
      return;
    }

    //setTimeout(pageCheck, 100);
    pageCheck();
  });
});

function init() {
  $("#container").css("height", ((fileLen + 2) * FONT_SIZE) + "px");
}

function pageCheck() {
  readFlag = true;

  var pos = $(document).scrollTop() - $("#container").offset().top;
  var offsetPos = parseInt(pos / FONT_SIZE / PAGE_LINE) * PAGE_LINE;

  if (initFlag == false || offsetPos >= offset + PAGE_LINE * 3 || offsetPos <= offset - PAGE_LINE * 2) {
    if (offsetPos == parseInt(fileLen / PAGE_LINE) * PAGE_LINE) {
      offsetPos -= PAGE_LINE;
    }

    console.log("move page...");
    offset = offsetPos - PAGE_LINE;

    if (offset < 0) {
      offset = 0;
    }

    initFlag = true;
    getHexData(2);
  } else if (offsetPos >= offset + PAGE_LINE * 2) {
    if (offsetPos == parseInt(fileLen / PAGE_LINE) * PAGE_LINE) {
      readFlag = false;
      return;
    }

    console.log("next page...");
    offset += PAGE_LINE;
    getHexData(0);
  } else if (offset > 0 && offsetPos <= offset) {
    console.log("prev page...");
    offset -= PAGE_LINE;
    getHexData(1);
  } else {
    readFlag = false;
  }
}

function getHexData(flag) {
  var sendData = {
      id: $("#id").val(),
      seq: $("#seq").val(),
      offset: offset,
      getLine: PAGE_LINE,
      updownFlag: flag,
  };
  //console.log(sendData);

  $.ajax({
    url: "/carpe/get_hex.do",
    dataType:'json',
    data: sendData,
    contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
    success: function(data) {
      var offsetList = data.offsetList;
      var hexList = data.hexList;
      var decList = data.decList;
      var updownFlag = data.updownFlag;

      if (!offsetList) {
        return;
      }

      var listLen = offsetList.length;
      var html = "";

      for (var i = 0; i < listLen; i++) {
        html += "<tr>";
        html +=   "<td style=\"padding-right:10px;\">" + offsetList[i] + "</td>";
        html +=   "<td style=\"padding-right:10px;\">" + hexList[i] + "</td>";
        html +=   "<td style=\"padding-right:10px;\">" + decList[i] + "</td>";
        html += "</tr>";
      }

      if (listLen > 0) {
        if (updownFlag == 0) {
          var padding = offset * FONT_SIZE;
          $("#hexView").find("tr:lt(" + PAGE_LINE + ")").remove();
          $("#container").css("padding-top", padding + "px");
          $("#container").css("height", ((fileLen + 2) * FONT_SIZE - padding) + "px");
       
          $("#hexView").append(html);
        } else if (updownFlag == 1) {
          var padding = offset * FONT_SIZE;
          var trLen = $("#hexView").find("tr").length - ($("#hexView").find("tr").length - PAGE_LINE * 2) - 1;

          if (padding < 0) {
            padding = 0;
          }

          if (trLen > 0) {
            $("#hexView").find("tr:gt(" + trLen + ")").remove();
          }

          $("#container").css("padding-top", padding + "px");
          $("#container").css("height", ((fileLen + 2) * FONT_SIZE - padding) + "px");
        
          $("#hexView").prepend(html);
        } else if (updownFlag == 2) {
          var padding = offset * FONT_SIZE;

          if (padding < 0) {
            padding = 0;
          }

          $("#container").css("padding-top", padding + "px");
          $("#container").css("height", ((fileLen + 2) * FONT_SIZE - padding) + "px");
          $("#hexView").html(html);
        }
      }
    },
    complete: function() {
      readFlag = false;

      if (lastFunc == true) {
        pageCheck();
      }
    }
  });
}

</script>

</body>
</html>