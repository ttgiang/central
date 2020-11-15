<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrssy.jsp	reassign ownership of course edits, tasks, and reviews
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String fromName = website.getRequestParameter(request,"fromName");
	String toName = website.getRequestParameter(request,"toName");
	int controls = website.getRequestParameter(request,"controls",0,false);
	String message = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Reassigning Ownership";
	fieldsetTitle = pageTitle;

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	if (processPage){
		String skew = "0";

		if (Skew.confirmEncodedValue(request))
			skew = "1";

		String checked = "";
		String buf = "";

		for(int i=0;i<controls;i++){
			checked = website.getRequestParameter(request,"box_" + (i+1));
			if (!"".equals(checked)){
				if (i==0)
					buf = checked;
				else
					buf = buf + "~" +checked; // using ~ to avoid messing up servlet
			}
		}

		session.setAttribute("aseLinker",
			Encrypter.encrypter(	"campus="+campus+","
									+	"user="+user+","
									+	"skew="+skew+","
									+	"key1="+fromName+","
									+	"key2="+toName+","
									+	"key3="+buf+","
									+	"key6="+formName+","
									+	"key7="+formAction));
		response.sendRedirect("/central/servlet/mace");
	}
	asePool.freeConnection(conn,"crsrssy",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<p align="center"><%= message %></p>
<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
