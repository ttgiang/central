<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcmntx - delete review comments
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "fndcmntx";
	session.setAttribute("aseThisPage",thisPage);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String kix = website.getRequestParameter(request,"kix", "");

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	String fndtype = fnd.getFndItem(conn,kix,"fndtype");

	String[] info = fnd.getKixInfo(conn,kix);
	String alpha = info[Constant.KIX_ALPHA];
	String num = info[Constant.KIX_NUM];

	int sq = website.getRequestParameter(request,"sq",0);
	int en = website.getRequestParameter(request,"en",0);
	int qn = website.getRequestParameter(request,"qn",0);
	int id = website.getRequestParameter(request,"id",0);
	int mode = website.getRequestParameter(request,"mode",0);

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

	String label = "";
	if(en > 0 && qn == 0){
		label = "Explanatory";
	}
	else if(en > 0 && qn > 0){
		label = "Question";
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/fndcmntx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="/central/servlet/r2d2" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR height="20">
				<TD class="textblackTH" width="10%">Hallmark:</TD>
				<TD class="datacolumn"><% out.println(fnd.getFoundations(conn,fndtype,sq,0,0)); %></TD>
			</TR>
			<TR height="20">
				<TD class="textblackTH" width="10%"><%=label%></TD>
				<TD class="datacolumn"><% out.println(fnd.getFoundations(conn,fndtype,sq,en,qn)); %></TD>
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
					<input type="hidden" value="<%=sq%>" name="sq">
					<input type="hidden" value="<%=en%>" name="en">
					<input type="hidden" value="<%=qn%>" name="qn">
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

<%

	fnd = null;

	asePool.freeConnection(conn,"fndcmntx",user);

%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
