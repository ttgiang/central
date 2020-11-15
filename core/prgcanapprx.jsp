<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgcanapprx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String kix = "";
	String alpha = "";
	String num = "";
	String message = "";
	String progress = "";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	kix = website.getRequestParameter(request,"kix","");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
	}

	if (processPage && formName != null && formName.equals("aseForm") ){
		if ("s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
			progress = ProgramsDB.getProgramProgress(conn,campus,kix);
			if ((Constant.PROGRAM_APPROVAL_PROGRESS).equals(progress))
				msg = ProgramsDB.cancelProgramApproval(conn,campus,kix,user);
			else if ((Constant.PROGRAM_DELETE_PROGRESS).equals(progress))
				msg = ProgramDelete.cancelProgramDelete(conn,kix,user);

			if ("Exception".equals(msg.getMsg())){
				message = "Program approval cancellation failed.<br><br>" + msg.getErrorLog();
			}
			else if ( !"".equals(msg.getMsg()) ){
				message = "Unable to cancel approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
			}
			else{
				message = "Approval cancelled successfully<br>";
			}
		}	// action = s
		else{
			message = "Invalid security code";
		}
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = alpha;
	fieldsetTitle = "Cancel Program Approval Process";

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
