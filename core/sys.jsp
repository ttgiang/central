<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	sys.jsp	system values
	*	2007.09.01
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = "System Settings";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="./js/plugins/plugins.jsp" %>
	<link rel="stylesheet" type="text/css" href="../inc/csstable.css">
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){

		// DO NOT USE jquery here until we resolve
		// problem with spaces added to data
		String useJquery = Constant.OFF;

		if (useJquery.equals(Constant.OFF)){
			String sql = aseUtil.getPropertySQL(session,"sys");
			paging = new com.ase.paging.Paging();
			paging.setSQL(sql);
			paging.setScriptName("/central/core/sys.jsp");
			paging.setDetailLink("/central/core/sysmod.jsp");
			paging.setRecordsPerPage(99);
			paging.setAllowAdd(true);
			paging.setSorting(false);
			out.print( paging.showRecords( conn, request, response ) );
			paging = null;
		}
		else{
			out.println(SysDB.drawSysEditTable(conn,campus));
			out.println("<br><a href=\"sysmod.jsp?lid=0\" class=\"button\"><span>Create new entry</span></a><br><br>");
		}
	}

	asePool.freeConnection(conn,"sys",user);

%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>