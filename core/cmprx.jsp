<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cmprx.jsp	outline copy/compare
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Copy Outline Items";
	fieldsetTitle = pageTitle;

	String ts = website.getRequestParameter(request,"ts","");
	String as = website.getRequestParameter(request,"as","");
	String ns = website.getRequestParameter(request,"ns","");

	String td = website.getRequestParameter(request,"td","");
	String ad = website.getRequestParameter(request,"ad","");
	String nd = website.getRequestParameter(request,"nd","");

	String kixSource = helper.getKixFromOldCC(conn,campus,as,ns,ts);
	String kixDestination = helper.getKix(conn,campus,ad,nd,td);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/cmprx.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	if (kixSource.length() > 0 && kixDestination.length() > 0){
		msg = Outlines.showOutlineItems(conn,kixSource,kixDestination,user);
		out.println(msg.getErrorLog());
	}
	else{
		out.println("Invalid SOURCE and/or DESTINATION outline.<br/><br/>"
			+ "Click <a href=\"cmpr.jsp\" class=\"linkcolumn\">here</a> to try again.");
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

