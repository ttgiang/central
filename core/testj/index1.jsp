<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	index.jsp
	*	2007.09.01
	**/

	String pageTitle = "Lastest News & Information";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	paging = new com.ase.paging.Paging();
	paging.setSQL( aseUtil.getPropertySQL( session, "index" ) );
	paging.setSorting(false);
	paging.setDetailLink("newsdtl.jsp");
	out.print( paging.showRecords( conn, request, response ) );
	paging = null;
	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>