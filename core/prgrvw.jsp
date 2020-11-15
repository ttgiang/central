<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrvw.jsp	-	select names of coure reviewers
	*	TODO				if during invite of reviewers that we remove all, or cancel, then it's no longer in review
	*						need to reset to modify
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "prgrvw";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String selectedCampus = website.getRequestParameter(request,"selectedCampus","");
	if ((Constant.BLANK).equals(selectedCampus))
		selectedCampus = campus;

	// GUI
	String chromeWidth = "70%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Review Outline";
	String message = "";

	response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/inc/ajax.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	asePool.freeConnection(conn,"prgrvw",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
