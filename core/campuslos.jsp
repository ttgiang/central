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

	String pageTitle = "Curriculum Central Learning Outline Exports";
	fieldsetTitle = pageTitle;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String type = website.getRequestParameter(request,"type","");

	asePool.freeConnection(conn,"campuslos",user);
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
				<li><a href="campuslosx.jsp?rpt=text&type=<%=type%>" class="linkcolumn">Course Data</a> (alpha, number, title)</li>
				<li><a href="campuslosx.jsp?rpt=list&type=<%=type%>" class="linkcolumn">Learning Outlines</a> (GESLO, ILO, PLO, SLO)</li>
			</ul>
		</td>
		<td valign="top" width="50%">&nbsp;</td>
	</tr>
</table>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
