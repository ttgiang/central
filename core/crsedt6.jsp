<%@ page import="org.apache.log4j.Logger"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsedt6.jsp - confirmation page for outline approval
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "crsedt6";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
		route = NumericUtil.nullToZero(info[6]);
	}
	else{
		alpha = website.getRequestParameter(request,"aseAlpha","",true);
		num = website.getRequestParameter(request,"aseNum","",true);
	}

	String progress = website.getRequestParameter(request,"aseProgress","",true);

	if ((alpha==null || alpha.length()==0) && (num==null || num.length()==0)){
		response.sendRedirect("index.jsp");
	}

	// GUI
	String chromeWidth = "60%";

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);
	fieldsetTitle = "Outline " + progress + " Request";

	// outline audit stamp
	String lastUpdated = courseDB.getCourseItem(conn,kix,"auditdate");
	String[] taskText = TaskDB.getTaskMenuText(conn,"Work on New Course Outline",campus,alpha,num,"PRE",kix);
	String outlineStatus = taskText[Constant.TASK_MESSAGE];

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsedt6.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheaderx.jsp" %>
<br />

<%
	int routes = ApproverDB.getNumberOfRoutes(conn,campus);

	String disabled = "";
	String HTMLFormField = "";
	String off = "";
	int packet = 0;

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	//
	//	1) confirm that we are still in approval progress
	//	2) are we submitting as packets?
	//		if yes,
	//			submit as pending
	//		else
	//			1) when there is more than 1 routing sequence (routes) and we are approving,
	//			2) be sure to ask for the route to use.
	//			3) However, don't ask if approval is already in progress and this is returning to approval.
	//				if there are no names, ask for routing
	//
	String approvalSubmissionAsPackets =
			IniDB.getIniByCampusCategoryKidKey1(conn,campus,"System","ApprovalSubmissionAsPackets");

	//
	// 1) make sure we are really in approval progress
	//
	if (progress.equals(Constant.COURSE_APPROVAL_TEXT)){

		//
		// 2) packet?
		//
		if (approvalSubmissionAsPackets.equals(Constant.ON) &&
			!progress.equals(Constant.COURSE_REVIEW_TEXT)){

			packet = 1;
		}
		else{
			String approverNames = ApproverDB.getApproversByRoute(conn,campus,route);
			boolean approvalAlreadyInProgress = ApproverDB.approvalAlreadyInProgress(conn,kix);
			if (routes > 1 &&
				progress.equals(Constant.COURSE_APPROVAL_TEXT) &&
				!approvalAlreadyInProgress ||
				approverNames.equals(Constant.BLANK)){

				HTMLFormField = ApproverDB.drawApprovalSequence(conn,campus,user,alpha);
				if(HTMLFormField.equals(Constant.BLANK)){
					processPage = false;
				}

			}
		} // approvalSubmissionAsPacket
	} // progress

	if (processPage && routes > 0){
%>
		<form method="post" action="crsedt6x.jsp" name="aseForm">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
				<TBODY>
					<TR>
						<TD align="center">
							Do you wish to continue with the <%=progress%> request?
							<br/><br/>
							<input type="hidden" value="<%=kix%>" name="kix">
							<input type="hidden" value="<%=alpha%>" name="alpha">
							<input type="hidden" value="<%=num%>" name="num">
						</TD>
					</TR>
					<TR>
						<TD align="center">
							<%
								// in approval, don't display if a route is already available
								if(progress.equals(Constant.COURSE_APPROVAL_TEXT) && packet == 0 && route == 0){
							%>
								<br/>If <strong>YES</strong>, please select the approval routing to use<br/><br/>
								<table border="0"><tr><td><%=HTMLFormField%></td></tr></table><br/>
							<%
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
							<input id="cmdYes" name="cmdYes" <%=disabled%>  title="continue with request" type="submit" value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('s')">&nbsp;
							<input id="cmdNo"  name="cmdNo" <%=disabled%>  title="end requested operation" type="submit" value=" No  " class="inputsmallgray<%=off%>" onClick="return cancelForm()">
							<input type="hidden" value="<%=packet%>" name="packet">
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
							<input type="hidden" value="<%=route%>" name="selectedRoute">
						</TD>
					</TR>
				</TBODY>
			</TABLE>
		</form>
<%
	}
	else{
		if(!processPage && HTMLFormField.equals(Constant.BLANK)){
			out.println("Approval routing not found for your campus. Please contact your Curriculum Central (CC) administrator.");
		}
		else if (routes == 0){
			if (SQLUtil.isCampusAdmin(conn,user) || SQLUtil.isSysAdmin(conn,user))
				out.println("Approval routing not found for your campus.<br/><br/>"
					+ "Click <a href=\"appridx.jsp?pageClr=1\" class=\"linkcolumn\">here</a> to create approval routing.");
			else
				out.println("Approval routing not found for your campus. Please contact your Curriculum Central (CC) administrator.");
		}

	} // processPage

	asePool.freeConnection(conn,"crsedt6",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>

</body>
</html>
