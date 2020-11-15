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
	String campus = website.getRequestParameter(request,"aseCampus","",true);
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

<form action="hist01.jsp" method="post">

	<table width="20%" border="0">
		<tr>
			<td class="textblackth">Campus:</td>
			<td class="datacolumn">
				<%
					String sql = "select distinct campus as kee,campus from zarchstfix order by campus";
					out.println(aseUtil.createSelectionBox(conn,sql,"campus","",false));
				%>
			</td>
		</tr>
		<tr>
			<td class="textblackth">&nbsp;</td>
			<td class="datacolumn">
				<input type="submit" value="Next" name="Go">
			</td>
		</tr>
	</table>

</form>

<%
	asePool.freeConnection(conn,"hist00",user);
%>

<%@ include file="../inc/footer.jsp" %>
</body>
</html>
