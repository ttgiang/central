<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	mailqx.jsp
	*	2010.01.18	display user daily notification
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Daily Notification";
	fieldsetTitle = pageTitle;

	String message = "";

	if (processPage){
		int rowsAffected = MailerDB.confirmNotification(conn,campus,user);
		message = rowsAffected + " message(s) processed.";
	}

	asePool.freeConnection(conn,"mailqx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	out.println( "<br><p align='center'>" + message + "</p>" );
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
