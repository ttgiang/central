<%
	/**
	*	ASE
	*	exception.jsp
	*	2007.09.01
	**/

	response.sendRedirect("../exp/generalerror.jsp");

	String pageTitle = "Error";
	String fieldsetTitle = pageTitle;
%>
<%@ page language="java" %>
<%@ page isErrorPage="true" %>

<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>

<html>
<head>
	<%@ include file="../ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="..//../inc/footer.jsp" %>
</body>
</html>