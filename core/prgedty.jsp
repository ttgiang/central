<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	prgedty.jsp - confirm request to modify approved program
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	// course to work with
	String thisPage = "prgedty";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals("")){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[Constant.KIX_PROGRAM_TITLE];
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String progress = website.getRequestParameter(request,"aseProgress","",true);

	String pageTitle = "Modify Approved Program";

	if(progress.equals(Constant.PROGRAM_REVIEW_PROGRESS)){
		pageTitle = "Review Program";
	}
	else{
		pageTitle = "Modify Program";
	}

	fieldsetTitle = pageTitle;

	boolean editable = false;
	String message = "";

	if (ProgramsDB.isApprovedProgramEditable(conn,campus,kix)) {
		editable = true;
	}
	else{
		msg.setMsg("NotEditable");
		message = MsgDB.getMsgDetail(msg.getMsg());
		editable = false;
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/prgedty.js"></script>
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

	if (processPage && routes > 0 && editable){
%>
		<form method="post" action="prgedtz.jsp" name="aseForm">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
				<TBODY>
					<TR>
						<TD align="center">
							Do you wish to continue with your request?
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
							<input id="cmdYes" <%=disabled%>  title="continue with request" type="submit" value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('s')">&nbsp;
							<input id="cmdNo" <%=disabled%>  title="end requested operation" type="submit" value=" No  " class="inputsmallgray<%=off%>" onClick="return cancelForm()">
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</form>

<%
	}
	else
		out.println("<p align=\"center\">" + message + "</p>");

	asePool.freeConnection(conn,"prgedty",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
