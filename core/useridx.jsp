<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	useridx.jsp
	*	2007.09.01	user index. different from banner in that it holds specifics for CC
	**/

	boolean processPage = true;

	String pageTitle = "User Listing";
	fieldsetTitle = pageTitle;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}
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
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '25%' },
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '05%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<form name="aseForm" action="?" method="post">
	User ID: <input name="userID" class="logininput" type="text">
	<input type="submit" value="Find" name="cmdSubmit" style="border: 1px solid #336699">
</form>
<br>

<%
	String sql = aseUtil.getPropertySQL(session,"useridx");
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = website.getRequestParameter(request,"userID", "");

	if (processPage && sql != null && sql.length() > 0 ) {

		if ( session.getAttribute("aseUserRights").toString() != null &&
			Integer.parseInt((String)session.getAttribute("aseUserRights")) == aseUtil.SYSADM ){
				sql = aseUtil.replace(sql, "_sql_", "%");
		}

		if ( user.length() > 0 ){
			sql = sql + " AND userid='" + user + "'";
		}

		sql = aseUtil.getPropertySQL(session,"useridx2");
		sql = aseUtil.replace(sql, "_campus_", campus);
		sql = aseUtil.replace(sql, "_index_", user);

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"/central/core/usr.jsp"));
		jqPaging = null;
	}

%>

		<br><a href="usr.jsp?lid=0" class="button"><span>Add User</span></a>

<%

	paging = null;

	asePool.freeConnection(conn,"useridx",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
