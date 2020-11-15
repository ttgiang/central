<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprdltx.jsp
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

	int route = website.getRequestParameter(request,"route",0);

	String message = "";

	if (processPage){
		if ( formName != null && formName.equals("aseForm") ){
			if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){
				int rowsAffected = ApproverDB.deleteApprovalRouting(conn,campus,route);
				if (rowsAffected==1)
					message = "Approval routing deleted successfully";
				else if (rowsAffected==2)
					message = "Deletion not allowed because the routing is currently in used.";
				else
					message = "Approval routing deletion failed.<br><br>";
			}	// action = s
			else{
				message = "Invalid security code";
			}
		}	// valid form
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Delete Approval Routing";
	fieldsetTitle = pageTitle;

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"apprdltx ",user);
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
