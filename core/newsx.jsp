<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	newsx.jsp - delete news file
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "newsx";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = website.getRequestParameter(request,"formAction","d");
	String formName = website.getRequestParameter(request,"formName");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	int lid = website.getRequestParameter(request,"lid",0);

	News news = NewsDB.getNews(conn,lid);

	String message = "";

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Delete News";
	fieldsetTitle = pageTitle;

	fieldsetTitle = "Delete News";

	session.setAttribute("aseCallingPage","NEWS");

	asePool.freeConnection(conn,"newsx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/newsx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="/central/servlet/ns" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR height="20">
				<TD class="textblackTH" width="20%">Campus:</TD>
				<TD class="datacolumn"><%=campus%></TD>
			</TR>
			<TR height="20">
				<TD class="textblackTH" width="20%">Title:</TD>
				<TD class="datacolumn"><%=news.getTitle()%></TD>
			</TR>
			<TR height="20">
				<TD colspan="2"><div class="hr"></div></TD>
			</TR>
			<TR>
				<TD align="center" colspan="2">
					Do you wish to continue?<br/><br/>
					<br />
					<% out.println(Skew.showInputScreen(request)); %>
					<input type="hidden" value="<%=lid%>" name="lid">
				</TD>
			</TR>
			<TR>
				<TD align="center" colspan="2">
					<br />
					<input title="continue with request" type="submit" name="aseDelete" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="end requested operation" type="submit" name="aseCancel" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
					<input type="hidden" value="<%=formAction%>" name="formAction" id="formAction">
					<input type="hidden" value="aseForm" name="formName">
					<input type="hidden" value="3" id="mnu" name="mnu">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>


<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
