<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.ase.aseutil.Skew"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	usrtsksx.jsp - view/delete user assigned task
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "usrtsksx";
	session.setAttribute("aseThisPage",thisPage);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String uid = website.getRequestParameter(request,"uid");
	int sid = website.getRequestParameter(request,"sid",0);
	if (sid==0)
		response.sendRedirect("sltcrs.jsp?cp=" + thisPage + "&viewOption=PRE");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Delete User Assigned Task";
	fieldsetTitle = "View User Assigned Task";

	Task task = TaskDB.getUserTask(conn,sid);

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/usrtsksx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="/central/servlet/usx" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR height="25">
				<TD class="textblackth" width="25%">Submitted By:</TD>
				<TD class="datacolumn"><%=task.getSubmittedBy()%></TD>
			</TR>
			<TR height="25">
				<TD class="textblackth" width="25%">Date:</TD>
				<TD class="datacolumn"><%=task.getDte()%></TD>
			</TR>
			<TR height="25">
				<TD class="textblackth" width="25%">Course Alpha:</TD>
				<TD class="datacolumn"><%=task.getCourseAlpha()%></TD>
			</TR>
			<TR height="25">
				<TD class="textblackth" width="25%">Course Number:</TD>
				<TD class="datacolumn"><%=task.getCourseNum()%></TD>
			</TR>
			<TR height="25">
				<TD class="textblackth" width="25%">Message:</TD>
				<TD class="datacolumn"><%=task.getMessage()%></TD>
			</TR>
			<TR height="25">
				<TD align="center" colspan="2">
					<br/><div class="hr"></div>
					Do you wish to continue?
					<br /><br />
					<input type="hidden" value="<%=sid%>" name="sid">
					<input type="hidden" value="<%=uid%>" name="uid">
				</TD>
			</TR>
			<TR height="25"><TD align="center" colspan="2"><% out.println(Skew.showInputScreen(request)); %></td></tr>
			<TR height="25">
				<TD align="center" colspan="2">
					<br />
					<input title="continue with request" type="submit" name="aseDelete" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
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
