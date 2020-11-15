<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ini.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "System Settings";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/systemlist.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%

	if (processPage){
		int id = website.getRequestParameter(request,"id",0);

		String val = website.getRequestParameter(request,"val","");

		int rowsAffected = IniDB.updateIni(conn,id,val,user);
	}

	asePool.freeConnection(conn,"testeditx",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>