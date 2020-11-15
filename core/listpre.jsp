<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	listpre.jsp
	*	2007.09.01	list proposed courses
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String chromeWidth = "60%";
	String pageTitle = "List Proposed Outlines";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/listpre.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	try{
		String sql = "";

		out.println("		<form method=\'post\' name=\'aseForm\' action=\'viewpre.jsp\'>" );
		out.println("			<table height=\'150\' width=\'100%\' cellspacing='1' cellpadding='2' class=\'tableBorder" + session.getAttribute("aseTheme") + "\' align=\'center\'  border=\'0\'>" );

		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTH\'>Choose the course you wish to view and click the submit button:</td>" );
		out.println("				</tr>" );

		// course by alphabet
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td>" );

		if ( request.getParameter("abc") != null ){
			sql = "SELECT distinct tc.CourseAlpha + ' ' + tc.CourseNum as B, " +
				"tc.CourseAlpha + ' ' + tc.CourseNum  + ' - ' + tc.coursetitle as A " +
				"FROM tblCourse tc " +
				"WHERE (tc.CourseType = 'PRE') AND " +
				"tc.CourseAlpha like " + aseUtil.toSQL(request.getParameter("abc") + "%",1);
		}
		else{
			sql = "SELECT distinct tpc.CourseAlpha + ' ' + tpc.CourseNum as A, " +
				"tpc.CourseAlpha + ' ' + tpc.CourseNum + ' - ' + tc.coursetitle AS B " +
				"FROM tblPreApproveCourse tpc, tblCourse tc " +
				"WHERE tpc.CourseAlpha = tc.CourseAlpha AND tpc.CourseNum = tc.CourseNum AND " +
				"tc.dispid = " + aseUtil.toSQL(request.getParameter("disc"),3);
		}

		out.println( aseUtil.createSelectionBox( conn, sql, "alphanumber", "",false));
		out.println("					 </td>" );
		out.println("				</tr>" );

		// form buttons
		out.println("				<tr class=\'textblackTRTheme" + session.getAttribute("aseTheme") + "\'>" );
		out.println("					 <td class=\'textblackTHRight\'><hr size=\'1\'>" );
		out.println("							<input type=\'submit\' name=\'aseSubmit\' value=\'Submit\' class=\'inputsmallgray\' onClick=\"return checkForm()\">" );
		out.println("							<input type=\'submit\' name=\'aseCancel\' value=\'Cancel\' class=\'inputsmallgray\' onClick=\"return cancelForm()\">" );
		out.println("							<input type=\'hidden\' name=\'formName\' value=\'aseForm\'>" );
		out.println("					 </td>" );
		out.println("				</tr>" );
		out.println("			</table>" );
		out.println("		</form>" );

		aseUtil = null;
	}
	catch( Exception e ){
		out.println(e.toString());
	}

	asePool.freeConnection(conn);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
