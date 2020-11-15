<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.ase.aseutil.Skew"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprdtex.jsp approver dates
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "apprdtex";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int route = website.getRequestParameter(request,"route", 0);

	boolean warning = false;

	String message = "";

	if (processPage){
		String formAction = website.getRequestParameter(request,"formAction","");
		String formName = website.getRequestParameter(request,"formName","");
		if ( formName != null && formName.equals("aseForm2") && "c".equalsIgnoreCase(formAction) ){
			if (route > 0){
				msg = ApproverDB.updateApprovalDates(conn,request,campus,route);
				if ("Exception".equals(msg.getMsg()) )
					message = "Update failed.";
				else if ("Warning".equals(msg.getMsg()) ){
					message = "Dates updated with warning(s).<br><br>"
						+ msg.getErrorLog();
						warning = true;
				}
				else
					message = "Dates updated successfully.";
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
<%
	if (!warning){
%>
	<form name="aseForm" action="apprdtey.jsp" method="post">
	Do you wish to enable approval by date?
	<%
		out.println(aseUtil.radioYESNO("0","approvalByDate",false));
	%>
	&nbsp;&nbsp;&nbsp;
	<input type="submit" name="cmdSubmit" value="Submit" class="input">
	<input type="hidden" value="<%=route%>" name="route">
	<input type="hidden" value="c" name="formAction">
	<input type="hidden" value="aseForm" name="formName">
	</form>
	<br><br>
	<div class="hr"></div>
	NOTE: By selecting to enable approval by date, all approvers are required to complete their approval by the specified
	end date or the outline, is by default, considered approved and forward on to the next approver.
<%
	}
%>
</p>

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
