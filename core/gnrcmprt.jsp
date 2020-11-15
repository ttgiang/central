<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	gnrcmprt.jsp	- generic import
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "File Upload";
	fieldsetTitle = pageTitle;

	String src = website.getRequestParameter(request,"src","");
	if (src.equals("thisPage")){
		src = (String)session.getAttribute("aseCallingPage");
	}

	String kix = website.getRequestParameter(request,"kix","");
	if (kix.equals("hasValue")){
		kix = (String)session.getAttribute("aseKix");
	}

	String category = (String)session.getAttribute("aseUploadTo");
	if (category == null || category.length() == 0){
		category = "";
	}

	//
	// exists for forum
	//
	String mid = website.getRequestParameter(request,"mid","");
	String fid = website.getRequestParameter(request,"fid","");

	//
	// REQUIRED from sender
	//
	session.setAttribute("aseUploadProcess","gnrcmprt");
	session.setAttribute("aseUploadTo",category);
	session.setAttribute("aseUploadSrc",src);
	session.setAttribute("aseKix",kix);
	session.setAttribute("aseFid",fid);
	session.setAttribute("aseMid",mid);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
	<script type="text/javascript" src="js/genericupload.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header3.jsp" %>

<%
	if (processPage && !(Constant.BLANK).equals(src)){
%>

<table width="60%" cellspacing="1" cellpadding="2" class="tableBorder<%=session.getAttribute("aseTheme")%>" align="center"  border="0">

	<form method="post" id="aseForm" name="aseForm" enctype="multipart/form-data" action="/central/servlet/opihi?s=gnrcmprt">

		<tr class="textblackTRTheme<%=session.getAttribute("aseTheme")%>">
			<td colspan="2" class="dataColumnCenter"><strong>File Upload</strong></td>
		</tr>

		<tr>
			 <td class="textblackth" valign="top" width="15%">Datafile*:</td>
			 <td valign="top">
			 	&nbsp;<input class="input" type="file" name="fileName" size="50" id="fileName" class="upload" />
			</td>
		</tr>

		<tr >
			 <td colspan="2">
				<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204 overflow: height: 400px; width: 100%;" id="spinner">
					<p align="center"><br/><br/>processing...<img src="../images/spinner.gif" alt="processing..." border="0"></p>
				</div>
			</td>
		</tr>

		<tr  align="right">
			 <td colspan="2">
			 	<div class="hr"></div>
				<input type="hidden" name="formName" value="aseForm">
				<input type="hidden" name="mid" value="<%=mid%>">
				<input title="save content" type="submit" name="aseUpload" value="Upload" class="inputsmallgray" onclick="return aseSubmitClick('a')">
				<input title="abort selected operation" type="submit" name="aseClose" value="Close" class="inputsmallgray" onClick="return cancelFormX('<%=src%>','<%=kix%>')">
				&nbsp;&nbsp;&nbsp;
			</td>
		</tr>

		<tr >
			 <td colspan="2">
			<p align="center">
			<font class="textblackth">*Files may not exceed 10MB in size</font>
			</p></td>
		</tr>

	</form>

</table>

<%
	}
	asePool.freeConnection(conn,"gnrcmprt",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
