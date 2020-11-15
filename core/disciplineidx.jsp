<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	disciplineidx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Discipline Listing";
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
					{ sWidth: '10%' },
					{ sWidth: '40%' },
					{ sWidth: '50%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	if(processPage){
		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,aseUtil.getPropertySQL(session,"disciplineidx"),""));
		jqPaging = null;
	} // processPage

	paging = null;

	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

