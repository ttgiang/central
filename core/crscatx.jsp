<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscat.jsp - course catalog
	*	2007.09.01
	**/

	boolean processPage = true;

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String caller = "crsassr";
	String pageTitle = "";
	fieldsetTitle = pageTitle;

	int idx = website.getRequestParameter(request,"idx",0);

	String discipline = website.getRequestParameter(request,"type","");
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){
		if (!discipline.equals(Constant.BLANK) || idx > 0){
			out.println(SyllabusDB.listCatalog(conn,campus,idx,discipline));
		}
	} // processPage

	asePool.freeConnection(conn,"crscatx",user);
%>

</body>
</html>
