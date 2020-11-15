<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	stmtidx.jsp
	*	2007.09.01	generic statements used for all reasons
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","stmtidx");

	String pageTitle = "Statement Listing";
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
				"iDisplayLength": 20,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '20%' },
					{ sWidth: '15%' },
					{ sWidth: '65%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if(processPage){
		String sql = aseUtil.getPropertySQL( session, "stmtidx" );
		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"/central/core/stmt.jsp"));
		jqPaging = null;
	}

	paging = null;
	asePool.freeConnection(conn);

%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>