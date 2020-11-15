<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	hlptip.jsp
	*	TODO: need to get help text.
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	int si = website.getRequestParameter(request,"n",0);
	int type = website.getRequestParameter(request,"t",0);
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String question = QuestionDB.getCourseHelp(conn,campus,type,si);
	asePool.freeConnection(conn);
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFB3" width="98%" style="border: 1px solid #C0C0C0; padding-left: 4px; padding-right: 4px; padding-top: 1px; padding-bottom: 1px">
		<!--
		<tr>
			<td><img src="../images/corner-top-left.gif" border=0></td>
			<td>&nbsp;</td>
			<td><img src="../images/corner-top-right.gif" border=0></td>
		</tr>
		<tr>
			<td><img src="../images/corner-left.gif" border=0></td>
			<td><font class="black"><p><%=question%></p></font></td>
			<td><img src="../images/corner-right.gif" border=0></td>
		</tr>
		<tr>
			<td><img src="../images/corner-bottom-left.gif" border=0></td>
			<td>&nbsp;</td>
			<td><img src="../images/corner-bottom-right.gif" border=0></td>
		</tr>
		-->
		<tr>
			<td>&nbsp;</td>
			<td><font class="black"><p><%=question%></p></font></td>
			<td>&nbsp;</td>
		</tr>
	</table>
</body>
</html>
