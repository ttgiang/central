
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccconfig.jsp
	*	2009.12.20
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Configure Curriculum Central";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		out.println(Util.configureCC(conn,campus));
	} // processPage

	asePool.freeConnection(conn,"ccconfig.jsp",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
