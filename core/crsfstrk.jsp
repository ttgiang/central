<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsfstrk.jsp - fast track outline approval
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Fast Track Outline Approval";
	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/fasttrackapproval.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsfstrk.js"></script>

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

<%
	String helpButton = website.getRequestParameter(request,"help");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		route = NumericUtil.nullToZero(info[6]);
	}

	// whether to display the close help button
	if ( helpButton == null || helpButton.length() == 0 )
		helpButton = "0";

	if (helpButton.equals("1") ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}
%>
<table width="100%" cellspacing='1' cellpadding='2' align="center"  border="0">
	<tr><td align="center" class="textblackthcenter">
		<%
			out.println(pageTitle + "<br>");
			out.println(courseDB.setPageTitle(conn,"",alpha,num,campus));
		%>
	</td></tr>
</table>
<br/>
<table width="100%" cellspacing='0' cellpadding='0' align="left"  border="0">
	<tr>
		<td width="100%" valign="top">
			<table width="100%" cellspacing='0' cellpadding='0' align="left"  border="0">
				<tr>
					<td>
						<fieldset class="FIELDSET90">
						<legend>Fast Track Approval</legend>
						<form method="post" action="/central/servlet/pokey" name="aseForm">
							<%
								if (processPage){
									out.println(ApproverDB.displayFastTrackApprovers(conn,campus,kix,route));
							%>
									<input title="continue approval process" type="submit" value="Submit" class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
									<input title="cancel fast track request" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">&nbsp;

									<input type="hidden" value="" name="nextApprover">
									<input type="hidden" value="s" name="formAction">
									<input type="hidden" value="<%=kix%>" name="kix">
									<input type="hidden" value="aseForm" name="formName">
									<input type="hidden" value="fstrk" name="src">
							<%
								}
							%>
						</form>
						<p>
							<B>NOTE</B>: Fast track approval forces CC to approve <font class="goldhighlights"><%=alpha%> <%=num%></font> up to and including the
							selected faculty member.
						</p>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td width="100%" valign="top">
			<br/><br/>
			<table width="100%" cellspacing='0' cellpadding='0' align="left"  border="0">
				<tr>
					<td align="left" class="textblackth">
						<fieldset class="FIELDSET90">
						<legend>Completed approvals</legend>
						<%
							if (processPage){
								msg = ApproverDB.showCompletedApprovals(conn,campus,alpha,num);
								out.println(msg.getErrorLog());
							}
						%>
					</td>
				</tr>
				<tr>
					<td align="left" class="textblackth">
						<fieldset class="FIELDSET90">
						<legend>Pending approvals</legend>
						<%
							if (processPage)
								out.println(ApproverDB.showPendingApprovals(conn,campus,alpha,num,msg.getMsg(),route));
						%>
					</td>
				</tr>
				<tr>
					<td align="center">
						<br/><br/><a href="crssts.jsp" class="linkcolumn">outline status</a>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%
	asePool.freeConnection(conn,"crsfstrk",user);
%>

</p>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>

