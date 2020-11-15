<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crspslow.jsp - PSLO
	*
	* 	NOTE: This code is also in use by PGRM.jsp
	*
	*	2007.09.01
	**/

	// authorized to assess?
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String caller = "crscrtw";
	String pageTitle = "";
	fieldsetTitle = pageTitle;

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
	//String PSLO = ListsDB.showListBySourceAlpha(conn,campus,Constant.COURSE_PROGRAM_SLO,alpha);
	String PSLO = ValuesDB.getListBySrcSubTopic(conn,campus,Constant.COURSE_PROGRAM_SLO,alpha);
	if (PSLO != null && PSLO.length() > 0){
		out.println("<br/><font class=\"textblackth\">Program SLO</font><br/><br/>");
		out.println("<font class=\"datacolumn\">" + PSLO + "</font>");
	}

	asePool.freeConnection(conn,"crspslow",user);
%>

</body>
</html>
