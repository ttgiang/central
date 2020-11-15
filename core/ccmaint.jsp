<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tasks.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("")){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "CC Maintenance";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		out.println("Please be reminded that the Curriculum Central Scheduled Server Maintenance is on Sunday nights from 10PM to 12AM.");
	}

	asePool.freeConnection(conn,"ccmaint",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
