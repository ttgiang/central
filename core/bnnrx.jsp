<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	bnnrx.jsp - delete news file
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "bnnrx";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = "d";
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// GUI
	String chromeWidth = "60%";

	String key = website.getRequestParameter(request,"key","");
	String tbl = website.getRequestParameter(request,"tbl","");

	String table = "";
	String rtn = "";

	if (tbl.toLowerCase().equals("ba")){
		table = "Alpha";
		rtn = "alphaidx";
	}
	else if (tbl.toLowerCase().equals("bc")){
		table = "College";
		rtn = "cllgidx";
	}
	else if (tbl.toLowerCase().equals("bdt")){
		table = "Department";
		rtn = "dprtmnt";
	}
	else if (tbl.toLowerCase().equals("bdv")){
		table = "Division";
		rtn = "dvsn";
	}
	else if (tbl.toLowerCase().equals("bt")){
		table = "Terms";
		rtn = "trms";
	}

	String pageTitle = "Banner "+table+" Maintenance";

	fieldsetTitle = pageTitle;

	String code = "";
	String descr = "";

	BannerData data = BannerDataDB.getBannerData(conn,tbl,key);
	if (data != null){
		code = data.getCode();
		descr = data.getDescr();
	}

	asePool.freeConnection(conn,"bnnrx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script type="text/javascript" src="js/bnnrx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="/central/servlet/naboo" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR height="20">
				<TD class="textblackTH" width="20%">Code:</TD>
				<TD class="datacolumn"><%=code%></TD>
			</TR>

			<TR height="20">
				<TD class="textblackTH" width="20%">Description:</TD>
				<TD class="datacolumn"><%=descr%></TD>
			</TR>

			<TR height="20">
				<TD colspan="2"><div class="hr"></div></TD>
			</TR>
			<TR>
				<TD align="center" colspan="2">
					Do you wish to continue?<br/><br/>
					<br />
					<% out.println(Skew.showInputScreen(request)); %>
					<input type="hidden" value="<%=key%>" name="key">
					<input type="hidden" value="<%=tbl%>" name="tbl">
					<input type="hidden" value="<%=rtn%>" name="rtn">
				</TD>
			</TR>
			<TR>
				<TD align="center" colspan="2">
					<br />
					<input title="continue with request" type="submit" name="aseDelete" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
					<input title="end requested operation" type="submit" name="aseCancel" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
					<input type="hidden" value="<%=formAction%>" name="formAction" id="formAction">
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
