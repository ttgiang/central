<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgidx.jsp - modify proposed program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String ack = website.getRequestParameter(request,"ack","");

	String pageTitle = "";

	if ("m".equals(ack))
		pageTitle = "Modify Proposed Program";
	else if ("r".equals(ack))
		pageTitle = "Request Program Approval";

	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#prgidx").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '05%' },
					{ sWidth: '05%' },
					{ sWidth: '20%' },
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

<table border="0" cellspacing="0" cellpadding="0" width="100%">
	<tr>
		<td width="100%" height="20" align="center">
			<img src="../images/viewcourse.gif" border="0" alt="view program" title="view program">&nbsp;&nbsp;view program
			<font class="copyright">&nbsp;&nbsp;&nbsp;|&nbsp;</font>
			<img src="../images/fastrack.gif" border="0" alt="request program approval" title="request program approval">&nbsp;&nbsp;request program approval
		<td>
	</tr>
</table>
</p>

<%
	if (processPage){
		String sql = aseUtil.getPropertySQL(session,"prgidx11");
		if ( sql != null && sql.length() > 0 ){
			sql = aseUtil.replace(sql, "_campus_", campus);
			sql = aseUtil.replace(sql, "_type_", "PRE");
			sql = aseUtil.replace(sql, "_progress_", Constant.PROGRAM_MODIFY_PROGRESS);
			sql = aseUtil.replace(sql, "_user_", ""+user);
			out.println(ProgramsDB.showProgramStatus(conn,sql));
		}
	}

	paging = null;

	asePool.freeConnection(conn,"prgidx",user);
%>

<%@ include file="../inc/footer.jsp" %>

</body>
</html>
