<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.ase.aseutil.Skew"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	notesx.jsp 	- add notes
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "notesx";
	session.setAttribute("aseThisPage",thisPage);

	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campus = website.getRequestParameter(request,"aseCampus","",true);

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Add Notes";
	fieldsetTitle = pageTitle;

	String message = "";
	int route = website.getRequestParameter(request,"route",0);
	String note = website.getRequestParameter(request,"note","",false);
	String submitTest = website.getRequestParameter(request,"aseSubmitTest","",false);

	int rowsAffected = IniDB.updateNote(conn,route,note,user);

	if (rowsAffected == 1){
		message = "Note updated successfully.";

		MailerDB mailerDB = new MailerDB(conn,user,campus,"emailOutlineApprovalRequest",route,user);

		if (submitTest != null && "Submit & Test".equals(submitTest))
			message = "Notes updated successfully and a sample email was sent to "
				+ user
				+ "@"
				+ SysDB.getSys(conn,"domain")
				+ ".";
	}
	else
		message = "Fail to update note";

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsacanx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<p align="center">
<%=message%>
<br/><br/>
return to <a href="appridx.jsp?pageClr=1" class="linkcolumn">approver sequence</a>
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
