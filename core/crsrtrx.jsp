<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsrtrx.jsp	- restore outline
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String kix = website.getRequestParameter(request,"kix","");
	String tableType = website.getRequestParameter(request,"type","");
	String message = "";
	String alpha = "";
	String num = "";

	String[] info = helper.getKixInfo(conn,kix);
	alpha = info[0];
	num = info[1];

	if (processPage){
		if ( formName != null && formName.equals("aseForm") ){
			if ("s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
				if (courseDB.isCourseRestorable(conn,kix,user)){
					msg = CourseRestore.restoreOutline(conn,kix,user,tableType);
					if ( "Exception".equals(msg.getMsg()) ){
						message = "Outline restoration failed.<br><br>";
					}
					else if ( !"".equals(msg.getMsg()) ){
						message = "Unable to restore outline.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						message = "vwcrsx.jsp?cps="+campus+"&alpha="+alpha+"&num="+num+"&t=PRE";
						message = "Outline restored successfully.<br><br>Click <a href=\""+message+"\" class=\"linkcolumn\">here</a> to view restored outline.";
					}
				}
				else{
					message = "Unable to restore outline that is currently being modified.";
				}	// restorable
			}	// action = s
			else{
				message = "Invalid security code";
			}
		}	// valid form
	}	// processPage

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Restore Outline";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"crsrtrx",user);
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
</p>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
