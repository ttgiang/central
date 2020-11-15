<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cccmh.jsp - show CCCM questions help
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
	String pageTitle = "Campus Outline Help Text";
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
		out.println(CCCM6100DB.OutlineHelpText(conn));
	} // processPage

	asePool.freeConnection(conn,"cccmh",user);

%>
</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
