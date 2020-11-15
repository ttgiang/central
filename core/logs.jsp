<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.satiri.tomcatlogviewer.*,java.io.*,java.lang.*" %>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	logs.jsp	view CC log
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "CC Logs";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<table width="100%" border="0">
<tr>
<td>
<%
	if (processPage && SQLUtil.isSysAdmin(conn,user)){
		String realPath = getServletContext().getRealPath("/");
		String filelog = realPath + "logs\\ccv2.log";
		LogViewer lv = new LogViewer(filelog);
		out.print(lv.getLog(100));
	}

	asePool.freeConnection(conn,"logs",user);
%>
</td>
</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
