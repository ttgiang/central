<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	vwslox.jsp - view outline SLO
	*	2007.09.01
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String caller = "";
	String pageTitle = "";
	fieldsetTitle = pageTitle;

	int idx = website.getRequestParameter(request,"idx",0);
	String type = website.getRequestParameter(request,"type");
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	out.println(helper.listOutlineSLOs(conn,type,idx));
	asePool.freeConnection(conn);
%>

</body>
</html>
