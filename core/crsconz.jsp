<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsconz.jsp - content --> slo --> assessment
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "80%";
	String pageTitle = "Linked Outline Items";
	String user = website.getRequestParameter(request,"aseUserName","",true);
	fieldsetTitle = pageTitle;

	String kix = website.getRequestParameter(request,"kix");

	String[] statusTab = null;
	statusTab = courseDB.getCourseDates(conn,kix);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%@ include file="crsedt9.jsp" %>

<hr size=0>
<%
	if (!"".equals(kix)){
		out.println(LinkerDB.getLinkedOutlineContent(conn,kix));
	}

	asePool.freeConnection(conn,"crscon",user);
%>

<p><p>&nbsp;</p>
<div class="hr"></div>
Note: This page shows the connection between contents (<b>BOLD</b>) to SLOs & Competencies (<i>ITALICIZE</i>) to method of evaluations and assessments.
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
