<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	index.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if (!aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals(Constant.BLANK)){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "index";
	session.setAttribute("aseThisPage",thisPage);

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "News & Information";
	fieldsetTitle = pageTitle;

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines where user lands after log in (task list or news and information - StartPage)");
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">

	<%@ include file="./js/modal/modalnews.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#jquery").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bJQueryUI": true,
				"aaSorting": [[0, "desc"]],
				"bRetrieve": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bInfo": false
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0" background="images/stripes.png">

<%@ include file="../inc/header.jsp" %>
<%
	if (processPage){

		// having trouble with keeping the CSS in place using a nice color scheme.
		// see (version 2) of class code
		int version = 1;

		out.println(NewsDB.listNewsJQuery(conn,campus,version));

		out.println("<p align=\"left\">");

		long countUserTasks = TaskDB.countUserTasks(conn,campus,user);
		if (countUserTasks > 0){
			out.println("<img src=\"../images/insert_table.gif\" border=\"\" alt=\"news maintenance\">&nbsp;<a href=\"tasks.jsp\" class=\"linkcolumn\">there are " + countUserTasks + " items on your task list</a>");
		}

		if (SQLUtil.isCampusAdmin(conn,user) || SQLUtil.isSysAdmin(conn,user)){
			out.println("&nbsp;&nbsp;<font class=\"copyright\">|</font>&nbsp;&nbsp;<img src=\"../images/tool.gif\" border=\"\" alt=\"news maintenance\">&nbsp;<a href=\"newsidx.jsp\" class=\"linkcolumn\">news maintenance</a>");
		}

		out.println("</p>");

	}

	asePool.freeConnection(conn,"index",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>