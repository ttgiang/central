<%@ include file="ase.jsp" %>
<%
	/**
	*	ASE
	*	crslg.jsp - cc log
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "User Tasks";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<%
	String year = website.getRequestParameter(request,"y","");
	String month = website.getRequestParameter(request,"m","");
	String hour = website.getRequestParameter(request,"h","");
	String day = website.getRequestParameter(request,"d","");
	String sql = "";
%>

<form method="post" action="?" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					<input type="text" size="3" class="input" maxlength="4" value="<%=year%>" name="y">
					<input type="text" size="3" class="input" maxlength="2" value="<%=month%>" name="m">
					<input type="text" size="3" class="input" maxlength="4" value="<%=hour%>" name="h">
					<input type="text" size="3" class="input" maxlength="2" value="<%=day%>" name="d">
					<input title="continue with request" type="submit" value=" go " class="inputsmallgray">&nbsp;
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%
	switch(d){
		case 0:
			paging = new com.ase.paging.Paging();
			paging.setSQL(aseUtil.getPropertySQL(session,"ccLogYear"));
			paging.setDetailLink("/central/core/crslg.jsp?d=1");
			paging.setRecordsPerPage(99);
			paging.setSorting( false );
			out.print( paging.showRecords( conn, request, response ) );
			paging = null;
			break;
		case 1:
			sql = aseUtil.getPropertySQL(session,"ccLogMonth");
			sql = sql.replace("_year_",year);
			paging = new com.ase.paging.Paging();
			paging.setSQL(sql);
			paging.setDetailLink("/central/core/crslg.jsp?d=2");
			paging.setRecordsPerPage(12);
			paging.setSorting( false );
			out.println("Year: " + year);
			out.print( paging.showRecords( conn, request, response ) );
			paging = null;
			break;
		case 2:
			sql = aseUtil.getPropertySQL(session,"ccLogDay");
			sql = sql.replace("_year_",year);
			sql = sql.replace("_month_",month);
			paging = new com.ase.paging.Paging();
			paging.setSQL(sql);
			paging.setDetailLink("/central/core/crslg.jsp?d=3");
			paging.setRecordsPerPage(31);
			paging.setSorting( false );
			out.println("Year: " + year + " Month: " + month);
			out.print( paging.showRecords(conn,request,response));
			paging = null;
			break;
		case 3:
			sql = aseUtil.getPropertySQL(session,"ccLogHour");
			sql = sql.replace("_year_",year);
			sql = sql.replace("_month_",month);
			sql = sql.replace("_day_",month);
			paging = new com.ase.paging.Paging();
			paging.setSQL(sql);
			paging.setDetailLink("/central/core/crslg.jsp?d=4");
			paging.setRecordsPerPage(25);
			paging.setSorting( false );
			out.println("Year: " + year + " Month: " + month + " Day: " + day + " Hour: " + hour);
			out.print( paging.showRecords(conn,request,response));
			paging = null;
			break;
	}

	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
