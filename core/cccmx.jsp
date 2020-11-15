<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

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

		boolean includeAll = false;

		int idx = website.getRequestParameter(request,"idx",0);
		int qn = website.getRequestParameter(request,"qn",0);

		String arg = "&qn="+qn;

		out.println("<table width=\'60%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' border=\'0\'>" );
		out.println("<tr><td  align=\"center\">" +  helper.drawAlphaIndex(idx,"CUR",includeAll,arg) + "</td></tr></table>" );

		if (idx > 0){
			out.println("<br/><table width=\'60%\' cellspacing='1' cellpadding='2' border=\'0\'>" );
			out.println("<tr><td  align=\"left\">" +  CCCM6100DB.displayCourseInUseByAlpha(conn,idx,qn) + "</td></tr></table>" );
		}
	} // processPage

	asePool.freeConnection(conn,"cccm",user);

%>
</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
