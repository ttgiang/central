<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tasks.jsp
	*	2007.09.01	user tasks
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("")){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "tasks";
	session.setAttribute("aseThisPage",thisPage);

	String pageTitle = "Foundation - work in progress";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="./js/modal/modalnews.jsp" %>
</head>

<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	String user = Util.getSessionMappedKey(session,"aseUserName");
%>

	<img src="../images/construction.gif" />

<%
	asePool.freeConnection(conn,"tasks",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>

