<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgedt6.jsp - program approval request - naming to match course approval
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// course to work with
	String thisPage = "prgedt6";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";
	int route = 0;

	int degree = 0;
	int division = 0;

	String formAction = website.getRequestParameter(request,"formAction","");
	String formName = website.getRequestParameter(request,"formName","");

	String progress = "";

	// all actions come in with a formaction
	if(formAction.equals("a")){
		progress = Constant.PROGRAM_APPROVAL_PROGRESS;
	}
	else if(formAction.equals("r")){
		progress = Constant.PROGRAM_REVISE_PROGRESS;
	}
	else if(formAction.equals("v")){
		progress = Constant.PROGRAM_REVIEW_PROGRESS;
	}

	// set in prgapprx and reset in prgedt
	if(progress.equals("")){
		progress = website.getRequestParameter(request,"aseProgress","",true);
		if(progress == null || progress.length() == 0){
			progress = Constant.PROGRAM_APPROVAL_PROGRESS;
			formAction = "a";
		}
		else if (progress.equals(Constant.PROGRAM_REVISE_PROGRESS)){
			formAction = "r";
		}
		else if (progress.equals(Constant.PROGRAM_REVIEW_PROGRESS)){
			formAction = "v";
		}
	}

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
		route = NumericUtil.nullToZero(info[Constant.KIX_ROUTE]);

		Programs program = ProgramsDB.getProgramToModify(conn,campus,kix);
		if ( program != null ){
			degree = program.getDegree();
			division = program.getDivision();
		}
		program = null;
	}

	// GUI
	String chromeWidth = "60%";

	String pageTitle = "Program " + progress + " Request";
	fieldsetTitle = pageTitle;

	String submissionForm = "prgedt6y";
	String outineSubmissionWithProgram = Util.getSessionMappedKey(session,"OutineSubmissionWithProgram");
	int counter = ProgramsDB.countPendingOutlinesForApproval(conn,campus,division);
	if (outineSubmissionWithProgram.equals(Constant.ON) && counter > 0){
		submissionForm = "prgedt6x";	// packet handling
	}

	// for review, it goes to submission because there are no packets
	if (progress.equals(Constant.PROGRAM_REVIEW_PROGRESS)){
		submissionForm = "prgedt6y";	// submission
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/prgedt6.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<%
	int routes = ApproverDB.getNumberOfRoutes(conn,campus);

	String disabled = "";
	String off = "";

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	if (processPage && routes > 0){

%>
		<form method="post" action="<%=submissionForm%>.jsp" name="aseForm">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
				<TBODY>
					<TR>
						<TD align="center">
							Do you wish to continue with the <%=progress%> request?
							<br/><br/>
						</TD>
					</TR>
					<TR>
						<TD align="center">
							<%
								if (progress.equals(Constant.PROGRAM_APPROVAL_PROGRESS)){
									String approverNames = ApproverDB.getApproversByRoute(conn,campus,route);
									if (routes > 1 && progress.equals(Constant.COURSE_APPROVAL_TEXT) && approverNames.equals(Constant.BLANK)){
										String HTMLFormField = Html.drawRadio(conn,"ApprovalRouting","selectedRoute",(route+""),campus,false,false);
										out.println("<br/>If <strong>YES</strong>, please select the approval routing to use<br/><br/>");
										out.println("<table border=\"0\"><tr><td>" + HTMLFormField + "</td></tr></table><br/>");
									}
									else{
										out.println("<input type=\"hidden\" name=\"selectedRoute\" value=\""+route+"\"");
									}
								}
							%>
						</td>
					</tr>

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
							<input id="cmdYes" <%=disabled%>  title="continue with request" type="submit" value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('<%=formAction%>')">&nbsp;
							<input id="cmdNo" <%=disabled%>  title="end requested operation" type="submit" value=" No  " class="inputsmallgray<%=off%>" onClick="return cancelForm()">
							<input type="hidden" value="<%=kix%>" name="kix">
							<input type="hidden" value="<%=formAction%>" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
							<input type="hidden" value="<%=submissionForm%>" name="submissionForm">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</form>

<%
	}

	asePool.freeConnection(conn,"prgedt6",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
