<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<script type="text/javascript">
	$(function() {
		$('button[type=submit]').click(function(e) {
			e.preventDefault();

			var fp = $("#file1");
		    var lg = fp[0].files.length; // get length
		    alert("length:" + lg);
		    if (!lg) {
		    	return;
		    }

		    var items = fp[0].files;
		    var fragment = "";
		    
		    if (lg > 0) {
		        for (var i = 0; i < lg; i++) {
		            var fileName = items[i].name; // get file name
		            var fileSize = items[i].size; // get file size 
		            var fileType = items[i].type; // get file type

		            //alert(fileName + ", " + fileSize + ", " + fileType);
		        }

		    }
			
			//Disable submit button
			$(this).prop('disabled',true);
			
			
			var form = document.forms[0];
			var formData = new FormData(form);
				
			// Ajax call for file uploaling
			var ajaxReq = $.ajax({
				url : '/carpe/file_upload.do',
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
					//Reset alert message and progress bar
					$('#alertMsg').text('');
					$('#progressBar').text('');
					$('#progressBar').css('width','0%');
                }
			});

			// Called on success of file upload
			ajaxReq.done(function(msg) {
				alert('aaa');
				$('#alertMsg').text(msg);
				$('input[type=file]').val('');
				$('button[type=submit]').prop('disabled',false);
			});
			
			// Called on failure of file upload
			ajaxReq.fail(function(jqXHR) {
				$('#alertMsg').text(jqXHR.responseText+'('+jqXHR.status+
						' - '+jqXHR.statusText+')');
				$('button[type=submit]').prop('disabled',false);
			});
		});
	});
</script>

</head>
<body>
  <div class="container">
    <h2>Spring MVC - File Upload Example With Progress Bar</h2>
    <hr>
    <!-- File Upload From -->
    <form action="/carpe/file_upload.do" method="post" enctype="multipart/form-data">
      <div class="form-group">
         <input type="text" name="email">
         <br><br>
		<select name="select" id="newEvdncType">
			<option>EWF</option>
			<option>AFF</option>
			<option>RAW</option>
			<option>VMDK</option>
			<option>VHD</option>
		</select>
         <br><br>
        <label>Select File</label> <input class="form-control" type="file" id="file1" name="file1">
      </div>
      <div class="form-group">
        <button class="btn btn-primary" type="submit">Upload</button>
      </div>
    </form>
    <br />

    <!-- Bootstrap Progress bar -->
    <div class="progress">
      <div id="progressBar" class="progress-bar progress-bar-success" role="progressbar"
        aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">0%</div>
    </div>

    <!-- Alert -->
    <div id="alertMsg" style="color: red;font-size: 18px;"></div>
  </div>
</body>
</html>