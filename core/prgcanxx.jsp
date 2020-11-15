<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgcanxx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String message = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		if (formName != null && formName.equals("aseForm")){

			String kix = website.getRequestParameter(request,"kix","");
			if (kix != null && kix.length() > 0){
				String skew = "0";

				if (Skew.confirmEncodedValue(request))
					skew = "1";

				session.setAttribute("aseLinker",
					Encrypter.encrypter(	"kix="+kix+","
											+	"campus="+campus+","
											+	"user="+user+","
											+	"skew="+skew+","
											+	"alpha=,"
											+	"num=,"
											+	"key1=,"
											+	"key2=,"
											+	"key3=,"
											+	"key4=,"
											+	"key5=,"
											+	"key6=,"
											+	"key7=,"
											+	"key8="+formName+","
											+	"key9="+formAction));

				response.sendRedirect("/central/servlet/amidala?ack=can");
			} // kix
		}	// valid form
	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Cancel Program";
	fieldsetTitle = "Cancel Program";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"prgcanxx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="center"><%=message%></p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
