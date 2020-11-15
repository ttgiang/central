<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsitmx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "80%";
	String pageTitle = "Maintain Outline Questions";
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsedt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<table border=0>
<%
	// course to work with
	int totalQuestions = website.getRequestParameter(request,"totalQuestions",0);

	for (int i=0; i<totalQuestions; i++){
		out.println( "<tr>" );
		out.println( "<td valign=\"top\">" + website.getRequestParameter(request,"number_" + (i+1),0) + "</td>" );
		out.println( "<td valign=\"top\">" + website.getRequestParameter(request,"question_" + (i+1),"")  + "</td>" );
		out.println( "</tr>" );
	}

	asePool.freeConnection(conn);

%>
</table>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
