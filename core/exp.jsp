<%@ include file="ase.jsp" %>
<%@ page import="com.ase.exception.*"%>

<%
	/**
	*	ASE
	*	exp.jsp - uses to help push forum time out back up a level
	*	2007.09.01
	**/

	response.sendRedirect("../exp/notauth.jsp");

	String pageTitle = "Exception";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<p align="left">
<%
	asePool.freeConnection(conn,"exp",user);
%>
</p>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
