<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscrtw.jsp - create new
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String caller = "crscrtw";
	String pageTitle = "";
	fieldsetTitle = pageTitle;

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines how CC should behaves when reaching the last item for modification.");

	String alpha = website.getRequestParameter(request,"alpha","");
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
		out.println("<h3 class=\"subheader\">Approved outlines at " + campus + "</h3><br/><br/>");
		out.println(helper.listCampusOutlinesByType(conn,campus,alpha,"CUR"));
		out.println("<br/>");

		out.println("<h3 class=\"subheader\">Proposed outlines at " + campus + "</h3><br/><br/>");
		out.println(helper.listCampusOutlinesByType(conn,campus,alpha,"PRE"));
		out.println("<br/>");

		out.println("<h3 class=\"subheader\">Approved Outline numbers in use at other campuses</h3><br/><br/>");
		out.println(helper.listOutlineNumbersUsedByAlpha(conn,alpha,"CUR"));
		out.println("<br/>");

		out.println("<h3 class=\"subheader\">Proposed Outline numbers in use at other campuses</h3><br/><br/>");
		out.println(helper.listOutlineNumbersUsedByAlpha(conn,alpha,"PRE"));
	}

	asePool.freeConnection(conn,"crscrtw",user);
%>

</body>
</html>
