<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cccmy.jsp - show CCCM questions usedfs
	*	2010.11.03
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
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

		String alpha = website.getRequestParameter(request,"a","");
		String num = website.getRequestParameter(request,"n","");
		int idx = website.getRequestParameter(request,"idx",0);
		int qn = website.getRequestParameter(request,"qn",0);

		out.println("<br/><table width=\'80%\' cellspacing='1' cellpadding='2' border=\'0\'>" );
		out.println("<tr><td  align=\"left\">" +  CCCM6100DB.displayCourseInUseByFriendly(conn,alpha,num,qn) + "</td></tr>" );

		out.println("<tr><td  align=\"left\"><a href=\"cccmx.jsp?idx="+idx+"&type=CUR&qn="+qn+"\" class=\"linkcolumn\">select a different course outline</a></td></tr>" );

		out.println("</table>" );
	} // processPage

	asePool.freeConnection(conn,"cccmy",user);
%>
</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
