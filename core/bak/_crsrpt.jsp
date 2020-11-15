<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrpt.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String pageTitle = "Outline Reports";
	fieldsetTitle = pageTitle;
	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>

<!--
<table align="center" width="80%" border="0" id="table2" cellspacing="4" cellpadding="4">
	<tr>
		<td width="72%" colspan="3" bgcolor="#C0C0C0"><b><%=pageTitle%></b></td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Assessment Report - Assessment</td>
		<td valign="top" width="75%">Assessment Report by Assessment</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Assessment Report - Division</td>
		<td valign="top" width="75%">Assessment Report by Division</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Cancelled Outline</td>
		<td valign="top" width="75%">Report of cancelled outlines</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">List Outline</td>
		<td valign="top" width="75%">List all available outlines</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Experimental Outline</td>
		<td valign="top" width="75%">Display list of outlines ending in 97 or 98.</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Outline Detail</td>
		<td valign="top" width="75%">Display detail about an outline</td>
	</tr>
	<tr>
		<td width="2%" valign="top"><img src="../images/arrow.gif" border="0"></td>
		<td width="25%" valign="top">Progress Report</td>
		<td valign="top" width="75%">Report of proposed outline progress</td>
	</tr>
</table>
-->

Under Construction!!!


<%@ include file="../inc/footer.jsp" %>
</body>
</html>
