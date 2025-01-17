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
	<%@ include file="highslide.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/help.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	paging = new com.ase.paging.Paging();
	String sql = 	aseUtil.getPropertySQL( session, "index" );

	if ( sql != null ){
		// display news with active dates for next 2 weeks
		String startDate = aseUtil.addToDate(0);
		String endDate = aseUtil.addToDate(14);
		String temp = "(startdate <= #" + startDate + "# AND enddate <= #" + endDate + " 23:59:59#)";
		sql = sql.replace("_date_", temp );
		out.println( sql );
		paging.setSQL( sql );
		paging.setSorting(false);
		paging.setDetailLink("newsdtlx.jsp");
		//paging.setOnClick("return hs.htmlExpand(this, { objectType: \'ajax\'} )");
		paging.setOnClick("return getHelp(8);");
		paging.setRecordsPerPage(99);
		out.print( paging.showRecords( conn, request, response ) );
		paging = null;
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer.jsp" %>

<div id="help_container" class="popHide"></div>

</body>
</html>