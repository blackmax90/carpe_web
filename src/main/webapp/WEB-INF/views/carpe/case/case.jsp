
<!DOCTYPE html>
<html lang="ko"><!-- 사용자 언어에 따라 lang 속성 변경. 예) 한국어: ko, 일본어: ja, 영어: en -->
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>CARPE</title>
 	<link href="/carpe/resources/jqwidgets/styles/jqx.base.css" rel="stylesheet" type="text/css">	
	<link href="/carpe/resources/jqwidgets/styles/jqx.metrodark.css" rel="stylesheet" type="text/css">
	<link href="/carpe/resources/jqwidgets/styles/jqx.energyblue.css" rel="stylesheet" type="text/css">
    <link href="/carpe/resources/css/style.css" rel="stylesheet" type="text/css">
</head>
<body>

	<!-- wrap -->
	<div class="wrap home bg-theme blue">

		<!-- header -->
		<%@ include file="../common/header.jsp" %>
		<!-- // header -->

		<!-- main -->
		<main class="main">
			<article class="container">
				<h4 class="blind">조회된 컨텐츠</h4>
				<div id="jqxSplitter" class="jqx-reset jqx-splitter jqx-widget jqx-widget-content content-box">
					<div class="content-area">				
						<!--// Content 영역 -->		
						<div class="btn-area">
							<ul>
								<li>
									<button type="button" class="btn-case-01" id="btnNewCase"><span class="icon ico-plus">New Case</span></button>
								</li>
								<li>
									<button type="button" class="btn-case-01" id="btnDeleteCases"><span class="icon ico-minus">Delete Case</span></button>
								</li>
							</ul>
						</div>
						<div id="jqxGrid_Systemlog" role="grid" align="left" class="cont-result">
							<!--// Table 영역 //-->
						</div>
						<div id="paing" class="paging-area">
							<!--// Table Paging 영역 - 위치고정 //-->
							<div class="paginate">
								<button type="button" class="btn-paging icon ico-first"><span class="ir">처음</span></button>
								<button type="button" class="btn-paging icon ico-prev"><span class="ir">이전</span></button>
								<span class="num">
									<a href="#">81</a>
									<a href="#">82</a>
									<a href="#"><strong class="on">83</strong></a>
									<a href="#">84</a>
									<a href="#">85</a>
									<a href="#">86</a>
									<a href="#">87</a>
									<a href="#">88</a>
									<a href="#">89</a>
									<a href="#">90</a>
								</span>
								<button class="btn-paging icon ico-next"><span class="ir">다음</span></button>
								<button class="btn-paging icon ico-last" disabled="disabled"><span class="ir">마지막</span></button>
							</div>
						</div>
						<!-- Content 영역 //-->	
					</div>
				</div>
			</article>
		</main>
		<!-- // main -->

	</div>
	
	<div id="addCaseWindow" class="pop wrap-pop">
		<div id="addCaseWindowHeader" class="pop-header">
			<h1>Create Case</h1>
		</div>
		<div id="addCaseWindowContent" class="pop-content">
			<div class="data-type-1">
				<dl>
					<dt>Name :</dt>
					<dd class="input-text input-text-type-1"><input id="newCaseName" type="text"/></dd>
				</dl>
				<dl>
					<dt>Administrator :</dt>
					<dd class="input-text input-text-type-1"><input id="newCaseAdministrator" type="text"/></dd>
				</dl>
				<dl>
					<dt>Time Zone :</dt>
					<dd class="input-text input-text-type-1"><input id="newCaseTimeZone" type="text"/></dd>
				</dl>
				<dl>
					<dt>Description :</dt>
					<dd><textarea id="newCaseDescription" cols="36" rows="5" class="textarea" ></textarea></dd>
				</dl>
			</div>
            <div class="btn-area">
                <ul>
		            <li><button type="button" class="btn-case-01" id="cancel" value="Cancel" >Cancel</button></li>
                	<li><button type="button" class="btn-case-01" id="ok" value="OK">OK</button></li>
		        </ul>
            </div>
		</div>
	</div>	
	<!-- 공통 javascript 영역 -->		
	<script type="text/javascript" src="/carpe/resources/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="/carpe/resources/jqwidgets/jqx-all.js"></script>
	<script type="text/javascript" src="/carpe/resources/jqwidgets/globalization/globalize.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/common.js"></script>
	<script type="text/javascript" src="/carpe/resources/js/MYAPP.js"></script>
	<!-- // 공통 javascript 영역 -->

	<script>
	(function($) {
		$(document).ready(function() {

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
					var totalcount = data['totalcount'] || 0;
					currentRowCount = data['list'] ? data['list'].length : 0;
					
					$('#paing').empty();

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
						var dataRecord = $("#jqxGrid_Systemlog").jqxGrid('getrowdata', row);
						var caseInfo = {};
						caseInfo.id = dataRecord.case_id;
						caseInfo.name = value;
						var param = encodeQueryData(caseInfo);
						
						return '<span style="padding: 7px; float: ' + columnproperties.cellsalign + '; color: #ff0000;"><a href="/carpe/select_case.do?' + param + '">' + value + '</a></span>';
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

			$('#jqxGrid_Systemlog').on('bindingcomplete', function(event) {
				// apply localization.
				var localizationobj = {};
				localizationobj.emptydatastring = " ";

				$("#jqxGrid_Systemlog").jqxGrid('localizestrings', localizationobj);
				//$("#jqxGrid_Systemlog").jqxGrid('pagesize', currentRowCount);
			});

			$("#jqxGrid_Systemlog").jqxGrid({
				width: '100%',	
				height: 'calc(100% - 7rem)',			
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

			/*$('#jqxGrid_Systemlog').on('rowselect', function (event) {
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

			// New Case Layer Open
			$('#addCaseWindow').jqxWindow({  width: 400, height: 400, resizable: false,
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
			
			// New Case Init
	        $('#btnNewCase').click(function(e) {
	        	$('#newCaseName').val('');
	        	$('#newCaseAdministrator').val('');
	        	$('#newCaseTimeZone').val('');
	        	$('#newCaseDescription').val('');

	        	$('#addCaseWindow').jqxWindow('open');
			});

			// Case Delete
			$("#btnDeleteCases").click(function(e) {
				if (confirm('삭제 하시겠습니까')) {
					var selectedrowindexes = $("#jqxGrid_Systemlog").jqxGrid('getselectedrowindexes');
					var rowscount = $("#jqxGrid_Systemlog").jqxGrid('getdatainformation').rowscount;
					
					$("#jqxGrid_Systemlog").jqxGrid('beginupdate');
					var deleteCase = {};
					var idList = "";
					// delete the selected rows by using the 'deleterow' method of jqxGrid.
					for (var m = 0; m < selectedrowindexes.length; m++) {
					    var selectedrowindex = selectedrowindexes[m];
					    console.log(selectedrowindex);
					    var selectedRowData = $('#jqxGrid_Systemlog').jqxGrid('getrowdata', selectedrowindex);
					    idList += "," + selectedRowData["case_id"];
					}
					idList = idList.substring(1);
		        	var deleteCase = {};
		        	deleteCase.caseId = idList;
		        	
					$.ajax({
						type : "POST",
						url : "/carpe/delete_case.do",
						data : deleteCase,
						async: false,
						success : function(data, textStatus, jqXHR) {
							if (data['affected'] < 1) {
								alert("삭제에 실패 하였습니다");
							} else {
								alert('삭제 되었습니다.');
								location.reload();
							}
						},
						error : function(jqXHR, textStatus, errorThrown) {
							alert(errorThrown);
						}
					});
				}
			});
			
			// Case Insert Proc
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
							$("#jqxGrid_Systemlog").jqxGrid('updateBoundData');
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