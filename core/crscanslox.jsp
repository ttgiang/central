<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscanslox.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String message = "";
	String alpha = "";
	String num = "";

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
		kix = helper.getKix(conn,campus,alpha,num,"PRE");
	}

	if ( formName != null && formName.equals("aseForm") ){
		if ( "s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
			if ( alpha.length() > 0 && num.length() > 0 ){
				msg = SLODB.cancelSLOReview(conn,kix,user);
				if ("Exception".equals(msg.getMsg())){
					message = "SLO review cancellation failed.<br><br>" + msg.getErrorLog();
				}
				else if ( !"".equals(msg.getMsg()) ){
					message = "Unable to cancel SLO review.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
				}
				else{
					message = "SLO review cancelled successfully<br>";
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
	fieldsetTitle = "Cancelling SLO Review Request";

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
