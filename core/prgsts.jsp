<%@ page import="org.apache.log4j.Logger"%>

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgsts.jsp - program approval status (does not need alpha selection)
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// GUI
	String chromeWidth = "60%";
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String pageTitle = "Program Approval Status";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<%@ include file="highslide.jsp" %>
	<script type="text/javascript" src="js/prgsts.js"></script>
	<link rel="stylesheet" type="text/css" href="styles/help.css">
	<link rel="stylesheet" type="text/css" href="lib/pagination.css">

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#showApprovalProgress").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": true,
				"bPaginate": true,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<%
	if (processPage){
		boolean isSysAdmin = SQLUtil.isSysAdmin(conn,user);
		boolean isCampusAdmin = SQLUtil.isCampusAdmin(conn,user);

		try{
			out.println("	<table width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
			out.println("			<tr>" );
			out.println("				 <td colspan=\'2\' class=\'dataColumn\'>");
	%>
			<p align="center">
			<img src="../images/viewcourse.gif" border="0" alt="view program" title="view program">&nbsp;view program&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="../images/viewhistory.gif" border="0" alt="view approval status" title="view approval status">&nbsp;approval status&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="images/comment.gif" border="0" alt="view approver comments" title="view approver comments">&nbsp;approver comments&nbsp;&nbsp;&nbsp;&nbsp;
			<img src="../images/details.gif" border="0" alt="view approval history" title="view approval history">&nbsp;program detail
			</p>
	<%
			out.println("				 </td>");
			out.println("		</tr>" );

			out.println("		<tr>" );
			out.println("			 <td colspan=2 align=left><br/>" );
			boolean approvalOnly = true;

			out.println(ProgramsDB.showApprovalProgress(conn,campus,user));

			out.println("			 </td>" );
			out.println("		</tr>" );

			out.println("	</table>" );
		}
		catch( Exception e ){
			out.println(e.toString());
		}
	}

	asePool.freeConnection(conn,"prgsts",user);
%>

<%@ include file="../inc/footer.jsp" %>

<div id="help_container" class="popHide"></div>

</body>
</html>
