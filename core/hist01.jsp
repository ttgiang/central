<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsacan.jsp	- cancel assess process
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String campus = website.getRequestParameter(request,"campus","",false);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String pageTitle = "History Adjustments";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<form action="hist02.jsp" method="post">
	<table width="20%" border="0">
		<tr>
			<td class="textblackth">Campus:</td>
			<td class="datacolumn"><%=campus%> <input type="hidden" name="campus" value="<%=campus%>"></td>
		</tr>
		<tr>
			<td class="textblackth">Alpha:</td>
			<td class="datacolumn">
				<%
					String sql = "select distinct coursealpha as kee,coursealpha from zarchstfix where campus='"+campus+"' order by coursealpha";
					out.println(aseUtil.createSelectionBox(conn,sql,"alpha","",false));
				%>

			</td>
		</tr>
		<tr>
			<td class="textblackth">&nbsp;</td>
			<td class="datacolumn">
				<input type="submit" value="Next" name="Go">
				&nbsp;<a href="hist00.jsp" class="linkcolumn">start over</a>
			</td>
		</tr>
	</table>
</form>

<%
	asePool.freeConnection(conn,"hist01",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
