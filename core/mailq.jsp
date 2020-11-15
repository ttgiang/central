<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	mailq.jsp
	*	2010.01.18	display user daily notification
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Daily Notification";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jqpaging").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '05%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
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
		String sql = aseUtil.getPropertySQL( session, "mailqueue" );
		if (sql != null && sql.length() > 0){

			out.println("<p align=\"left\">NOTE: DAILY in the CC column indicates this message was flagged for daily notification.");

			sql = sql.replace("_to_", user);
			sql = sql.replace("_campus_",campus);

			com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
			jqPaging.setOnClick("return hs.htmlExpand(this, { objectType: \'ajax\',width:600} )");
			String junk = jqPaging.showTable(conn,sql,"maillogx.jsp","jqpaging");
			out.println(junk.replace(",",", "));
			jqPaging = null;

			out.println("<br/><p align=\"left\"><a href=\"mailqx.jsp\" class=\"linkcolumn\">Confirm notifications</a>"
				+ "<br/><br/>Confirming receipt of notifications removes the reminder task from your task list."
				+ "</p>");
		}
	}

	paging = null;

	asePool.freeConnection(conn,"mailq",user);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>

