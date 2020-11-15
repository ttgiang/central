<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	catidx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Catalog Listing";
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
					{ sWidth: '40%' },
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

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String sql = aseUtil.getPropertySQL(session,"catidx");

	if ( sql != null && sql.length() > 0 ){
		sql = aseUtil.replace(sql, "_sql_", campus);
	}

	com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
	out.println(jqPaging.showTable(conn,sql,""));
	jqPaging = null;

	asePool.freeConnection(conn,"catidx",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>