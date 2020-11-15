<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscanappr.jsp - cancel approval process
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String progress = "";
	String proposer = "";
	String alpha = "";;
	String num = "";;
	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String type = "PRE";

	String kix = website.getRequestParameter(request,"kix","",false);
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		type = info[2];
		proposer = info[3];
	}
	else{
		alpha = website.getRequestParameter(request,"alpha");
		num = website.getRequestParameter(request,"num");
	}

	if (kix==null || kix.length()==0){
		response.sendRedirect("sltcrs.jsp?cp=crscanappr&viewOption=PRE");
	}

	if (proposer.equals(Constant.BLANK))
		proposer = courseDB.getCourseProposer(conn,campus,alpha,num,"PRE");

	// GUI
	String chromeWidth = "60%";
	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Cancel Approval Process";

	String message = "";

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether approval may be cancelled at any time");

	if (processPage){
		if (alpha.length()>0 || num.length()>0 || kix.length()>0){
			progress = courseDB.getCourseProgress(conn,campus,alpha,num,"PRE");
			if (	progress.equals(Constant.COURSE_APPROVAL_TEXT) ||
					progress.equals(Constant.COURSE_APPROVAL_PENDING_TEXT) ||
					progress.equals(Constant.COURSE_DELETE_TEXT)){
				if (!proposer.equals(user)){
					message = "Cancellation is only available to the proposer of this outline.<br><br>";
				}
				else{
					//
					//	cancellation is permitted depending on campus. if a campus wants to allow cancellation at any time,
					//	that's permitted regardless of history.
					//
					String cancelApprovalAnyTime = Util.getSessionMappedKey(session,"CancelApprovalAnyTime");
					if (cancelApprovalAnyTime.equals(Constant.OFF) && HistoryDB.approvalStarted(conn,campus,alpha,num,user)){
						message = "Cancellation is not permitted once approvers start to add comments.<br><br>"
									+ "Contact your campus administrator and request the option to cancel approval at anytime.";
					}
				}
			}
			else{
				message = "This outline is not available for cancellation.";
			}

			if (!message.equals(Constant.BLANK) && !kix.equals(Constant.BLANK)){
				session.setAttribute("aseApplicationMessage",message);
				response.sendRedirect("msg.jsp?nomsg=1&kix" + kix);
			}
		} // if alpha
	} // if processPage

	String disabled = "";
	String off = "";

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	asePool.freeConnection(conn,"crscanappr",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscanappr.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<form method="post" action="crscanapprx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					Do you wish to continue?
					<br/><br/>
					<input type="hidden" value="<%=kix%>" name="kix">
					<input type="hidden" value="<%=alpha%>" name="alpha">
					<input type="hidden" value="<%=num%>" name="num">
				</TD>
			</TR>
			<TR><TD align="center"><% out.println(Skew.showInputScreen(request)); %></td></tr>

			<TR>
				<TD align="center">
					<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
					<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
					</div>
				</td>
			</tr>

			<TR>
				<TD align="center">
					<br />
					<input id="cmdYes" title="continue with request" type="submit" <%=disabled%>  value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('s')">&nbsp;
					<input id="cmdNo" title="end requested operation" type="submit" <%=disabled%> value=" No  " class="inputsmallgray<%=off%>" onClick="return cancelForm()">
					<input type="hidden" value="c" name="formAction">
					<input type="hidden" value="aseForm" name="formName">
				</TD>
			</TR>
		</TBODY>
	</TABLE>
</form>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
