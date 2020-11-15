<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgedt6x.jsp - program approval request - naming to match course approval
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// course to work with
	String thisPage = "prgedt6x";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";

	int degree = 0;
	int division = 0;

	int route = website.getRequestParameter(request,"selectedRoute",0);
	String kix = website.getRequestParameter(request,"kix","");
	if (!"".equals(kix)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];

		Programs program = ProgramsDB.getProgramToModify(conn,campus,kix);
		if ( program != null ){
			degree = program.getDegree();
			division = program.getDivision();
		}
		program = null;
	}

	String progress = Constant.PROGRAM_APPROVAL_PROGRESS;

	// screen has configurable item. setting determines whether
	// users are sent directly to news or task screen after login
	session.setAttribute("aseConfig","1");
	session.setAttribute("aseConfigMessage","Determines whether to display outlines for submission with program");

	String submissionMessage = "";
	String outineSubmissionWithProgram = Util.getSessionMappedKey(session,"OutineSubmissionWithProgram");
	int counter = ProgramsDB.countPendingOutlinesForApproval(conn,campus,division);
	if ((Constant.ON).equals(outineSubmissionWithProgram) && counter > 0)
		submissionMessage = "Do you wish to include the following outlines with your submission?";
	else
		submissionMessage = "Do you wish to continue?";

	// GUI
	String chromeWidth = "80%";
	String pageTitle = alpha;
	fieldsetTitle = "Program Approval Request";
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/prgedt6x.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br/>

<%
	String disabled = "";
	String off = "";

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	if (processPage){
%>
		<form method="post" action="prgedt6y.jsp" name="aseForm">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
				<TBODY>
					<TR>
						<TD align="center">
							<%=submissionMessage%>
							<br/><br/>
<%
	if (outineSubmissionWithProgram.equals(Constant.ON) && counter > 0){
		out.println("<fieldset class=FIELDSET90>" );
		out.println(helper.listOutlinesForSubmissionWithProgram(conn,campus,division));
		out.println("</fieldset>" );
	}

%>
							<input type="hidden" value="<%=kix%>" name="kix">
							<input type="hidden" value="<%=route%>" name="selectedRoute">
						</TD>
					</TR>

					<TR>
						<TD align="center">
							<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
							<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
							</div>
						</td>
					</tr>

					<TR>
						<TD align="center">
							<input id="cmdYes" name="cmdYes" <%=disabled%>  title="continue with request" type="submit" value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('s')">&nbsp;
							<input id="cmdNo"  name="cmdNo" <%=disabled%>  title="end requested operation" type="submit" value=" No  " class="inputsmallgray<%=off%>" onClick="return cancelForm()">
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</form>

<%
	}

	asePool.freeConnection(conn,"prgedt6x",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
