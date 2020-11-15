<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsacany.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String kix = "";
	String alpha = "";
	String num = "";
	String message = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	kix = website.getRequestParameter(request,"kix","");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
	}

	if ( formName != null && formName.equals("aseForm") ){
		if ("s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
			/*
				kix is the id from table course. we'll start using the id where applicable.
				to avoid trouble with older implementation, we use kix to get the alpha and
				num needed for this to continue on successfully.

				kix works when we come here from sltcrs. when coming from task, kix does
				not exists.
			*/

			if ( alpha.length() > 0 && num.length() > 0 ){
//msg = SLODB.cancelAssessment(conn,campus,kix,user);
//if ("Exception".equals(msg.getMsg())){
//	message = "Outline cancellation failed.<br><br>" + msg.getErrorLog();
//}
//else if ( !"".equals(msg.getMsg()) ){
//	message = "Unable to cancel outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
//}
//else{
//	message = "Outline cancelled successfully<br>";
//}
			}	// course alpha and num length
		}	// action = s
		else{
			message = "Invalid security code";
		}
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Cancel Assessment";

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
