<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdltx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String alpha = "";
	String num = "";
	String message = "";

	String user = (String)session.getAttribute("aseUserName");
	String campus = (String)session.getAttribute("aseCampus");

	if ( formName != null && formName.equals("aseForm") ){
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
		if ( "s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
			if ( alpha.length() > 0 && num.length() > 0 ){
				msg = courseDB.deleteOutline(conn,campus,alpha,num,user);
				if ( "Exception".equals(msg.getMsg()) ){
					message = "Outline deletion failed.<br><br>";
				}
				else if ( !"".equals(msg.getMsg()) ){
					message = "Unable to delete outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
				}
				else{
					message = "Outline deleted successfully<br>";
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
	fieldsetTitle = "Outline Deleted";

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
