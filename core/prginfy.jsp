<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prginfy.jsp	- all about a program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String alpha = "";
	String type = "";
	String num = "";
	String campus = "";
	int route = 0;

	String myCampus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
		type = info[Constant.KIX_TYPE];
		campus = info[Constant.KIX_CAMPUS];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
	}

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Program Detail: " + pageTitle;
	paging = new com.ase.paging.Paging();
	String sql = "";

	// hide comes from approver status where we hide the menu when popping up new window
	String chromeWidth = "98%";
	int hide = website.getRequestParameter(request,"h",0);

	asePool.freeConnection(conn,"prginfy",user);

	conn = asePool.createLongConnection();
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript" src="js/help.js"></script>
	<%@ include file="../inc/expand.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#showCompletedApprovals").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 50,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '05%' },
					{ sWidth: '10%' },
					{ sWidth: '25%' },
					{ sWidth: '20%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '10%' }
				]
			});

			$("#showPendingApprovals").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 50,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '05%' },
					{ sWidth: '15%' },
					{ sWidth: '35%' },
					{ sWidth: '30%' },
					{ sWidth: '15%' }
				]
			});

			$("#actionlog").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 20,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[4, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{"bVisible": false},
					{ sWidth: '15%' },
					{ sWidth: '15%' },
					{ sWidth: '45%' },
					{ sWidth: '15%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%
	if (hide==1){
%>
<%@ include file="../inc/chromeheader.jsp" %>
<%
	}
	else{
%>
<%@ include file="../inc/header.jsp" %>
<%
	}
%>

<!---------------------------------	main menu --------------------------------------------->
<table border="0" width="100%">
	<tr valign="TOP">
		<td align="center">
				<a href="#approval_history" class="linkcolumn" title="view outline approval history">Approval History</a><font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
				<a href="#approver_comments" class="linkcolumn" title="view outline approval history">Approver Comments</a><font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
				<a href="#approved_status" class="linkcolumn" title="view outline approval status">Approval Status</a><font class="copyright">&nbsp;&nbsp;|&nbsp;&nbsp;</font>
				<a href="#actionlog" class="linkcolumn" title="view action log">Action Log</a>
		</td>
	</tr>
</table>

<!---------------------------------	approval history --------------------------------------------->

<br/>
<table border="0" width="100%" class="tableCaption">
	<tr>
		<td align="left"><a style="text-decoration:none" name="approval_history" class="linkcolumn">Approval History</a></td>
		<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td colspan="2">
			<table border="0" cellpadding="2" width="100%">
				<%
					ArrayList list = HistoryDB.getHistories(conn,kix,type);
					if (list != null){
						History history;
						for (int i=0; i<list.size(); i++){
							history = (History)list.get(i);
							out.println("<tr class=\"textblackTH\"><td valign=top>" + history.getDte() + " - " + history.getApprover() + "</td></tr>" );
							out.println("<tr><td valign=top>" + history.getComments() + "</td></tr>" );
						}
					}
				%>
			</table>
		</td>
	</tr>
</table>

<!---------------------------------	reviewer comments --------------------------------------------->

<br/>
<table border="0" width="100%" class="tableCaption">
	<tr>
		<td align="left"><a style="text-decoration:none" name="review_history" class="linkcolumn">Approval Comments</a></td>
		<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td colspan="2">
			<%
				out.println(ReviewerDB.getReviewHistory(conn,kix,0,campus,0,Constant.REVIEW));
			%>
		</td>
	</tr>
</table>

<!---------------------------------	approval status --------------------------------------------->
<br/>
<table border="0" width="100%" class="tableCaption">
	<tr>
		<td align="left"><a style="text-decoration:none" name="approved_status" class="linkcolumn">Approval Status</a></td>
		<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td colspan="2">
			<%
					out.println("<font class=\"textblackTH\">Completed approvals</font>");
					msg = ApproverDB.showCompletedApprovals(conn,campus,alpha,num);
					out.println(msg.getErrorLog());
					out.println( "<br/>" );
					out.println("<font class=\"textblackTH\">Pending approvals</font>");
					out.println(ApproverDB.showPendingApprovals(conn,campus,alpha,num,msg.getMsg(),route));
			%>
		</td>
	</tr>
</table>

<!--------------------------------- Action log --------------------------------------------->

<br/>
<table border="0" width="100%" class="tableCaption">
	<tr>
		<td align="left"><a style="text-decoration:none"  name="actionlog" class="linkcolumn">Action Log</a></td>
		<td align="right"><a href="#top" class="linkcolumn">back to top</a></td>
	</tr>
</table>

<%
	sql = aseUtil.getPropertySQL(session, "actionlog" );
	if ( sql != null && sql.length() > 0 ){
		sql = aseUtil.replace(sql, "_kix_", kix);
		com.ase.paging.JQPaging jqPaging = new com.ase.paging.JQPaging();
		out.println(jqPaging.showTable(conn,sql,"","actionlog"));
		jqPaging = null;

		paging = null;
	}
%>

<%
	try{
		if (conn != null){
			conn.close();
			conn = null;
		}
	}
	catch(Exception e){
		//logger.fatal("Tables: campusOutlines - " + e.toString());
	}
%>

<%
	if (hide==1){
%>
<%@ include file="../inc/chromefooter.jsp" %>
<%
	}
	else{
%>
<%@ include file="../inc/footer.jsp" %>
<%
	}
%>

<div id="help_container" class="popHide"></div>

</body>
</html>

