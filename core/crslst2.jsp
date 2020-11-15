<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crslst2.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "";
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
					{ sWidth: '70%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%
	String sql = aseUtil.getPropertySQL( session, "courselisting" );

	if ( sql != null && sql.length() > 0 ){
		String alpha = website.getRequestParameter(request,"cr","");
		String num = website.getRequestParameter(request,"cn","");
		String campus = website.getRequestParameter(request,"cp","");
		String view = website.getRequestParameter(request,"cv","");

		sql = aseUtil.replace(sql, "_coursetype_", view);
		sql = aseUtil.replace(sql, "_camp_", campus);
		sql = aseUtil.replace(sql, "_alpha_", alpha);
		sql = aseUtil.replace(sql, "_num_", num);

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,""));
		jqPaging = null;

		paging = null;
	}

	asePool.freeConnection(conn);
%>

</body>
</html>