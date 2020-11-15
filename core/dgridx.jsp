<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dgridx.jsp - degree maintenance
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Degree Listing";
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
					{ sWidth: '20%' },
					{ sWidth: '40%' },
					{ sWidth: '40%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	if (processPage){

		String sql = aseUtil.getPropertySQL(session,"dgridx");

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"/central/core/dgr.jsp"));
		jqPaging = null;
	}

	paging = null;

	asePool.freeConnection(conn,"dgridx",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>