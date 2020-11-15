<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crssloapprcanx.jsp - cancelling SLO approval request
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String alpha = "";
	String num = "";
	String type = "";
	String message = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	alpha = website.getRequestParameter(request,"alpha","");
	num = website.getRequestParameter(request,"num","");
	type = website.getRequestParameter(request,"type","");

	if ( formName != null && formName.equals("aseForm") ){
		if ( "s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
			if ( alpha.length() > 0 && num.length() > 0 ){
				msg = SLODB.cancelSLOApproval(conn,campus,alpha,num,type,user);
				if ("Exception".equals(msg.getMsg())){
					message = "SLO approval cancellation failed.<br><br>" + msg.getErrorLog();
				}
				else if ( !"".equals(msg.getMsg()) ){
					message = "Unable to cancel SLO approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
				}
				else{
					message = "SLO approval cancelled successfully<br>";
				}
			}	// course alpha and num length
		}	// action = s
		else{
			message = "Invalid security code";
		}
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "SLO Review Cancelled";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="center"><%= message %></p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
