<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgstsh.jsp - program approval progress
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String pageTitle = "Program Approval History";
	fieldsetTitle = pageTitle;
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

<%
	String helpButton = website.getRequestParameter(request,"help");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
		route = NumericUtil.nullToZero(info[6]);
	}
	// whether to display the close help button
	if ( helpButton == null || helpButton.length() == 0 )
		helpButton = "0";

	if ((Constant.ON).equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}

%>
<table width="100%" cellspacing='1' cellpadding='2' align="center"  border="0">
	<tr><td align="center" class="textblackthcenter">
		<%
			out.println(pageTitle + "<br>");
			out.println(alpha + "<br>");
			out.println("Approval Routing - " + ApproverDB.getRoutingFullNameByID(conn,campus,route));
		%>
	</td></tr>
</table>

<%
	if (processPage){
		out.println( "Completed approvals" );
		msg = ProgramsDB.showCompletedApprovals(conn,campus,kix);
		out.println(msg.getErrorLog());
		out.println("<br/>");
		out.println("Pending approvals");
		out.println(ProgramsDB.showPendingApprovals(conn,campus,kix,msg.getMsg(),route));
	}

	asePool.freeConnection(conn,"prgstsh",user);

	if ((Constant.ON).equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}
%>

</body>
</html>

