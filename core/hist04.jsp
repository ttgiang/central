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

	String alpha = website.getRequestParameter(request,"alpha","",false);
	String num = website.getRequestParameter(request,"num","",false);

	String arc = website.getRequestParameter(request,"arc","",false);
	String hst = website.getRequestParameter(request,"hst","",false);

	String pageTitle = campus + " - " + alpha + " - " + num;
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>

<form action="hist05.jsp" method="post">
	<table width="100%">
		<tr>
			<td valign="top" width="10%" class="textblackth">Outline</td>
			<td><%=pageTitle%><p>&nbsp;</p></td>
		</tr>

		<tr>
			<td valign="top" width="10%" class="textblackth">Archived</td>
			<td><%=arc%></td>
		</tr>

		<tr>
			<td valign="top" width="10%" class="textblackth">History</td>
			<td><%=hst%></td>
		</tr>

		<tr>
			<td valign="top" width="10%" class="textblackth">&nbsp;</td>
			<td>
				<input type="hidden" value="<%=campus%>" name="campus">
				<input type="hidden" value="<%=alpha%>" name="alpha">
				<input type="hidden" value="<%=num%>" name="num">
				<input type="hidden" value="<%=arc%>" name="arc">
				<input type="hidden" value="<%=hst%>" name="hst">

				<%
					if(!arc.equals(Constant.BLANK) && !hst.equals(Constant.BLANK)){
				%>
						<input type="submit" value="Next" name="Go">
				<%
					}
				%>

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
