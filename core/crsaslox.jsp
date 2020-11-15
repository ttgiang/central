<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsaslox.jsp - outline modifications (NOT USED)
	*	2007.09.01
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String caller = "crsaslo";
	String pageTitle = "";
	fieldsetTitle = pageTitle;

	int idx = website.getRequestParameter(request,"idx",0);
	String type = website.getRequestParameter(request,"type");
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%
	out.println(helper.listOutlineSLOs(conn,campus,user,type,"crsslo",idx));
	asePool.freeConnection(conn);
%>
</body>
</html>
