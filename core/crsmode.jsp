<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crsmode.jsp - mode maintenance
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Course Process Maintenance";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		out.println(ModeDB.listModes(conn,campus));
		//out.println("<br/><p align=\"left\"><img src=\"../images/add.gif\" border=\"0\">");
		//out.println("<a href=\"crsmodew.jsp\" class=\"linkcolumn\">add process</a></p>");
	}

	asePool.freeConnection(conn,"crsmode",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
