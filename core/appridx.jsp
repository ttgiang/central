<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	appridxx.jspp
	*	2007.09.01	names of approvers
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	session.setAttribute("aseThisPage","appridx");

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage",
		"<ul><li>Determines whether approval submissions are done as a packet (ApprovalSubmissionAsPackets)</li>"
		+ "<li>Determines whether college codes are displayed (EnableCollegeCodes)</li></ul>");

	session.setAttribute("aseReport","approvalRouting");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = "Approver Sequence Listing";
	String display = website.getRequestParameter(request,"dsp","");

	String college = website.getRequestParameter(request,"college","");
	String dept = website.getRequestParameter(request,"dept","");
	String level = website.getRequestParameter(request,"level","");

	String message = "";

	String route = website.getRequestParameter(request,"route","0");
	int rte = NumericUtil.stringToInt(route);
	if (rte > 0){
		// depending on how we got here, the rte may have been
		// a deleted one so we make sure to reset.
		if (!IniDB.doesRoutingIDExists(conn,campus,rte)){
			rte = 0;
		}

		Ini ini = IniDB.getINI(conn,rte);
		if (ini != null){
			college = ini.getKval1();
			dept = ini.getKval2();
			level = ini.getKval3();
		}
		ini = null;
	}

	fieldsetTitle = pageTitle
		+ "&nbsp;&nbsp;<a href=\"/centraldocs/docs/faq/outlineapproval.pdf\" target=\"_blank\"><img src=\"/central/core/images/helpicon.gif\" alt=\"show help\" border=\"0\"></a>&nbsp;&nbsp;";

	// pageClear = 1 is when this page is called from menu selection. This means
	// it's the first time to this page. If so, start with a clear page with
	// no saved session value.
	String pageValue = "";
	String pageClear = website.getRequestParameter(request,"pageClr","");
	if (pageClear.equals(Constant.BLANK)){
		//pageValue = website.getRequestParameter(request,"asePageAPPRIDX","",true);
	}

	boolean inUse = false;

	if (processPage){
		inUse = ApproverDB.isRoutingInUse(conn,campus,rte);
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>

	<%@ include file="datatables.jsp" %>

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

			$("#jqueryGetRoutingInUseForPrograms").dataTable({
				 "sPaginationType": "full_numbers",
				 "iDisplayLength": 99,
				 "bJQueryUI": true
			});

			var college = '<%=college%>';
			var dept = '<%=dept%>';
			var level = '<%=level%>';
			var route = '<%=route%>';

			$(".college").change(function(){
				college = $(this).val();
				dept = document.getElementById("dept").value;
				level = document.getElementById("level").value;
				getDept(college);
				getRoutes(college,dept,level,route);
			}); // college

			$(".dept").change(function(){
				college = document.getElementById("college").value;
				dept = $(this).val();
				level = document.getElementById("level").value;
				getLevel(college,dept);
				getRoutes(college,dept,level,route);
			}); // dept

			$(".level").change(function(){
				college = document.getElementById("college").value;
				dept = document.getElementById("dept").value;
				level = $(this).val();
				getRoutes(college,dept,level,route);

			}); // level

		});

		function getDept(college){

			var dataString = 'cdl=c&c='+college+'&d='+dept+'&l='+level+'&r='+route;

			$.ajax({
				type: "POST",
				url: "appridxx.jsp",
				data: dataString,
				cache: false,
				success: function(html){
					$(".dept").html(html);
				}
			});

		}

		function getLevel(college,dept){

			var dataString = 'cdl=cd&c='+college+'&d='+dept+'&l='+level+'&r='+route;

			$.ajax({
				type: "POST",
				url: "appridxx.jsp",
				data: dataString,
				cache: false,
				success: function(html){
					$(".level").html(html);
				}
			});

		}

		function getRoutes(college,dept,level,route){

			var dataString = 'cdl=cdl&c='+college+'&d='+dept+'&l='+level+'&r='+route;

			$.ajax({
				type: "POST",
				url: "appridxx.jsp",
				data: dataString,
				cache: false,
				success: function(html){
					$(".route").html(html);
				}
			});

		}

		// this code is required only when college, level and route are available.
		// this happens when we have a route and need to poupate defaults in selects
		var college = "<%=college%>";
		var dept = "<%=dept%>";
		var level = "<%=level%>";
		var route = "<%=route%>";

		getRoutes(college,dept,level,route);

	</script>

</head>
<body topmargin="0" leftmargin="0">

<%
	if (display != null && display.length() > 0){
%>
	<%@ include file="../inc/headerli.jsp" %>
<%
	}
	else{
%>
	<%@ include file="../inc/header.jsp" %>

	<form name="aseForm" method="post" action="?">
	<table border="0" cellpadding="2" width="100%" cellspacing="4">
		<tr>
			<td height="30" align="left">
			 <%
			 		if (processPage){

						// ER00027 - 2011.12.05
						// approval with division chair sequence
						// when route is available, allow editing of divisions associated with routing (ER00027)
						String approvalSubmissionAsPackets = Util.getSessionMappedKey(session,"ApprovalSubmissionAsPackets");

						String enableCollegeCodes = Util.getSessionMappedKey(session,"EnableCollegeCodes");
						if(enableCollegeCodes.equals(Constant.ON)){

							out.println("<table border=\"0\" cellpadding=\"0\" width=\"100%\" cellspacing=\"0\">");

							String sql = aseUtil.getPropertySQL(session,"college");
							out.println("<tr bgcolor=\"#abcdef\"><td class=\"textblackth\" width=\"05%\">College:</td>"
									+ "<td width=\"30%\">" + aseUtil.createSelectionBox(conn,sql,"college",college,"","",false,"",true,false) + "</td>");

							sql = aseUtil.getPropertySQL(session,"bannerdepartment");
							out.println("<td class=\"textblackth\" width=\"05%\">Dept:</td>"
									+ "<td width=\"30%\">" + aseUtil.createSelectionBox(conn,sql,"dept",dept,"","",false,"",true,false) + "</td>");

							sql = aseUtil.getPropertySQL(session,"level");
							out.println("<td class=\"textblackth\" width=\"05%\">Level:</td>"
									+ "<td width=\"35%\">" + aseUtil.createSelectionBox(conn,sql,"level",level,"","",false,"",true,false) + "</td>");

							out.println("<tr><td colspan=\"6\">&nbsp;</td></tr>");

							sql = aseUtil.getPropertySQL(session,"bannerdepartment");
							out.println("<tr bgcolor=\"#fedbca\"><td class=\"textblackth\" width=\"10%\">Approval Routing:</td>"
									+ "<td colspan=\"5\"><select name=\"route\" class=\"route\"><option selected value=\"\">- select -</option></select>"
									+ "&nbsp;&nbsp;&nbsp;&nbsp;<input type=\"submit\" name=\"aseSubmit\" value=\"Go\" class=\"Input\"></td></tr>");

							out.println("</table>");
						}
						else{

							String HTMLFormField = Html.drawListBox(conn,"ApprovalRouting","route",route,campus,false,false);

							if (rte > 0 && processPage && approvalSubmissionAsPackets.equals(Constant.ON)){
								out.println("&nbsp;&nbsp;&nbsp;<font class=\"textblackth\"><a href=\"appradd.jsp?rte="+rte+"\" class=\"linkcolumn\">Approval Routing</a>: </font>" + HTMLFormField);
							}
							else{
								out.println("&nbsp;&nbsp;&nbsp;<font class=\"textblackth\">Approval Routing: </font>" + HTMLFormField);
							}

							out.println("<input type=\"hidden\" name=\"college\" id=\"college\" value=\"\">");
							out.println("<input type=\"hidden\" name=\"dept\" id=\"dept\" value=\"\">");
							out.println("<input type=\"hidden\" name=\"level\" id=\"level\" value=\"\">");

							out.println("<input type=\"submit\" name=\"aseSubmit\" value=\"Go\" class=\"Input\">");

						} // college codes

						out.println("<input type=\"hidden\" name=\"src\" value=\"trms\">");

					} // processPage
			 %>
			</td>
		</tr>
		<tr>
			<td nowrap>
			 <%
				out.println("&nbsp;<font color=\"#c0c0c0\">|</font>&nbsp;<a href=\"/central/servlet/progress?c="+campus+"&r=-999\" class=\"linkcolumn\" target=\"_blank\">&nbsp;print routings</a>");
				out.println("&nbsp;<font color=\"#c0c0c0\">|</font>&nbsp;<a href=\"apprpt.jsp\" class=\"linkcolumn\">&nbsp;approver routes</a>");
			 %>
			</td>
		</tr>
	</table>
	</form>
<%
	}

	String showRejectedApprovalSelection = "";

	if (processPage){
		showRejectedApprovalSelection = ApproverDB.showRejectedApprovalSelection(conn,campus);

		out.println(ApproverDB.showApprovers(conn,campus,Integer.parseInt(route),college,dept,level));

		if (rte > 0){
			out.println(ApproverDB.getRoutingInUse(conn,campus,rte));
			out.println(ApproverDB.getRoutingInUseForPrograms(conn,campus,rte));
		}
	}

	asePool.freeConnection(conn,"appridx",user);

%>

<table border="0" cellpadding="2" width="100%" align="center" cellspacing="1">
	<tr>
		<td width="100%" height="30" valign="top" align="left">
			<p><b>NOTE:</b>&nbsp;
				<ul>
					<li><%=showRejectedApprovalSelection%></li>
					<li>Add Approver is not permitted when outline approvals are in progress using this approver sequence.</li>
					<li>Add Approval Instructions - include instructions to approvers during the approval process. For example, important due dates.</li>
					<li>Add Routing - creates a new routing</li>
					<li>Copy Routing - assign a duplicate copy of this approval routing to a different name</li>
					<li>Delete Routing - delete this approval routing (provided that it is not is use)</li>
				</ul>
			</p>
		</td>
	</tr>
</table>

<%

	if ( display != null && display.length() > 0 ){
%>
	<%@ include file="../inc/footerli.jsp" %>
<%
	}
	else{
%>
	<%@ include file="../inc/footer.jsp" %>
<%
	}
%>

</body>
</html>

