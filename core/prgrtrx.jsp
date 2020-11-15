<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrtrx.jsp	- restore program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	String tableType = website.getRequestParameter(request,"type","");
	String message = "";
	String alpha = "";
	String num = "";

	String[] info = helper.getKixInfo(conn,kix);
	alpha = info[Constant.KIX_PROGRAM_TITLE];
	num = info[Constant.KIX_PROGRAM_DIVISION];

	if (processPage){
		if ( formName != null && formName.equals("aseForm") ){
			if ("s".equalsIgnoreCase(formAction) && Skew.confirmEncodedValue(request)){
				if (ProgramsDB.isProgramRestorable(conn,campus,kix)){
					msg = ProgramRestore.restoreProgram(conn,campus,kix,user);
					if ( "Exception".equals(msg.getMsg()) ){
						message = "Program restoration failed.<br><br>";
					}
					else if ( !"".equals(msg.getMsg()) ){
						message = "Unable to restore program.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						message = "prgvw.jsp?type=PRE&kix="+kix;
						message = "Program restored successfully.<br><br>Click <a href=\""+message+"\" class=\"linkcolumn\">here</a> to view restored program.";
					}
				}
				else{
					message = "Unable to restore program that is currently being modified.";
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
	fieldsetTitle = "Restore program";

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"prgrtrx",user);
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
