<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dstidx.jsp
	*	2007.09.01	Distribution list
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","dstidx");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "Distribution Listing";
	fieldsetTitle = pageTitle;
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="./js/plugins/plugins.jsp" %>
	<link rel="stylesheet" type="text/css" href="../inc/csstable.css">

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
					{ sWidth: '80%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%

	if (processPage){

		String sql = aseUtil.getPropertySQL( session, "distribution" );
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "%%",campus);
		}

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		String dump = jqPaging.showTable(conn,sql,"/central/core/dstlst.jsp");
		if (dump != null){
			dump = dump.replace(",",", ");
		}
		out.print( dump );
		jqPaging = null;

	} // processPage

	paging = null;

	asePool.freeConnection(conn,"dstidx",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>