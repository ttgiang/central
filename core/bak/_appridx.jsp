<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	appridx.jsp
	*	2007.09.01	names of approvers
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String pageTitle = "Approver Sequence Listing";
	fieldsetTitle = pageTitle;
	String display = website.getRequestParameter(request,"dsp","");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	if ( display != null && display.length() > 0 ){
%>
	<%@ include file="../inc/headerli.jsp" %>
<%
	}
	else{
%>
	<%@ include file="../inc/header.jsp" %>
<%
	}
	paging = new com.ase.paging.Paging();
	String sql = aseUtil.getPropertySQL( session, "approver" );
	if ( sql != null && sql.length() > 0 ){
		sql = aseUtil.replace(sql, "%%", (String)session.getAttribute("aseCampus"));
	}
	paging.setSQL( sql );
	paging.setScriptName("/central/core/appridx.jsp");
	paging.setDetailLink( "/central/core/appr.jsp" );
	paging.setAllowAdd(true);
	paging.setRecordsPerPage(99);
	paging.setSorting(false);
	out.print( paging.showRecords( conn, request, response ) );
	paging = null;
	asePool.freeConnection(conn);

	if ( display != null && display.length() > 0 ){
%>
	<%@ include file="../inc/footerli.jsp" %>
<%
	}
	else{
%>
	<%@ include file="../inc/footer.jsp" %>
<%
	}
%>

</body>
</html>