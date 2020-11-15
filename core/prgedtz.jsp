<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgedtz.jsp - set up for editing of CUR programs
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "80%";
	fieldsetTitle = "Modify Approved Program";
	String pageTitle = fieldsetTitle;

	String formAction = website.getRequestParameter(request,"formAction", "");
	String formName = website.getRequestParameter(request,"formName", "");

	String kix = website.getRequestParameter(request,"kix", "");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String message = "";
	String url = "";

	if (processPage && formName != null && formName.equals("aseForm") ){
		if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){
			session.setAttribute("aseRequestToStartModify", "1");
			url = "shwprgfld.jsp?rtn=prgedt&kix="+kix;
		}	// action = s
		else{
			message = "Invalid security code";
		}
	} // processPage
	else{
		message = "Unable to process request";
	} // processPage
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">
<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if ((Constant.BLANK).equals(message))
		response.sendRedirect(url);

	asePool.freeConnection(conn,"prgedtz",user);

	out.println( "<br><p align='center'>" + message + "</p>" );
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
