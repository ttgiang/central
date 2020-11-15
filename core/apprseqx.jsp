<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprseqx.seq - approval sequence update
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "apprseqx";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";

	String kix = website.getRequestParameter(request,"kix");
	int route = website.getRequestParameter(request,"r",0);
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}

	// GUI
	String chromeWidth = "60%";
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline Approval Sequence";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/apprseq.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="apprseqy.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD>
					<%
						String HTMLFormField = Html.drawRadio(conn,"ApprovalRouting","route",(route+""),campus,false);
						out.println("<table border=\"0\"><tr><td>" + HTMLFormField + "</td></tr></table><br/>");
					%>
				</td>
			</tr>
			<TR>
				<TD align="right">
					<div class="hr"></div>
					<input title="continue with request" type="submit" value="Submit" class="inputsmallgray">&nbsp;
					<input title="end requested operation" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
					<input type="hidden" value="<%=route%>" name="oldRoute">
					<input type="hidden" value="<%=kix%>" name="kix">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%
	asePool.freeConnection(conn,"apprseqx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
