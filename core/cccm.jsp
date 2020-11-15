<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cccm.jsp - show CCCM questions usedfs
	*	2010.11.03
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "100%";
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String pageTitle = "CCCM6100 Questions Used";
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<p align="center">
<%
	if (processPage){

		int showText = website.getRequestParameter(request,"st", 0);

		out.println(""
						+ "<a href=\"cccm.jsp?st=1\" class=\"linkcolumn\">show text (v1)</a>"
						+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
						+ "<a href=\"cccm.jsp?st=2\" class=\"linkcolumn\">show text (v2)</a>"
						+ "&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;"
						+ "<a href=\"cccm.jsp?st=0\" class=\"linkcolumn\">hide text</a>");

		out.println(CCCM6100DB.CCCMInUse(conn,showText));
	} // processPage

	asePool.freeConnection(conn,"cccm",user);

%>
</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
