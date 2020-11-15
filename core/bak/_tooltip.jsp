<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	tooltip.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		return;
	}

	int len = 45;
	int si = website.getRequestParameter(request,"si",0);
	int type = website.getRequestParameter(request,"tp",0);
	String campus = session.getAttribute("aseCampus").toString();
	String question = QuestionDB.getCourseQuestion(conn,campus,type,si);
%>

<html>
<head>
</head>
<body topmargin="0" leftmargin="0">
	<table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFB3" width="30%">
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
