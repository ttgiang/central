<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsstsh.jsp - outline approval history
	*	TODO - need to send over alpha and number correctly
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	String pageTitle = "Outline Approval History";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%
	String helpButton = website.getRequestParameter(request,"help");
	String campus = (String)session.getAttribute("aseCampus");

	// whether to display the close help button
	if ( helpButton == null || helpButton.length() == 0 )
		helpButton = "0";

	if ( "1".equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}

	String sql = aseUtil.getPropertySQL(session,"approvalhistory");

	if ( sql != null && sql.length() > 0 ){
		String alpha = website.getRequestParameter(request,"alpha");
		String num = website.getRequestParameter(request,"num");
		if ( alpha.length() > 0 && num.length() > 0 ){
			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_num_", num);
			sql = aseUtil.replace(sql, "_sql_", campus);

			out.println( "Completed approvals" );
			paging = new com.ase.paging.Paging();
			paging.setRecordsPerPage(99);
			paging.setNavigation(false);
			paging.setSorting(false);
			paging.setSQL(sql);
			out.print( paging.showRecords( conn, request, response ) );
			paging = null;

			out.println( "<br/>" );

			out.println( "Pending approvals" );
			sql = aseUtil.getPropertySQL( session, "approvalhistory2" );

sql = "SELECT ta.approver_seq AS Sequence, ta.Approver, tu.Title, tu.Position " +
	"FROM tblApprover AS ta INNER JOIN tblUsers AS tu ON ta.approver = tu.userid " +
	"WHERE ta.approver<>'DIVISIONCHAIR' AND tu.campus='_campus_' " +
	"UNION SELECT tblApprover.approver_seq AS Sequence, tu.userid AS Approver, tu.Title, tu.Position " +
	"FROM tblApprover INNER JOIN tblUsers AS tu ON tblApprover.campus = tu.campus " +
	"WHERE tu.position='DIVISION CHAIR'  AND tu.campus='_campus_' AND tu.department='_campus_'  AND tblApprover.approver='DIVISIONCHAIR'";

			sql = aseUtil.replace(sql, "_alpha_", alpha);
			sql = aseUtil.replace(sql, "_sql_", campus);
			paging = new com.ase.paging.Paging();
			paging.setSQL(sql);

out.println(sql);

			paging.setNavigation(false);
			paging.setRecordsPerPage(99);
			paging.setSorting(false);
			out.print( paging.showRecords( conn, request, response ) );
			paging = null;
		}
	}

	asePool.freeConnection(conn);

	if ( "1".equals( helpButton ) ){
		out.println( "<p align=\"center\"><a href=\"#\" onClick=\"closeTaskWindow();\"><img src=\"../images/btn_close.gif\" border=\"0\"></a></p>" );
	}
%>

</body>
</html>