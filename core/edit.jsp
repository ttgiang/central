<%@ include file="ase.jsp" %>

<%
	String pageTitle = "Curriculum Central: Edit";
	fieldsetTitle = pageTitle;

	asePool.freeConnection(conn);
%>
<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<table border="0" width="80%">
	<tr>
		<td colspan="2">Question #12</td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="images/cfdev.gif" border="0">
		</td>
	</tr>
	<tr>
		<td>
			<%

				int i = 0;

				out.print("<br>");

				for ( i = 1; i < 20; i++ )
					if ( i == 12 )
						out.print("<b>" + i + "</b>&nbsp;|&nbsp;");
					else
						out.print("<a href=\"\">" + i + "</a>&nbsp;|&nbsp;");

			%>
		</td>
		<td align="right">
			<input type="submit" value="Save" class="inputsmallgray">
			<input type="submit" value="Approval" class="inputsmallgray">
			<input type="submit" value="Cancel" class="inputsmallgray">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</td>
	</tr>
</table>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
