<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgrvwcanx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String chromeWidth = "60%";
	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = "";
	String alpha = "";
	String num = "";
	String message = "";
	String proposer = "";

	fieldsetTitle = "Cancel Program Review";

	kix = website.getRequestParameter(request,"kix","");
	if (processPage && !"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];

		if ( formName != null && formName.equals("aseForm") ){
			if (formAction.equalsIgnoreCase("s") && Skew.confirmEncodedValue(request)){

				//
				//	kix is the id from table course. we'll start using the id where applicable.
				//	to avoid trouble with older implementation, we use kix to get the alpha and
				//	num needed for this to continue on successfully.
				//
				//	kix works when we come here from sltcrs. when coming from task, kix does
				//	not exists.
				//

				proposer = ProgramsDB.getProgramProposer(conn,campus,kix);
				if (!proposer.equals(user)){
					message = "This option is only available to the proposer of this program.<br><br>";
				}
				else{
					msg = ProgramsDB.cancelProgramReview(conn,campus,kix,user);
					if ("Exception".equals(msg.getMsg())){
						message = "Program review cancellation failed.<br><br>" + msg.getErrorLog();
					}
					else if ( !"".equals(msg.getMsg()) ){
						message = "Unable to cancel program review.<br><br>" + MsgDB.getMsgDetail(msg.getMsg());
					}
					else{
						message = "Program cancelled successfully<br>";
					}
				}	// proposer
			}	// action = s
			else{
				message = "Invalid security code";
			}
		}	// valid form
	}
	else{
		message = "Unable to process request";
	}

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"prgrvwcanx",user);
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
