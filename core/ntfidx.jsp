<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ntfidx.jsp
	*	2007.09.01	notification maintenance
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Notification Listing";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 20,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '30%' },
					{ sWidth: '40%' },
					{ sWidth: '15%' },
					{ sWidth: '15%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){
		String sql = aseUtil.getPropertySQL(session,"propidx2");
		sql = sql.replace("_campus_", campus).replace("%%", campus);
		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"/central/core/ntf.jsp"));
		jqPaging = null;
	}

	paging = null;

	asePool.freeConnection(conn,"ntfidx",user);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>