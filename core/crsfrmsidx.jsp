<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsfrmsidx.jsp
	*	2007.09.01	forms index
	**/

	String pageTitle = "Additional Forms Listing";
	fieldsetTitle = pageTitle;

	session.setAttribute("aseThisPage","crsfrmsidx");

	boolean userMaintenance = true;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

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
	// paging exists as a global create
	paging = null;

	String sql = aseUtil.getPropertySQL(session,"frmsidx");
	if ( sql != null && sql.length() > 0 ) {
		sql = aseUtil.replace(sql, "_sql_", campus);

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"crsfrms.jsp"));
		jqPaging = null;
	}

	asePool.freeConnection(conn,"crsfrmsidx.jsp",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
