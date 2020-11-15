<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	ccrpt.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Curriculum Central Task Stream Exports";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	asePool.freeConnection(conn,"taskstream",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<table align="center" width="90%" border="0" id="table2" cellspacing="4" cellpadding="4">
	<tr>
		<td valign="top" colspan="2">
			<h3 class="subheader">Exports</h3>
			<ul>
				<li><a href="taskstreamx.jsp?rpt=X" class="linkcolumn">Course Data</a> - textbox</li>
				<li><a href="taskstreamx.jsp?rpt=<%=Constant.COURSE_COMPETENCIES%>" class="linkcolumn">Competencies</a> - list</li>
			</ul>

			Note: All exports include coure alpha, number and title of APPROVED outlines.
		</td>
		<td valign="top" width="50%">&nbsp;</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
