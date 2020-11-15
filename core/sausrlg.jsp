<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sausrlg.jsp
	*	2007.09.01	user log
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "User Activity Log";
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
	out.println(helper.showLog(conn,campus,"user"));
	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
