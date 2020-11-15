<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cmpry.jsp	outline copy/compare
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String campusName = CampusDB.getCampusName(conn,campus);
	String pageTitle = "Copy Outline Items";
	fieldsetTitle = pageTitle;
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/cmpry.js"></script>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	String kixSource = website.getRequestParameter(request,"kixSource","",false);
	String kixDestination = website.getRequestParameter(request,"kixDestination","",false);

	String[] columnNames = QuestionDB.getCampusColummNames(conn,campus).split(",");
	String input = "";
	String temp = "";

	// collect all selected form items
	for(int i = 0; i < columnNames.length; i++){
		temp = website.getRequestParameter(request,columnNames[i],"",false);
		if ("1".equals(temp)){
			if ("".equals(input))
				input = columnNames[i];
			else
				input = input + "," + columnNames[i];
		}
	}

	asePool.freeConnection(conn);
%>

<form method="post" action="cmprz.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					Do you wish to continue?
					<br /><br />
					<input type="hidden" value="<%=kixSource%>" name="kixSource">
					<input type="hidden" value="<%=kixDestination%>" name="kixDestination">
					<input type="hidden" value="<%=input%>" name="input">
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

