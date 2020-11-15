<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.ase.aseutil.Skew"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscan.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "verifySQL";
	session.setAttribute("aseThisPage",thisPage);

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Verify SQL";
	fieldsetTitle = "Verify SQL";
	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/verifySQL.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="verifySQLx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					Do you wish to continue?
					<br /><br />
				</TD>
			</TR>
			<TR><TD align="center"><% out.println(Skew.showInputScreen(request)); %></td></tr>
			<TR>
				<TD align="center">
					<br />
					<input title="continue with request" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="end requested operation" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>


<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
