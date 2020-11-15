<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsprgrs.jsp
	*	2007.09.01	Progress Report
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Outline Progress Report";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '55%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	paging = null;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String sql = aseUtil.getPropertySQL( session, "progressReport" );
	if ( sql != null && sql.length() > 0 ){
		sql = aseUtil.replace(sql, "%%",campus);

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		jqPaging.setUrlKeyName("kix");
		jqPaging.setTarget("1");
		out.println(jqPaging.showTable(conn,sql,"vwcrsy.jsp"));
		jqPaging = null;
	}

	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>