<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	stats.jsp
	*	2007.09.01	display outline status (approval history, tasks, etc.)
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String userCampus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String campus = website.getRequestParameter(request,"c","");

	if (campus.equals("")){
		campus = userCampus;
	}

	String alpha = website.getRequestParameter(request,"a","");
	String num = website.getRequestParameter(request,"n","");
	String type = website.getRequestParameter(request,"t","");

	String kix = helper.getKix(conn,campus,alpha,num,type);

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#statsCourse").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '60%' },
				]
			});

			$("#statsComments1").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '20%' },
					{ sWidth: '40%' },
					{ sWidth: '40%' },
				]
			});

			$("#statsComments2").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '20%' },
					{ sWidth: '40%' },
					{ sWidth: '40%' },
				]
			});

			$("#statsApprovalHistory").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '20%' },
					{ sWidth: '40%' },
					{ sWidth: '40%' },
				]
			});

			$("#statsAssignedTasks").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '60%' },
				]
			});

			$("#statsReviewers").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bFilter": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '10%' },
					{ sWidth: '90%' },
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<p align="left">
	<form name="aseForm" method="post" action="?">
		<font class="textblackth">Campus:</font> <input type="text" name="c" value="<%=campus%>" class="input" size="10">
		&nbsp;&nbsp;&nbsp;<font class="textblackth">Alpha:</font> <input type="text" name="a" value="<%=alpha%>" class="input" size="10">
		&nbsp;&nbsp;&nbsp;<font class="textblackth">Num:</font> <input type="text" name="n" value="<%=num%>" class="input" size="10">
		&nbsp;&nbsp;&nbsp;
		<font class="textblackth">Type:</font>
		<select name="t" class="input">
			<option value="">-select</option>
			<option value="CUR" <% if ("CUR".equals(type)) { %>selected<% } %>>Approved</option>
			<option value="PRE" <% if ("PRE".equals(type)) { %>selected<% } %>>Proposed</option>
		</select>
		 &nbsp;&nbsp;&nbsp;<input type="submit" name="aseGo" value=" Go " class="inputsmallgray">
	</form>
</p>
<div class="hr"></div>
<%
	if (kix != null && kix.length() > 0){

		String sql = "";

		// APPROVERS
		int route = ApproverDB.getApprovalRouting(conn,campus,kix);
		String approvalName = ApproverDB.getRoutingNameByID(conn,campus,route);
		String approvers = ApproverDB.getApproversByRoute(conn,campus,route);

		com.ase.paging.JQPaging jqPaging = null;

		out.println("<p align=\"left\" class=\"textblackth\">Approvers ("+approvalName+")</p>");
		out.println("<p align=\"left\" class=\"datacolumn\">"
			+ approvers.replace(",",", ")
			+ "</p>");

		// COURSE
		out.println("<p align=\"left\" class=\"textblackth\">Course</p>");
		sql = aseUtil.getPropertySQL(session,"statsCourse");
		if (sql != null && sql.length() > 0){
			sql = aseUtil.replace(sql, "'%_kix_%'", aseUtil.toSQL(kix,Constant.CC_TEXT));

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","statsCourse"));
			jqPaging = null;
		}

		// APPROVAL HISTORY
		out.println("<p align=\"left\" class=\"textblackth\">Approval History</p>");
		sql = aseUtil.getPropertySQL(session,"statsApprovalHistory");
		if (sql != null && sql.length() > 0){
			sql = aseUtil.replace(sql, "'%_kix_%'", aseUtil.toSQL(kix,Constant.CC_TEXT));

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","statsApprovalHistory"));
			jqPaging = null;
		}

		// APPROVAL COMMENTS
		out.println("<p align=\"left\" class=\"textblackth\">Approver Comments</p>");
		sql = aseUtil.getPropertySQL(session,"statsComments");
		if (sql != null && sql.length() > 0){
			sql = aseUtil.replace(sql, "'%_kix_%'", aseUtil.toSQL(kix,Constant.CC_TEXT));
			sql = aseUtil.replace(sql, "'%_acktion_%'", aseUtil.toSQL(""+Constant.APPROVAL,Constant.CC_NUMBER));

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","statsComments1"));
			jqPaging = null;
		}

		// REVIEWER COMMENTS
		out.println("<p align=\"left\" class=\"textblackth\">Reviewer Comments</p>");
		sql = aseUtil.getPropertySQL(session,"statsComments");
		if (sql != null && sql.length() > 0){
			sql = aseUtil.replace(sql, "'%_kix_%'", aseUtil.toSQL(kix,Constant.CC_TEXT));
			sql = aseUtil.replace(sql, "'%_acktion_%'", aseUtil.toSQL(""+Constant.REVIEW,Constant.CC_NUMBER));

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","statsComments2"));
			jqPaging = null;
		}

		// ASSIGNED TASKS
		out.println("<p align=\"left\" class=\"textblackth\">Assigned Task</p>");
		sql = aseUtil.getPropertySQL(session,"statsAssignedTasks");
		if (sql != null && sql.length() > 0){
			sql = aseUtil.replace(sql, "%%", campus);
			sql = aseUtil.replace(sql, "'_alpha_'", aseUtil.toSQL(alpha,Constant.CC_TEXT));
			sql = aseUtil.replace(sql, "'_num_'", aseUtil.toSQL(num,Constant.CC_TEXT));

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","statsAssignedTasks"));
			jqPaging = null;
		}

		// REVIEWERS
		out.println("<p align=\"left\" class=\"textblackth\">Reviewers</p>");
		sql = aseUtil.getPropertySQL(session,"statsReviewers");
		if (sql != null && sql.length() > 0){
			sql = aseUtil.replace(sql, "%%", campus);
			sql = aseUtil.replace(sql, "'_alpha_'", aseUtil.toSQL(alpha,Constant.CC_TEXT));
			sql = aseUtil.replace(sql, "'_num_'", aseUtil.toSQL(num,Constant.CC_TEXT));

			jqPaging = new com.ase.paging.JQPaging();
			out.println(jqPaging.showTable(conn,sql,"","statsReviewers"));
			jqPaging = null;
		}
	}

	paging = null;

	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
