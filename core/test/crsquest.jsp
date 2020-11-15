<%@ include file="ase.jsp" %>

<%
	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		return;
	}

	String pageTitle = "Course Question Listing";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	com.ase.paging.Paging paging = new com.ase.paging.Paging();
	paging.setSQL( aseUtil.getPropertySQL( session, "tblCourseQuestions" ) );
	paging.setScriptName("/central/core/crsquest.jsp");
	paging.setDetailLink("/central/core/crsquestx.jsp");
	paging.setAllowAdd( false );
	paging.setRecordsPerPage( 99 );
	out.print( paging.showRecords( conn, request, response ) );
	paging = null;
	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>