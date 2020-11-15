<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crstst.jsp - view history and task for testing
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "System Tool";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String kix = website.getRequestParameter(request,"kix","");
	String alpha = "";
	String num = "";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#crstst_1").dataTable({
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
					{ sWidth: '05%' },
					{ sWidth: '10%' },
					{ sWidth: '15%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '20%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' }
				]
			});

			$("#crstst_2").dataTable({
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
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '25%' },
					{ sWidth: '15%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<p align="left">
<form name="aseForm" method="post" action="?">
	Kix: <input type="text" class="input" name="kix" value="<%=kix%>">
	<input type="submit" value="go" class="inputsmallgray">
</form>
</p>

<%
	String sql = aseUtil.getPropertySQL(session,"testHistory");
	if (sql != null && sql.length() > 0 ) {
		sql = aseUtil.replace(sql, "%_historyid_%", kix);
		sql = aseUtil.replace(sql, "%", "");

		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"","crstst_1"));
		jqPaging = null;

		out.println("<p>&nbsp;</p>");

		if (!kix.equals("")){
			String[] info = helper.getKixInfo(conn,kix);
			alpha = info[0];
			num = info[1];
		}

		sql = aseUtil.getPropertySQL(session,"testTask");
		sql = aseUtil.replace(sql, "%_campus_%", campus);
		sql = aseUtil.replace(sql, "%_alpha_%", alpha);
		sql = aseUtil.replace(sql, "%_num_%", num);
		sql = aseUtil.replace(sql, "%", "");

		jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"","crstst_2"));
		jqPaging = null;

	}

	paging = null;

	asePool.freeConnection(conn,"crstst",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>