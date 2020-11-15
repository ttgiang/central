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
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/help.js"></script>
	<SCRIPT language=javascript src="../menuh/sniffer.js"></SCRIPT>
	<SCRIPT language=javascript1.2 src="../menuh/custom.js"></SCRIPT>
	<SCRIPT language=javascript1.2 src="../menuh/style.js"></SCRIPT>
</head>
<body topmargin="0" leftmargin="0" background="images/stripes.png">
<SCRIPT language=javascript1.2 src="../menuh/menu.js"></SCRIPT>
<%@ include file="../inc/header5.jsp" %>
<%
	paging = new com.ase.paging.Paging();
	String sql = 	aseUtil.getPropertySQL( session, "index" );

	if ( sql != null ){
		// display news with active dates for next 2 weeks
		String startDate = aseUtil.addToDate(0);
		String endDate = aseUtil.addToDate(14);
		String temp = "";
		String dataType = (String)session.getAttribute("aseDataType");

		if ( "Access".equals(dataType) )
			temp = "(enddate <= #" + endDate + " 23:59:59#)";
		else
			temp = "(enddate <= to_date('" + endDate + "', 'mm/dd/yyyy'))";

		sql = sql.replace("_date_", temp );

		paging.setSQL( sql );
		paging.setSorting(false);
		paging.setDetailLink("newsdtlx.jsp");
		paging.setOnClick("return getHelpNewsIndex('<| link |>');");
		paging.setRecordsPerPage(99);
		out.print( paging.showRecords( conn, request, response ) );
		paging = null;
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/footer5.jsp" %>

<div id="help_container" class="popHide"></div>

</body>
</html>