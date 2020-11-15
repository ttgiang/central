<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslnkdzz.jsp	course linked item matrix
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Linked Outline Item Matrix";
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

	int rowsAffected = LinkedUtil.updateLinkedItemMatrix(request,conn,campus);

	if (rowsAffected == 1)
		out.println("Linked item matrix saved successfullly.");
	else
		out.println("Error saving linked item matrix.");

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
