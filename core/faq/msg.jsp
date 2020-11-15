<%@ include file="../ase.jsp" %>

<%
	/**
	*	ASE
	*	bb.jsp - create program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp.jsp");
		processPage = false;
	}

	String pageTitle = "Curriculum Central Answers!";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	int id = (Integer)session.getAttribute("aseFAQId");

	String message = (String)session.getAttribute("aseApplicationMessage");
%>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="inc/style.css">
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../../inc/header.jsp" %>
<%@ include file="inc/header.jsp" %>

<p>&nbsp;</p>

<p align="left">
<%
	if (processPage){
%>
		<%=message%>
<%

		out.println("<p align=\"left\"><a href=\"faq.jsp\" class=\"linkcolumn\">View CC Asnwers!</a>");

	} // processPage

	session.setAttribute("aseApplicationMessage", "");

	asePool.freeConnection(conn,"ask",user);
%>

</p>

<%@ include file="inc/footer.jsp" %>
<%@ include file="../../inc/footer.jsp" %>

</body>
</html>