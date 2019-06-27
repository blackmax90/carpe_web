<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.carpe.common.Consts"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CARPE Evidence</title>
<link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
<script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
<script type="text/javascript" src="/carpe/resources/js/common.js"></script>
<script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>

</head>

<body>
	<header class='outer'>
		<h1 style="display: inline;">CARPE</h1>
		<!--h3 style="display: inline; margin-left:20px;">Case [ <span style="color: #1f07f1;">${sessionScope.case_name}</span> ]</h3 -->
		<h3 style="display: inline; margin-left:20px;">Case [ <span style="color: #1f07f1;"><%=(String)session.getAttribute(Consts.SESSION_CASE_NAME)%></span> ]</h3>
	</header>
	<div class='outer'>
		<article class='outer'>
			<header class='inner'>
				<button type="button" id="btnNewEvdnc">New</button>
				<button type="button" id="btnDeleteEvdncs">Delete</button>
			</header>
			<div class='inner'>
				<article class='inner'>
					<div id="jqxGrid_evdnc"></div>
				</article>
			</div>
			<footer class='inner'>Footer</footer>
		</article>
		<nav class='outer'>
			<ul>
				<li><a href="/carpe/case.do">Case</a></li>
				<li class="on"><a href="/carpe/evdnc.do">Evidence</a></li>
			</ul>
		</nav>
	</div>
	<footer class='outer'>Footer</footer>

	<div id="addEvdncWindow">
		<div id="addEvdncWindowHeader">
			<span style="float: left">Create Evidence</span>
		</div>
		<div id="addEvdncWindowContent" style="overflow: hidden">
		    <form action="/carpe/add_evdnc.do" method="post" enctype="multipart/form-data">
				<div style="margin: 10px">
					Evidence Type:
					<select name="newEvdncSubType" id="newEvdncSubType">
						<option>EWF</option>
						<option>AFF</option>
						<option>RAW</option>
						<option>VMDK</option>
						<option>VHD</option>
					</select>
					<br /><br />
					Name: <input name="newEvdncName" id="newEvdncName" type="text" style="width: 175px; border: 1px solid #aaa" />
					<br /><br />
					파일 선택: <input type="file" id="evdnc_file" name="evdnc_file">
					<br /><br />
				    <div class="progress">
						<div id="progressBar" class="progress-bar progress-bar-success" role="progressbar"
						  aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">0%
						</div>
				    </div>
					<br /><br />
	                <div style="float: right; margin-top: 15px;">
	                    <input type="button" id="ok" value="OK" style="margin-right: 10px" />
	                    <input type="button" id="cancel" value="Cancel" />
	                </div>
				</div>
			</form>
		</div>
	</div>

<script>
(function($) {
	$(document).ready(function() {
		var source = {
			datatype: "json",
			datafields: [
				{ name: 'serial_number', type: 'number' },
				{ name: 'evd_id', type: 'string' },
				{ name: 'evd_name', type: 'string' },
				{ name: 'evd_path', type: 'string' },
				{ name: 'tmp_path', type: 'string' },
				{ name: 'case_id', type: 'string' },
				{ name: 'main_type', type: 'string' },
				{ name: 'sub_type', type: 'string' },
				{ name: 'timezone', type: 'string' },
				{ name: 'acquired_date', type: 'string' },
				{ name: 'md5', type: 'string' },
				{ name: 'sha1', type: 'string' },
				{ name: 'sha256', type: 'string' },
				{ name: 'process_state', type: 'number' }
			],
            type : "POST",
            contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
			url: "/carpe/evdnc_list.do"
		};

		var dataAdapter = new $.jqx.dataAdapter(source, {
			contentType : 'application/json; charset=utf-8',
			formatData : function(data) {
	            return data;
			},
			beforeSend : function(xhr) {
			},
			downloadComplete : function(data, status, xhr) {
			},
			loadComplete : function(data) {
			},
			loadError : function(xhr, status, error) {
			}
		});

		var columnSet = [
			{text: 'Index', dataField: 'serial_number', width: '50px', cellsalign: 'right', align: 'center'},
			{text: 'Evidence Name', dataField: 'evd_name', width: '150px', cellsalign: 'left', align: 'center',
				cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
					var dataRecord = $("#jqxGrid_evdnc").jqxGrid('getrowdata', row);
					var evdncInfo = {};
					evdncInfo.id = dataRecord.evd_id;
					evdncInfo.name = value;
					var param = encodeQueryData(evdncInfo);

					return '<span style="margin: 7px; float: ' + columnproperties.cellsalign + '; color: #ff0000;"><a href="/carpe/select_evdnc.do?' + param + '">' + value + '</a></span>';
				}
			},
			{text: 'Main Type', dataField: 'main_type', width: '90px', cellsalign: 'center', align: 'center',
				renderer: function () {
	            	return '<div style="margin: 3px; text-align: center;">Main<br />Type</div>';
	        	}
			},
			{text: 'Sub Type', dataField: 'sub_type', width: '90px', cellsalign: 'center', align: 'center',
				renderer: function () {
	            	return '<div style="margin: 3px; text-align: center;">Sub<br />Type</div>';
	        	}
			},
			{text: 'Acquired Date', dataField: 'acquired_date', width: '170px', cellsalign: 'center', align: 'center'},
			{text: 'MD5', dataField: 'md5', width: '120px', cellsalign: 'center', align: 'center'},
			{text: 'SHA1', dataField: 'sha1', width: '120px', cellsalign: 'center', align: 'center'},
			{text: 'SHA256', dataField: 'sha256', width: '120px', cellsalign: 'center', align: 'center'},
			{text: 'Process State', dataField: 'process_state', width: '120px', cellsalign: 'center', align: 'center'},
			{text: 'Evidence Path', dataField: 'evd_path', cellsalign: 'left', align: 'center',
				cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
					var dataRecord = $("#jqxGrid_evdnc").jqxGrid('getrowdata', row);
					var evdncInfo = {};
					evdncInfo.id = dataRecord.evd_id;
					var param = encodeQueryData(evdncInfo);

					return '<span style="margin: 7px; float: ' + columnproperties.cellsalign + '; color: #ff0000;"><a target="_blank" href="/carpe/download_evdnc.do?' + param + '">' + value + '</a></span>';
				}
			}
		];

		$('#jqxGrid_evdnc').on('bindingcomplete', function(event) {
			var localizationobj = {};
			localizationobj.emptydatastring = " ";

			$("#jqxGrid_evdnc").jqxGrid('localizestrings', localizationobj);
		});

		$("#jqxGrid_evdnc").jqxGrid({
			width: '100%',
			height: '100%',
			source: dataAdapter,
			selectionmode: 'checkbox',
			pagerheight: 0,
			altrows: true,
			scrollbarsize: 12,
			autoshowloadelement: true,
			ready: function() {},
			enablebrowserselection: true,
			columnsresize: true,
			filterable: true,
			sortable: true,
			sortMode: 'many',
			columnsheight: 40,
			columns: columnSet
		});

		$('#addEvdncWindow').jqxWindow({  width: 400, height: 300, resizable: false
			, cancelButton: $('#cancel'), autoOpen: false, resizable: false, isModal: true, modalOpacity: 0.3
        });

		$('#btnNewEvdnc').click(function(e) {
			$("#newEvdncSubType option:eq(0)").prop("selected", true);
        	$('#newEvdncName').val('');
        	$('input[type=file]').val('');
			
        	$('#ok').prop('disabled',false);
			$('#progressBar').text('');
			$('#progressBar').css('width','0%');

        	$('#addEvdncWindow').jqxWindow('open');
		});

		$('#ok').click(function(e) {
			e.preventDefault();

			if (!checkInput('Name', '#newEvdncName')) {
        		return;
        	}

		    if (!$("#evdnc_file")[0].files.length) {
				alert('파일을 선택해 주십시오.');
				$("#evdnc_file").focus();
		    	return;
		    }

		    var that = $(this);

			that.prop('disabled',true);

			var form = document.forms[0];
			var formData = new FormData(form);

			var ajaxReq = $.ajax({
				url : '/carpe/add_evdnc.do',
				type : 'POST',
				data : formData,
				cache : false,
				contentType : false,
				processData : false,
				xhr: function(){
					//Get XmlHttpRequest object
					 var xhr = $.ajaxSettings.xhr() ;

					//Set onprogress event handler
					 xhr.upload.onprogress = function(event){
						var perc = Math.round((event.loaded / event.total) * 100);
						$('#progressBar').text(perc + '%');
						$('#progressBar').css('width',perc + '%');
					 };
					 return xhr ;
				},
				beforeSend: function( xhr ) {
					//Reset progress bar
					$('#progressBar').text('');
					$('#progressBar').css('width','0%');
                }
			});

			ajaxReq.done(function(data) {
				$('#addEvdncWindow').jqxWindow('close');
				$("#jqxGrid_evdnc").jqxGrid('updateBoundData');
				
				alert(data.msg);
			});

			ajaxReq.fail(function(jqXHR) {
				$('#progressBar').text('');
				$('#progressBar').css('width','0%');
				that.prop('disabled',false);

				alert(jqXHR.responseJSON.msg + '('+ jqXHR.status + ' - ' + jqXHR.statusText + ')');
			});
		});
	});
})(jQuery);

</script>

</body>
</html>