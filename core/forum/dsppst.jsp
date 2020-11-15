<%@ page import="org.apache.log4j.Logger"%>

<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	dsppst.jsp - print posts
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String thisPage = "forum/display";
	String pageTitle = "Message Board";

	fieldsetTitle = pageTitle;

	int fid = website.getRequestParameter(request,"fid",0);
	int mid = website.getRequestParameter(request,"mid",0);
	int itm = website.getRequestParameter(request,"itm",0);

%>

<html>
<head>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
	<link rel="stylesheet" type="text/css" href="inc/niceframe.css">
	<link rel="stylesheet" type="text/css" href="inc/forum.css">
</head>
<body topmargin="0" leftmargin="0">

<%
	out.println("<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"> "
		+ "<tr> "
		+ "<td width=\"05%\">&nbsp;</td> "
		+ "<td> "
		+ "<table width=\"100%\" border=\"1\" cellspacing=\"0\" cellpadding=\"0\"> "
		+ "<tr><td>" + Board.printChildren(conn,fid,itm,0,0,mid,user) + "</td></tr> "
		+ "</table>"
		+ "</td> "
		+ "</tr> "
		+ "</table>");

	asePool.freeConnection(conn,"dsppst",user);
%>

</body>
</html>
