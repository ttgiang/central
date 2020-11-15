<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsassidx.jsp
	*	2007.09.01	assessment index
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Assessment Method";
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
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '60%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	paging = null;

	String sql = aseUtil.getPropertySQL(session, "assessmentidx");
	if ( sql != null && sql.length() > 0 ){
		String campus = Util.getSessionMappedKey(session,"aseCampus");
		sql = aseUtil.replace(sql, "_sql_",campus);

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"crsass.jsp"));
		jqPaging = null;
	}

	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>