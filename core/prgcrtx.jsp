<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgcrtx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String message = "";

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	if (processPage){
		if (formName != null && formName.equals("aseForm")){

			int degree = website.getRequestParameter(request,"degree",0);
			int division = website.getRequestParameter(request,"division",0);

			if (degree > 0 && division > 0 ){
				String skew = "0";

				if (Skew.confirmEncodedValue(request))
					skew = "1";

				String title = website.getRequestParameter(request,"title","");
				String description = website.getRequestParameter(request,"description","");
				String effectiveDate = website.getRequestParameter(request,"effectiveDate","");
				String year = website.getRequestParameter(request,"year","");
				String regentApproval = website.getRequestParameter(request,"regentApproval","");

				session.setAttribute("aseLinker",
					Encrypter.encrypter(	"kix=,"
											+	"campus="+campus+","
											+	"user="+user+","
											+	"skew="+skew+","
											+	"alpha=,"
											+	"num=,"
											+	"key1="+degree+","
											+	"key2="+division+","
											+	"key3="+title.replace(",","[ASE_COMMA]")+","
											+	"key4="+description.replace(",","[ASE_COMMA]")+","
											+	"key5="+effectiveDate+","
											+	"key6="+year+","
											+	"key7="+regentApproval+","
											+	"key8="+formName+","
											+	"key9="+formAction));

				response.sendRedirect("/central/servlet/amidala?ack=crt");
			} // degree & division
		}	// valid form
	} // processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Create Program";
	fieldsetTitle = "Create Program";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"prgcrtx",user);
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
