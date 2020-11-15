<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.ase.aseutil.Skew"%>
<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	fndcanx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with

	String thisPage = "fndcanx";
	session.setAttribute("aseThisPage",thisPage);

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String kix = "";
	String alpha = "";
	String num = "";
	String courseTitle = "";
	String fndType = "";

	com.ase.aseutil.fnd.FndDB fnd = new com.ase.aseutil.fnd.FndDB();

	int id = website.getRequestParameter(request,"id",0);
	if(id > 0){
		kix = fnd.getFndItem(conn,id,"historyid");
		if(!kix.equals(Constant.BLANK)){
			String[] info = fnd.getKixInfo(conn,kix);
			alpha = info[Constant.KIX_ALPHA];
			num = info[Constant.KIX_NUM];
			courseTitle = info[Constant.KIX_COURSETITLE];
			fndType = info[Constant.KIX_ROUTE];
		}
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = alpha + " " + num + " - " + courseTitle + "<br/>" + fnd.getFoundationDescr(fndType);
	fieldsetTitle = "Foundation Course Cancellation";

	if (kix.length()>0 && processPage){
		if (!fnd.isCancellable(conn,campus,user,kix,id)){
			String message = "You are not authorized to cancel this outline or cancellation is not permitted at this time.";
			session.setAttribute("aseApplicationMessage",message);
			response.sendRedirect("msg.jsp?nomsg=1&kix=" + kix + "&campus=" + campus + "&rtn=" + thisPage);
		}
	}

	String disabled = "";
	String off = "";

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	fnd = null;

	asePool.freeConnection(conn,"fndcanx",user);

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/fndcan.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<form method="post" action="fndcany.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					Do you wish to continue?
					<br /><br />
					<input type="hidden" value="<%=id%>" name="id">
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
				</TD>
			</TR>
			<TR><TD align="center"><% out.println(Skew.showInputScreen(request)); %></td></tr>

			<TR>
				<TD align="center">
					<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
					<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
					</div>
				</td>
			</tr>

			<TR>
				<TD align="center">
					<br />
					<input id="cmdYes" name="cmdYes" title="continue with request" type="submit" <%=disabled%> value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('s')">&nbsp;
					<input id="cmdNo"  name="cmdNo" title="end requested operation" type="submit" <%=disabled%> value=" No  " class="inputsmallgray<%=off%>" onClick="return cancelForm()">
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

