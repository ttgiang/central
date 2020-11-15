<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscmntx - delete review comments
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "crscmntx";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String kix = website.getRequestParameter(request,"kix", "");

	String[] info = helper.getKixInfo(conn,kix);
	String alpha = info[0];
	String num = info[1];

	int item = website.getRequestParameter(request,"item",0);
	int source = website.getRequestParameter(request,"tb",0);
	int mode = website.getRequestParameter(request,"mode",0);
	int id = website.getRequestParameter(request,"id",0);
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String message = "";
	String comment = "";

	if ( formName != null && formName.equals("aseForm") ){
		if ( alpha != null && num != null ){
			comment = ReviewerDB.getComment(conn,campus,kix,id);
		}	// alpha & num
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Delete Comment";

	asePool.freeConnection(conn);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscmntx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="/central/servlet/r2d2" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR height="20">
				<TD class="textblackTH" width="10%">Campus:</TD>
				<TD class="datacolumn"><%=campus%></TD>
			</TR>
			<TR height="20">
				<TD class="textblackTH" width="10%">Comment:</TD>
				<TD class="datacolumn"><%=comment%></TD>
			</TR>
			<TR height="20">
				<TD colspan="2"><div class="hr"></div></TD>
			</TR>
			<TR>
				<TD align="center" colspan="2">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=item%>" name="item">
					<input type="hidden" value="<%=source%>" name="tb">
					<input type="hidden" value="<%=mode%>" name="mode">
					<input type="hidden" value="<%=id%>" name="id">
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
					<input type="hidden" value="aseForm" name="formName">
					<input type="hidden" value="d" name="formAction">
						Do you wish to continue?<br/><br/>
					<input title="continue with request" name="aseDelete" id="aseDelete" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="end requested operation" name="aseCancel" id="aseCancel" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>


<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
