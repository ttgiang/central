<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cccm6100.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "100%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "View CCCM6100 Questions "
				+ "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"/central/servlet/progress\" target=\"_blank\"><img src=\"../images/printer.gif\" border=\"0\" alt=\"print screen listing\"></a>";

	fieldsetTitle = "View CCCM6100 Questions";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsedt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<p align="center">
<%
	if (processPage){
		session.setAttribute("aseReport","cccm6100Report");

		out.println(CCCM6100DB.getCCCM6100s(conn));
	}

	asePool.freeConnection(conn,"cccm6100",user);

%>
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
