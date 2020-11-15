<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwcrs.jsp
	*	2007.09.01	displays content of course for debugging or viewing purposes
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "90%";
	String pageTitle = "";

	String alpha = website.getRequestParameter(request,"alpha");
	String num = website.getRequestParameter(request,"num");;

	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		response.sendRedirect("sltcrs.jsp?cp=crsvw");
	}

	String viewOption = website.getRequestParameter(request,"view");;

	if ( viewOption != null && viewOption.length() > 0 ){
		pageTitle = "Display " + viewOption + " Course Data";
		fieldsetTitle = pageTitle;
	}
	else{
		viewOption = "CUR";
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if ( ( alpha == null || alpha.length() == 0 ) && ( num == null || num.length() == 0) ){
		out.println( "<br><p align=\'center\'>Invalid Request.</p>" );
	}
	else{
		response.sendRedirect( "vwcrs.jsp?alpha=" + alpha + "&num=" + num + "&t=" + viewOption );
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
