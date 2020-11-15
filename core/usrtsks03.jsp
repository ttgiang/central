<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	usrtsks03.jsp
	*	2007.09.01	delete user tasks
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Delete User Task";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/usrtsks02.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = website.getRequestParameter(request,"sid", "");

	String message = "";

	int id = website.getRequestParameter(request,"id", 0);

	int rowsAffected = 0;

	if (processPage && id > 0){
		rowsAffected = TaskDB.deleteTaskByID(conn,id);
		if (rowsAffected > 0){
			message = "Task deleted successfully.";
		}
		else{
			message = "Unable to delete task.";
		}

		message += "<br><br><a href=\"usrtsks.jsp?sid="+user+"\" class=\"linkcolumn\">return</a> to user task listing";
	}

	asePool.freeConnection(conn,"usrtsks03",user);
%>

<h3 class="subheader"><%=message%></h3>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
