<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	upload.jsp	- generic upload
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// these values were set in crsedt
	String alpha = "";
	String num = "";
	String kix = "";

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Upload";

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

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<table width="60%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">

	<form method="post" id="aseForm" name="aseForm" enctype="multipart/form-data" action="/central/servlet/opihi">

		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
				 <td colspan="2" class="dataColumnCenter"><strong>Data Upload</strong>
		</td></tr>

		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			 <td class="textblackth" valign="top" width="12%">Upload Type:</td>
			 <td valign="top">
					<select class="input" name="uploadType">
						<option value="">-select-</option>
						<option value="CoReq">Co Requisites</option>
						<option value="PreReq">Pre Requisites</option>
					</select>&nbsp;(Note: upload file must be comma separated value saved in TXT format)
			 </td>
		</tr>

		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			 <td class="textblackth" valign="top" width="12%">Datafile*:</td>
			 <td valign="top"><input class="input" type="file" name="fileName" size="50" id="fileName" class="upload" />
		</td></tr>

		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			 <td colspan="2">
			<p align="center">
			<font class="textblackth"><br/>Sample file formats</font>
				<table width="100%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">
					<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
						 <td valign="top" align="center">
						 	<img src="../images/ext/txt.gif" border="0" alt=""><br/><a href="../docs/help/prereq.txt" class="linkcolumn">Pre Req</a>
						 </td>
						 <td valign="top" align="center">
						 	<img src="../images/ext/txt.gif" border="0" alt=""><br/><a href="../docs/help/coreq.txt" class="linkcolumn">Co-Req</a>
						 </td>
					</td></tr>
				</table>
			</p></td>
		</tr>

		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			 <td colspan="2">
				<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204 overflow: height: 400px; width: 100%;" id="spinner">
					<p align="center"><br/><br/>processing...<img src="../images/spinner.gif" alt="processing..." border="0"></p>
				</div>
		</td></tr>

		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			 <td colspan="2">
			<p align="center">
			<font class="textblackth">*Files may not exceed 10MB in size</font>
			</p></td>
		</tr>

		</td></tr>
		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>" align="right">
			 <td colspan="2">
				<input type="hidden" name="formName" value="aseForm">
				<input title="save content" type="submit" name="aseUpload" value="Upload" class="inputsmallgray" onclick="return aseSubmitClick('a')">
				<input title="abort selected operation" type="submit" name="aseClose" value="Close" class="inputsmallgray" onClick="return cancelForm()">
		</td></tr>

	</form>

</table>
<%
	asePool.freeConnection(conn,"upload",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
