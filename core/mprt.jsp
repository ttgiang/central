<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	import.jsp	- generic import
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "File Upload";
	fieldsetTitle = pageTitle;

	session.setAttribute("aseUploadProcess","mprt");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script type="text/javascript" src="js/genericupload.js"></script>

	<style type="text/css">
		.upload_field { width: 90%; display: block; }
		em.alt { color: #999; }
		#upload_files fieldset { border: 1px solid #ccc; -moz-border-radius: 7px; -webkit-border-radius: 7px; }
		#upload_files legend { font-size: 1.2em; }
		fieldset.alt { background-color: #f7f7ff; }
	</style>

	<style type="text/css">

		table.example{
			color:#000000;
			background-color:#e5eecc;
			padding-top:8px;
			padding-bottom:8px;
			padding-left:10px;
			padding-right:10px;
			border:1px solid #d4d4d4;
			background-image:url('bgfadegreen.gif');
			background-repeat:repeat-x;
		}

		table.example_code{
			background-color:#ffffff;
			padding:4px;
			border:1px solid #d4d4d4;
		}

		table.example_code td{
			font-size:110%;
			font-family:courier new;
		}

		table.example_result{
			background-color:#ffffff;
			padding:4px;
			border:1px solid #d4d4d4;
		}

		table.code{
			outline:1px solid #d4d4d4;
			border:5px solid #e5eecc;
		}

		table.code td{
			font-size:100%;
			background-color:#FFFFFF;
			border:0px solid #d4d4d4;
			padding:4px;
		}

		h1 {font-size:200%;margin-top:0px;font-weight:normal}
		h2 {font-size:160%;margin-top:10px;margin-bottom:10px;font-weight:normal}
		h3 {font-size:120%;font-weight:normal}
		h4 {font-size:100%;}
		h5 {font-size:90%;}
		h6 {font-size:80%;}

		h4.tutheader{
			margin:0px;
			margin-top:30px;
			padding-top:2px;
			padding-bottom:2px;
			padding-left:4px;
			color:#303030;
			border:1px solid #d4d4d4;
			background-color:#ffffff;
			background-image:url('../images/gradientfromtop.gif');
			background-repeat:repeat-x;
			background-position:0px -50px;
		}

	</style>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (processPage){
%>
<table class="example_code notranslate" border="0" cellpadding="0" cellspacing="0" width="60%">
	<tr>
		<td>
			<table width="100%" cellspacing="1" cellpadding="2" class="code" align="center"  border="0">

				<form method="post" id="aseForm" name="aseForm" enctype="multipart/form-data" action="/central/servlet/opihi?s=mprt">

					<tr><td colspan="2" class="dataColumnCenter"><strong>File Upload</strong></td></tr>

					<tr height="30">
						 <td class="textblackth" valign="top" width="15%">Import Type:</td>
						 <td valign="top">
								<select class="input" name="uploadType">
									<option value="">-select-</option>
									<option value="CoReq">Co-Requisites</option>
									<option value="XList">Cross Listed</option>
									<option value="PreReq">Pre-Requisites</option>
								</select>&nbsp;(Note: import file must be CSV format)
						 </td>
					</tr>

					<tr height="30">
						 <td class="textblackth" valign="top" width="15%">Datafile*:</td>
						 <td valign="top"><input type="file" name="fileName" size="50" id="fileName" class="upload" /></td>
					</tr>

					<tr>
						 <td colspan="2" class="tutheader">
							<h4 class="tutheader">Sample file formats</h4>
							<table width="100%" cellspacing="1" cellpadding="2" align="center"  border="0">
								<tr>
									 <td valign="top">
										<ul>
											<li><img src="../images/ext/txt.gif" border="0" alt="">&nbsp;<a href="/centraldocs/docs/help/coreq.txt" class="linkcolumn" target="_blank">Co-Req</a><br/><br/></li>
											<li><img src="../images/ext/txt.gif" border="0" alt="">&nbsp;<a href="/centraldocs/docs/help/xlist.txt" class="linkcolumn" target="_blank">Cross Listed</a><br/><br/></li>
											<li><img src="../images/ext/txt.gif" border="0" alt="">&nbsp;<a href="/centraldocs/docs/help/prereq.txt" class="linkcolumn" target="_blank">Pre Req</a><br/><br/></li>
										</ul>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						 <td colspan="2"><h4 class="tutheader">*Files may not exceed 10MB in size</h4></td>
					</tr>

					<tr align="right">
						 <td colspan="2">
							<input type="hidden" name="formName" value="aseForm">
							<input title="save content" type="submit" name="aseUpload" value="Upload" class="inputsmallgray" onclick="return aseSubmitClick('a')">
							<input title="abort selected operation" type="submit" name="aseClose" value="Close" class="inputsmallgray" onClick="return cancelForm()">
					</td></tr>

					<tr>
						 <td colspan="2">
							<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204 overflow: height: 400px; width: 100%;" id="spinner">
								<p align="center"><br/><br/>processing...<img src="../images/spinner.gif" alt="processing..." border="0"></p>
							</div>
					</td></tr>

					<tr>
						 <td colspan="2">
								Note: imported data applies to approved course outlines only.
						</td>
					</tr>

				</form>

			</table>

		</td>
	</tr>
</table>

<%
	}
	asePool.freeConnection(conn,"mprt",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
