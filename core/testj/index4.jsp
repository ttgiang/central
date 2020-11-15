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
</head>
<body background="images/stripes.png">
<DIV id=container>
	<DIV id=header><%@ include file="../inc/menu.jsp" %></DIV>
	<DIV id=content>
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
	</DIV>
	<DIV id=footer><%@ include file="../inc/footerx.jsp" %></DIV>
</DIV>

<div id="help_container" class="popHide"></div>

</body>
</html>
