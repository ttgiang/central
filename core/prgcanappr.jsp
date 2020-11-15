<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgcanappr.jsp - cancel approval process
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String progress = "";
	String proposer = "";
	String alpha = "";;
	String num = "";;

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String kix = website.getRequestParameter(request,"kix","");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		num = info[Constant.KIX_PROGRAM_DIVISION];
		proposer = info[3];
	}

	if (kix==null || kix.length()==0){
		response.sendRedirect("sltcrs.jsp?cp=prgcanappr&viewOption=PRE");
	}

	// GUI
	String chromeWidth = "60%";
	String pageTitle = alpha;
	fieldsetTitle = "Cancel Approval Process";

	String message = "";

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether approval may be cancelled at any time");

	if (processPage){
		if (proposer.equals(Constant.BLANK)){
			proposer = ProgramsDB.getProgramProposer(conn,campus,kix);
		}

		progress = ProgramsDB.getProgramProgress(conn,campus,kix);

		if (	progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS) ||
				progress.equals(Constant.PROGRAM_DELETE_PROGRESS)){
			if (!proposer.equals(user)){
				message = "Cancellation is only available to the proposer of this program.<br><br>";
			}
			else{
				/*
					cancellation is permitted depending on campus. if a campus wants to allow cancellation at any time,
					that's permitted regardless of history.
				*/
				String CancelApprovalAnyTime = Util.getSessionMappedKey(session,"CancelApprovalAnyTime");
				if ("0".equals(CancelApprovalAnyTime) && HistoryDB.approvalStarted(conn,campus,alpha,num,user)){
					message = "Cancellation is not permitted once approvers start to add comments.<br><br>";
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
	} // if processPage

	String disabled = "";
	String off = "";

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	asePool.freeConnection(conn,"prgcanappr",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/prgcanappr.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />
<form method="post" action="prgcanapprx.jsp" name="aseForm">
	<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
		<TBODY>
			<TR>
				<TD align="center">
					Do you wish to continue?
					<br/><br/>
					<input type="hidden" value="<%=kix%>" name="kix">
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
					<input id="cmdYes" name="cmdYes" title="continue with request" type="submit" <%=disabled%>  value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('s')">&nbsp;
					<input id="cmdNo"  name="cmdNo" title="end requested operation" type="submit" <%=disabled%> value=" No  " class="inputsmallgray<%=off%>" onClick="return cancelForm()">
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
