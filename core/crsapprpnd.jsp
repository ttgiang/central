<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsapprpnd.jsp
	*	2010.06.26	display approval pending outlines
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Approval Pending Outlines";
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="./js/crsapprpnd.js"></script>

	<%@ include file="datatables.jsp" %>
	<script type="text/javascript">
		$(document).ready(function () {
			$("#crsapprpnd").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true,
				"aaSorting": [[1, "asc"]],
				"bJQueryUI": true,
				"bAutoWidth": false,
				"aoColumns": [
					{ sWidth: '05%' },
					{ sWidth: '20%' },
					{ sWidth: '20%' },
					{ sWidth: '55%' }
				]
			});
		});
	</script>

</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%

	paging = null;

	if (processPage){
		out.println(ApproverDB.showPendingApprovals(conn,campus,user));
	}

	String disabled = "";
	String off = "";

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	asePool.freeConnection(conn,"crsapprpnd",user);

	if (processPage){
%>
<p align="left">
<table>
	<tr>
		<td>
			<form name="aseForm" method="post" action="crsapprpndx.jsp">
				<input type="hidden" value="aseForm" name="formName">

				<input id="cmdYes" name="cmdYes" <%=disabled%>
					title="continue with request"
					type="submit"
					value="Approval all Outlines"
					class="inputsmallgray150">&nbsp;

				<input id="cmdNo" name="cmdNo" <%=disabled%>
					title="end requested operation"
					type="submit"
					value="Cancel"
					class="inputsmallgray"
					onClick="return cancelForm()">
			</form>
		</td>
	</tr>
</table>
</p>

<%
	}
%>

<p align="left">
<table>
	<tr>
		<td>
				<font class="textblackth">NOTE:</font>&nbsp;<br/><br/>
				<ul>
					<li>To submit one outline at a time, click on the outline link about<br/><br/>OR<br/><br/>
					Click 'Approve all Outlines' to process all outlines at once
				</ul>
		</td>
	</tr>
</table>
</p>


<%@ include file="../inc/footer.jsp" %>

</body>
</html>

