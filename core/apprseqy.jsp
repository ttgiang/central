<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprseqy.seq - approval sequence update
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String thisPage = "apprseqx";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";

	String kix = website.getRequestParameter(request,"kix","");
	int oldRoute = website.getRequestParameter(request,"oldRoute",0);
	int newRoute = website.getRequestParameter(request,"route",0);
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}

	String oldRouteName = ApproverDB.getRoutingFullNameByID(conn,campus,oldRoute);
	String newRouteName = ApproverDB.getRoutingFullNameByID(conn,campus,newRoute);

	// GUI
	String chromeWidth = "60%";
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

<form method="post" action="apprseq.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD>
					<font class="textblackth">Confirm request to change route from</font>
					<font class="datacolumn"><%=oldRouteName%></font>
					<font class="textblackth">to</font>
					<font class="datacolumn"><%=newRouteName%></font>.
				</td>
			</tr>
			<TR>
				<TD align="right">
					<div class="hr"></div>
					<input title="continue with request" type="submit" value="Submit" class="inputsmallgray">&nbsp;
					<input title="end requested operation" type="submit" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
					<input type="hidden" value="<%=oldRoute%>" name="oldRoute">
					<input type="hidden" value="<%=newRoute%>" name="newRoute">
					<input type="hidden" value="<%=kix%>" name="kix">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%
	asePool.freeConnection(conn,"apprseqy",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
