<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscanapprx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String kix = "";
	String alpha = "";
	String num = "";
	String message = "";
	String progress = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	kix = website.getRequestParameter(request,"kix","");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha","");
		num = website.getRequestParameter(request,"num","");
	}

	if ( formName != null && formName.equals("aseForm") ){
		if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){
			if ( alpha.length() > 0 && num.length() > 0 ){

				progress = courseDB.getCourseProgress(conn,campus,alpha,num,"PRE");

				if (progress.equals(Constant.COURSE_APPROVAL_TEXT) || progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT)){
					msg = courseDB.cancelOutlineApproval(conn,campus,alpha,num,user);
				}
				else if (progress.equals(Constant.COURSE_DELETE_TEXT)){
					msg = CourseDelete.cancelOutlineDelete(conn,kix,user);
				}

				if ("Exception".equals(msg.getMsg())){
					message = "Outline approval cancellation failed.<br><br>" + msg.getErrorLog();
				}
				else if ( !"".equals(msg.getMsg()) ){
					message = "Unable to cancel outline approval.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
				}
				else{
					message = "Outline approval cancelled successfully<br>";
				}
			}	// course alpha and num length
		}	// action = s
		else{
			message = "Invalid security code";
		}
	}	// valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Cancelling Outline Approval Process";

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
