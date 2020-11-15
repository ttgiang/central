<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsdtes.jsp	- all dates for outlines
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Outline Dates";
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
	String sql = aseUtil.getPropertySQL(session,"getOutlineDates");
	String campus = (String)session.getAttribute("aseCampus");
	if (sql != null && sql.length() > 0){
		sql = aseUtil.replace(sql, "%%", (String)session.getAttribute("aseCampus"));
	}

	paging = new com.ase.paging.Paging();
	paging.setSQL( sql );
	paging.setScriptName("/central/core/crsexp.jsp");
	paging.setDetailLink("/central/core/vwcrs.jsp?t=CUR");
	paging.setUrlKeyName("cid");
	paging.setRecordsPerPage(99);

	int idx = website.getRequestParameter(request,"x", 0);
	if (idx>0){
		paging.setAlphaIndex(idx);
		paging.setNavigation(false);
	}

	paging.setShowAlphaIndex(true);
	out.print(paging.showRecords(conn, request, response));
	paging = null;

	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>