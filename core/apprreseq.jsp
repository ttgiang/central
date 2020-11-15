<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprreseq.jsp - re sequence approvers
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","apprreseq");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Resequence Approvers";

	int route = website.getRequestParameter(request,"r",0);

	fieldsetTitle = pageTitle;

	long countApprovalsByRoute = ApproverDB.countApprovalsByRoute(conn,campus,route);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>

	<script language="JavaScript" src="js/apprreseq.js"></script>

	<script type="text/javascript">
		$(document).ready(function(){
			$("#jqueryShowApprovers").dataTable({
				"sPaginationType": "full_numbers",
				"iDisplayLength": 99,
				"bFilter": false,
				"bSortClasses": false,
				"bLengthChange": false,
				"bPaginate": false,
				"bJQueryUI": true
			});

			$("#jqueryGetRoutingInUse").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 99,
				 "bJQueryUI": true
			});

		});

	</script>

</head>
<body topmargin="0" leftmargin="0">

	<%@ include file="../inc/header.jsp" %>

	<%
		if (processPage){
	%>
		<form name="aseForm" method="post" action="/central/servlet/ase">
	<%
		out.println(ApproverDB.resequenceApprovers(conn,campus,route));
	%>
		<p align="left">
		<%
			if(countApprovalsByRoute==0){
		%>
			<input name="aseSave" value="Save" type="submit" class="inputsmallgray" title="continue requested operation">&nbsp
		<%
			}
		%>
		<input name="aseCancel" value="Cancel" type="submit" class="inputsmallgray" title="end requested operation" onClick="return cancelForm(<%=route%>);">
		</p>

		</form>

		<p align="left">
		<%
			if(countApprovalsByRoute > 0){
		%>
			<font class="goldhighlightsbold">WARNING</font>: Re-sequencing is not permitted while approvals are in progress.
		<%
			}
		%>
		</p>

		<%
			if (route> 0){
				out.println(ApproverDB.getRoutingInUse(conn,campus,route));
			}

		} // processPage
	%>

	<%@ include file="../inc/footer.jsp" %>

</body>
</html>

