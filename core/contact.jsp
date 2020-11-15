<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	contact.jsp
	*	2007.09.01	name of contact staff
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Contact";
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
	out.println(helper.getContactStaff(conn,campus));
	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
