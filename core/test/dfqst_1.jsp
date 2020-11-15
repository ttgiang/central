<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dfqst.jsp
	*	2007.09.01	define questions
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		return;
	}

	String pageTitle = "Course Question Listing";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%
	out.println("<table width=\'" + session.getAttribute("aseTableWidth") + "\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );
	out.println("<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
	out.println("<td>Items: <a href=\'?code=s\'>System</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href=\'?code=c\'>Campus</a></td>" );
	out.println("</tr>" );
	out.println("</table>" );

	com.ase.paging.Paging paging = new com.ase.paging.Paging();
	String code = website.getRequestParameter(request,"code", "");

	if ( code != null && code.length() > 0 ){
		if ( code.equals("c") ){
			String sql = aseUtil.getPropertySQL( session, "tblCourseQuestionsCampus" );
			sql = aseUtil.replace(sql, "_sql_", (String)session.getAttribute("aseCampus"));
			paging.setSQL( sql );
		}
		else{
			paging.setSQL( aseUtil.getPropertySQL( session, "tblCourseQuestions" ) );
		}
	}
	else{
		paging.setSQL( aseUtil.getPropertySQL( session, "tblCourseQuestions" ) );
	}

	paging.setScriptName("/central/core/dfqst.jsp");
	paging.setDetailLink("/central/core/dfqstx.jsp?code=c");
	paging.setAllowAdd( false );
	paging.setSorting( false );
	paging.setRecordsPerPage( 99 );
	out.print( paging.showRecords( conn, request, response ) );
	paging = null;
	asePool.freeConnection(conn);
%>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>