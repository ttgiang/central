<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgcan.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Cancel Program";
	fieldsetTitle = pageTitle;

	String type = "PRE";

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
					{ sWidth: '30%' },
					{ sWidth: '10%' },
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
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	if (processPage){
		paging = new com.ase.paging.Paging();
		String sql = aseUtil.getPropertySQL(session,"prgidx7");
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_campus_", campus);
			sql = aseUtil.replace(sql, "_type_", "PRE");
			sql = aseUtil.replace(sql, "_user_", ""+user);
		}

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"/central/core/prgcanx.jsp","jqpaging"));
		jqPaging = null;

		paging = null;
	}

	asePool.freeConnection(conn,"prgcan",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>

<%@ page import="org.apache.log4j.Logger"%>
