<%@ include file="ase.jsp" %>
<%@ page import="java.io.File"%>

<%
	/**
	*	ASE
	*	usry.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String usr = website.getRequestParameter(request,"usr", "");


	String pageTitle = "Work in Progress";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	out.println("<table width=600 border=0 cellpadding=4 bgcolor=f0ffff>"
			+ "<tr><td class=\"datacolumn\">"
			+ 	"The following are work in progress for " + usr + "<br><br>"
			+ 	UserDB.showWorkInProgress(conn,campus,usr)
			+ "</td></tr>"
			+ "</table>");

	asePool.freeConnection(conn,"usry",user);
%>

