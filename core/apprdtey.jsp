<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.ase.aseutil.Skew"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprdtey.jsp approver dates
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "apprdtey";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int route = website.getRequestParameter(request,"route", 0);
	String approvalByDate = website.getRequestParameter(request,"approvalByDate", "0");

	String message = "";

	if (processPage){
		String formAction = website.getRequestParameter(request,"formAction","");
		String formName = website.getRequestParameter(request,"formName","");
		if ( formName != null && formName.equals("aseForm") && "c".equalsIgnoreCase(formAction) ){
			if (route > 0){
				int rowsAffected = IniDB.updateApprovalByDate(conn,campus,approvalByDate);
				if (rowsAffected < 1)
					message = "Update failed.";
				else
					message = "Approval by date updated successfully.";
			}
			else{
				message = "Invalid processing error";
			}
		}	// valid form
		else{
			message = "Invalid processing error";
		}
	}
	else{
		message = "Invalid processing error";
	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Approval Dates";
	fieldsetTitle = "Approval Dates";

	asePool.freeConnection(conn,thisPage,user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<p align="center"><%=message%>
<br><br>
<div class="hr"></div>
<p align="center">
<a href="apprdte.jsp?route=<%=route%>" class="linkcolumn">return</a> to previous screen
&nbsp;<font color="#c0c0c0">|</font>&nbsp;
<a href="appridx.jsp?route=<%=route%>" class="linkcolumn">return</a> to approver sequence
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
