<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsfldx.jsp - view outline raw data
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","crsfld");

	// GUI
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
	if (processPage){
		out.println(helper.listOutlineRawEdit(conn,campus,type,"crsfldy",idx));
		//out.println(helper.listOutlineRawEdit(conn,campus,type,"crsfldy",idx,"DIS","396"));
	}

	asePool.freeConnection(conn,"crsfldx",user);
%>

</body>
</html>
