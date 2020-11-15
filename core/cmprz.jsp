<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	cmprz.jsp	copy outlne items
	*	2007.09.01
	**/

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String kixSource = website.getRequestParameter(request,"kixSource","");
	String kixDestination = website.getRequestParameter(request,"kixDestination","");
	String input = website.getRequestParameter(request,"input","");

	String message = "";
	String alpha = "";
	String num = "";

	if (!"".equals(kixSource)){
		String[] info = helper.getKixInfoFromOldCC(conn,kixSource);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
	}

	if ( formName != null && formName.equals("aseForm") ){
		if ("s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
			if (kixSource.length() > 0 && kixDestination.length() > 0){
				msg = Outlines.copyOutlineItems(conn,request,user);
				if ("Exception".equals(msg.getMsg()))
					message = "Outline copy failed.<br><br>";
				else
					message = "Outline items copied successfully<br>";
			}
		}	// action = s
		else{
			message = "Invalid security code";
		}
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Copy Outline Items";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

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
<p align="center"><%= message %></p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
