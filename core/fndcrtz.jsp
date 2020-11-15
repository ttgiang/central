<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcrtz.jsp	create new outline.
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "80%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "screen 4 of 4";
	fieldsetTitle = "Create Foundation Course";

	String kix = website.getRequestParameter(request,"kix","");
	String foundation = website.getRequestParameter(request,"foundation","");
	String assessment = website.getRequestParameter(request,"assessment","");
	String authors = website.getRequestParameter(request,"authors","");

	int id = 0;
	String message = "";

	if (processPage){
		id = com.ase.aseutil.fnd.FndDB.createFoundationCourse(conn,campus,user,kix,foundation,authors,assessment);
		message = "Foundation course created successfullly.<br/><br/> Click <a href=\"fndedt.jsp?id="+id+"\" class=\"linkcolumn\">here</a> to edit.";
	}
	else{
		message = "Unable to create foundation course.";
	}

	asePool.freeConnection(conn,"fndcrtz",user);

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

