<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	appraddy.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String shortName = website.getRequestParameter(request,"shortName","");
	String longName = website.getRequestParameter(request,"longName","");

	String formSelect = website.getRequestParameter(request,"formSelect","");
	String college = website.getRequestParameter(request,"college","");
	String dept = website.getRequestParameter(request,"dept","");
	String level = website.getRequestParameter(request,"level","");

	String message = "";
	int rowsAffected = 0;

	if (processPage){
		if ( formName != null && formName.equals("aseForm") ){
			if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){
				rowsAffected = ApproverDB.addApprovalRouting(conn,campus,user,shortName,longName,formSelect,college,dept,level);
				if (rowsAffected > 0)
					message = "Approval routing added successfully";
				else
					message = "Unable to add approval routing.<br><br>";
			}	// action = s
			else{
				message = "Invalid security code";
			}
		}	// valid form
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Add Approval Routing";
	fieldsetTitle = pageTitle;

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"appraddy ",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />
<p align="center"><%=message%>
<br/><br/>
<a href="appridx.jsp" class="linkcolumn">return</a> to approval routing
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
