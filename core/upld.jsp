<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	upld	- a generic upload page.
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "File Upload";
	fieldsetTitle = pageTitle;

	session.setAttribute("aseUploadProcess","upld");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/genericupload.js"></script>

	<style type="text/css">
		.upload_field { width: 90%; display: block; }
		em.alt { color: #999; }
		#upload_files fieldset { border: 1px solid #ccc; -moz-border-radius: 7px; -webkit-border-radius: 7px; }
		#upload_files legend { font-size: 1.2em; }
		fieldset.alt { background-color: #f7f7ff; }
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

				<form method="post" id="aseForm" name="aseForm" enctype="multipart/form-data" action="/central/servlet/upload">

					<tr height="30">
						 <td class="textblackth" valign="top" width="15%">Datafile*:</td>
						 <td valign="top"><input type="file" name="fileName" size="50" id="fileName" class="upload" /></td>
					</tr>

					<tr>
						 <td colspan="2"><h4 class="tutheader">*Files may not exceed 10MB in size</h4></td>
					</tr>

					</td></tr>
					<tr align="right">
						 <td colspan="2">
							<input type="hidden" name="formName" value="aseForm">
							<input title="save content" type="submit" name="aseUpload" value="Upload" class="inputsmallgray" onclick="return aseSubmitClick('a')">
							<input title="abort selected operation" type="submit" name="aseClose" value="Close" class="inputsmallgray" onClick="return cancelForm()">
							&nbsp;&nbsp;&nbsp;&nbsp;
					</td></tr>

					<tr>
						 <td colspan="2">
							<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204 overflow: height: 400px; width: 100%;" id="spinner">
								<p align="center"><br/><br/>processing...<img src="../images/spinner.gif" alt="processing..." border="0"></p>
							</div>
					</td></tr>

				</form>

			</table>

		</td>
	</tr>
</table>

<%
	}
	asePool.freeConnection(conn,"upld",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
