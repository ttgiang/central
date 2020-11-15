<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	verifySQLx.jsp
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.SYSADM, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String message = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	StringBuffer buf = new StringBuffer();

	if ( formName != null && formName.equals("aseForm") ){
		if ("s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
				boolean debug = true;
				buf.append(SQLUtil.verifySQL(conn,"Access",debug)+"<br><br>");
				buf.append(SQLUtil.verifySQL(conn,"Oracle",debug)+"<br><br>");
				buf.append(SQLUtil.verifySQL(conn,"SQL",debug));
				message = buf.toString();
		}
		else{
			message = "Invalid security code";
		}
	}	// valid form

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
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
	<TBODY><TR><TD><%=message%></TD></TR></TBODY>
</TABLE>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
