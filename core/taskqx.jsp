<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	taskqx.jsp
	*	2010.01.18	display user task notification
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Task Notification";
	fieldsetTitle = pageTitle;

	String message = "";

	int rowsAffected = 0;

	if (processPage){
		String kix = website.getRequestParameter(request,"kix","");

		if (ProgramsDB.isAProgram(conn,kix)){
			rowsAffected = TaskDB.removeTask(conn,campus,kix,user,Constant.PROGRAM_APPROVED_TEXT);
		}
		else{
			rowsAffected = TaskDB.removeTask(conn,campus,kix,user,Constant.APPROVED_TEXT);
		}

		message = rowsAffected + " message(s) processed.";
	}
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
