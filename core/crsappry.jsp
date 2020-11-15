<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsappry.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.USER, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Message";
	fieldsetTitle = pageTitle;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix", "");
	if (processPage && !(Constant.BLANK).equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_ALPHA];
		num = info[Constant.KIX_NUM];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);
	}
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {

			$("#showCompletedApprovals").dataTable({
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
				"iDisplayLength": 99,
				"bFilter": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[0, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '10%' },
					{ sWidth: '10%' },
					{ sWidth: '30%' },
					{ sWidth: '30%' },
					{ sWidth: '10%' }
				]
			});

		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<p align="left">
	<TABLE cellSpacing=0 cellPadding=0 width="90%" border=0>
		<tr>
			<td>
				It is not your turn to approve this outline (<font class="datacolumn"><%=alpha%> <%=num%></font>).<br/><br/>
				Review the outline approval status below and if you feel this message is incorrect, report it to your Curriculum Central Administrator.
				<br/><br/>
				If this message is correct and the task to approve <font class="datacolumn"><%=alpha%> <%=num%></font> was erroneously placed on your task list, click <a href="crsapprz.jsp?kix=<%=kix%>" class="linkcolumn">here</a> to delete the task.
				<br/><br/>
			</td>
		</tr>
		<tr>
			<td>
			<%
				msg = ApproverDB.showCompletedApprovals(conn,campus,alpha,num);
				out.println(""
					+ "<fieldset class=\"FIELDSET90\">"
					+ "<legend>Approval Status</legend>"
					+ "<p align=left class=text>Completed approvals"
					+ msg.getErrorLog()
					+ "<br/>"
					+ "Pending approvals"
					+ ApproverDB.showPendingApprovals(conn,campus,alpha,num,msg.getMsg(),route)
					+ "</fieldset>");
			%>
			<br/>
		</td>
	</tr>
	</table>
</p>
<%
	//session.setAttribute("aseApplicationMessage","");
	asePool.freeConnection(conn,"crsappry",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>