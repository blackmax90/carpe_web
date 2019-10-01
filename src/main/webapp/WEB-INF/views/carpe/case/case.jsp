<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CARPE Case</title>
<link href="/carpe/resources/css/common.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">
<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
<script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
<script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
<script type="text/javascript" src="/carpe/resources/js/common.js"></script>
<script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>

</head>

<body>
	<header class='outer'>
		<h1>CARPE</h1>
	</header>
	<div class='outer'>
		<article class='outer'>
			<header class='inner'>
				<button type="button" id="btnNewCase">New</button>
				<button type="button" id="btnDeleteCases">Delete</button>
				<button type="button" id="btnMap">Map</button>
			</header>
			<div class='inner'>
				<article class='inner'>
					<div id="jqxGrid_case"></div>
				</article>
			</div>
			<footer class='inner'>Footer</footer>
		</article>
		<nav class='outer'>
			<ul>
				<li class="on"><a href="/carpe/case.do">Case</a></li>
			</ul>
		</nav>
	</div>
	<footer class='outer'>Footer</footer>

	<div id="addCaseWindow">
		<div id="addCaseWindowHeader">
			<span style="float: left">Create Case</span>
		</div>
		<div id="addCaseWindowContent" style="overflow: hidden">
			<div style="margin: 10px">
				Name: <input id="newCaseName" type="text" style="width: 175px; border: 1px solid #aaa" />
				<br /><br />
				Administrator: <input id="newCaseAdministrator" type="text" style="width: 175px; border: 1px solid #aaa" />
				<br /><br />
				Time Zone: <input id="newCaseTimeZone" type="text" style="width: 175px; border: 1px solid #aaa" />
				<br /><br />
				Description: <textarea id="newCaseDescription" cols="36" rows="5" ></textarea>
				<br /><br />
                <div style="float: right; margin-top: 15px;">
                    <input type="button" id="ok" value="OK" style="margin-right: 10px" />
                    <input type="button" id="cancel" value="Cancel" />
                </div>
			</div>
		</div>
	</div>

<script>
(function($) {
	$(document).ready(function() {
		$('#btnMap').click(function(e) {
			var popUrl = "/carpe/map.do";
			var popOption = "width=900, height=750, resizable=no, scrollbars=no, status=no;";
			window.open(popUrl,"",popOption);
		});

		var source = {
			datatype: "json",
			datafields: [
				{ name: 'serial_number', type: 'number' },
				{ name: 'case_id', type: 'string' },
				{ name: 'case_name', type: 'string' },
				{ name: 'administrator', type: 'string' },
				{ name: 'create_date', type: 'string' },
				{ name: 'case_path', type: 'string' },
				{ name: 'tmp_path', type: 'string' },
				{ name: 'description', type: 'string' },
				{ name: 'evd_cnt', type: 'number' }
			],
            type : "POST",
            contenttype: "application/x-www-form-urlencoded; charset=UTF-8",
			url: "/carpe/case_list.do"
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
			{text: 'Case Name', dataField: 'case_name', width: '150px', cellsalign: 'left', align: 'center',
				cellsrenderer : function(row, columnfield, value, defaulthtml, columnproperties) {
					var dataRecord = $("#jqxGrid_case").jqxGrid('getrowdata', row);
					var caseInfo = {};
					caseInfo.id = dataRecord.case_id;
					caseInfo.name = value;
					var param = encodeQueryData(caseInfo);
					
					return '<span style="margin: 7px; float: ' + columnproperties.cellsalign + '; color: #ff0000;"><a href="/carpe/select_case.do?' + param + '">' + value + '</a></span>';
				}
			},
			{text: 'Description', dataField: 'description', width: '200px', cellsalign: 'left', align: 'center'},
			{text: 'Administrator', dataField: 'administrator', width: '150px', cellsalign: 'center', align: 'center'},
			{text: 'Permission', dataField: 'permission', width: '150px', cellsalign: 'center', align: 'center'},
			{text: 'Create Date', dataField: 'create_date', width: '150px', cellsalign: 'center', align: 'center'},
			{text: '# of Evidence', dataField: 'evd_cnt', width: '80px', cellsalign: 'right', align: 'center',
				renderer: function () {
	            	return '<div style="margin: 3px; text-align: center;"># of<br />Evidence</div>';
	        	}
			},
			{text: 'Last Access Date', dataField: 'last_access_date', width: '150px', cellsalign: 'center', align: 'center'},
		];

		$('#jqxGrid_case').on('bindingcomplete', function(event) {
			// apply localization.
			var localizationobj = {};
			localizationobj.emptydatastring = " ";

			$("#jqxGrid_case").jqxGrid('localizestrings', localizationobj);
			//$("#jqxGrid_case").jqxGrid('pagesize', currentRowCount);
		});

		$("#jqxGrid_case").jqxGrid({
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

		/*$('#jqxGrid_case').on('rowselect', function (event) {
		    var rowBoundIndex = (event.args).rowindex;
		    if (!selectFromMethod) {
		        $('#jqxgrid').jqxGrid('clearselection');
		        selectFromMethod = true;
		        $('#jqxgrid').jqxGrid('selectrow', rowBoundIndex);
		    }
		    selectFromMethod = false;
		});
		*/

		/*
		$("#jqxButton").on('click', function () {
            var getselectedrowindexes = $('#jqxgrid').jqxGrid('getselectedrowindexes');
            if (getselectedrowindexes.length > 0)
            {
                // returns the selected row's data.
                var selectedRowData = $('#jqxgrid').jqxGrid('getrowdata', getselectedrowindexes[0]);
            }
        });
		*/

		$('#addCaseWindow').jqxWindow({  width: 400, height: 300, resizable: false,
            /*okButton: $('#ok'),*/ cancelButton: $('#cancel'),
            autoOpen: false,
            //position: { x: offset.left + 50, y: offset.top + 50 },
            resizable: false, isModal: true, modalOpacity: 0.3,
            initContent: function () {
                //$('#searchTextButton').jqxButton({ width: '80px', disabled: true });
                //$('#cancelButton').jqxButton({ width: '80px', disabled: false });
                //$('#matchCaseCheckBox').jqxCheckBox({ width: '150px' });
            }
        });

        /*
        $('#addCaseWindow').on('close', function (event) {
            if (event.type === 'close') {
                if (event.args.dialogResult.OK) {
                    alert('OK');
                } else if (event.args.dialogResult.Cancel) {
                    alert('Cancel');
                } else { // windows X button
                    alert('None');
                }
            }
        });
		*/

        $('#btnNewCase').click(function(e) {
        	$('#newCaseName').val('');
        	$('#newCaseAdministrator').val('');
        	$('#newCaseTimeZone').val('');
        	$('#newCaseDescription').val('');

        	$('#addCaseWindow').jqxWindow('open');
		});

        $('#ok').click(function(e) {
        	var caseName, caseAdministrator, caseDescription;
        	if (!(caseName = checkInput('Name', '#newCaseName'))) {
        		return;
        	}

        	if (!(caseAdministrator = checkInput('Administrator', '#newCaseAdministrator'))) {
        		return;
        	}

        	caseDescription = $.trim($('#newCaseDescription').val());

        	var newCase = {};
        	newCase.name = caseName;
        	newCase.admin = caseAdministrator;
        	newCase.desc = caseDescription;

			var querystr = encodeQueryData(newCase);

			$.ajax({
				type : "POST",
				url : "/carpe/add_case.do",
				data : querystr,
				async: false,
				success : function(data, textStatus, jqXHR) {
					if (data['affected'] < 1) {
						alert("Case No 값이 이미 존재하거나, 에러가 발생하여 추가할 수 없습니다.");
					} else {
						alert('신규 CASE가 추가되었습니다.');

						$('#addCaseWindow').jqxWindow('close');

						$("#jqxGrid_case").jqxGrid('updateBoundData');
					}
				},
				error : function(jqXHR, textStatus, errorThrown) {
					alert(errorThrown);
				}
			});
		});
	});
})(jQuery);

</script>

</body>
</html>