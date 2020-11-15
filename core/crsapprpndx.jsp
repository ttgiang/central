<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crsapprpndx.jsp - outline approval pending submission
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// GUI
	String chromeWidth = "60%";
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	boolean packet = false;

	// course to work with
	String thisPage = "crsapprpnd";
	session.setAttribute("aseThisPage",thisPage);

	String alpha = "";
	String num = "";
	int route = 0;

	String kix = website.getRequestParameter(request,"kix");
	if (!kix.equals(Constant.BLANK)){
		String[] info = helper.getKixInfo(conn,kix);
		alpha = info[0];
		num = info[1];
	}
	else{
		alpha = website.getRequestParameter(request,"aseAlpha","",true);
		num = website.getRequestParameter(request,"aseNum","",true);
	}

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	//
	//	formAction exists only when dealing with approval for a list of outlines
	//
	String formName = website.getRequestParameter(request,"formName","");

	if (processPage && formName != null && formName.equals("aseForm") ){
		packet = true;
		pageTitle = "Outline Packet Submission";
	} // processPage

	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crsapprpndx.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<%
	int routes = ApproverDB.getNumberOfRoutes(conn,campus);

	String HTMLFormField = "";
	String ApprovalSubmissionAsPackets = Util.getSessionMappedKey(session,"ApprovalSubmissionAsPackets");
	String disabled = "";
	String off = "";

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	//System.out.println("routes: " + routes);
	//System.out.println("route: " + route);
	//System.out.println("ApprovalSubmissionAsPackets: " + ApprovalSubmissionAsPackets);

	if (routes > 1 || route == 0){
		// ER00027 - MAN  - 2011.12.05
		// limit the number of routing shown
		if (ApprovalSubmissionAsPackets.equals(Constant.ON)){
			HTMLFormField = ApproverDB.drawApprovalSequence(conn,campus,user,alpha);
		}
		else{
			HTMLFormField = Html.drawRadio(conn,"ApprovalRouting","route",(route+""),campus,false);
		}
	}

	// HTMLFormField contains valid approval routing?
	if(HTMLFormField.indexOf("input") == -1 || HTMLFormField.equals("")){
		processPage = false;
	}

	if (processPage){

%>
	<form method="post" action="crsapprpndy.jsp" name="aseForm">
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TBODY>
				<TR>
					<TD align="center">
						Do you wish to continue with the approval request?
						<br/><br/>
						<input type="hidden" value="<%=packet%>" name="packet">
						<input type="hidden" value="<%=kix%>" name="kix">
						<input type="hidden" value="<%=alpha%>" name="alpha">
						<input type="hidden" value="<%=num%>" name="num">
					</TD>
				</TR>
				<TR>
					<TD>
						<h3 class="subheaderleftjustify">YES</h3>
					</td>
				</tr>
				<TR>
					<TD align="center">
						<%
							if (routes > 1 || route == 0){
								out.println("<br/>If <strong>YES</strong>, please select the approval routing to use<br/><br/>");
								out.println("<table border=\"0\"><tr><td>" + HTMLFormField + "</td></tr></table><br/>");
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
						<input name="cmdYes" id="cmdYes" <%=disabled%>  title="continue with request" type="submit" value=" Yes " class="inputsmallgray<%=off%>" onClick="return checkForm('s','1')">&nbsp;
					</TD>
				</TR>


				<TR>
					<TD align="center">
						<h3 class="subheaderleftjustify">NO</h3>

						<p>If <b>NO</b>, Please explain.</p>

						<p><textarea name="content" id="content" cols="100" rows="10" class="input"></textarea></p>

						<p>
						<input name="cmdNo" id="cmdNo" <%=disabled%>  title="end requested operation" type="submit" value=" No" class="inputsmallgray<%=off%>" onClick="return checkForm('s','0')">
						&nbsp;&nbsp;
						<input id="cmdCancel" title="end requested operation" type="submit" value=" Cancel" class="inputsmallgray" onClick="return cancelForm()">
						</p>

						<input type="hidden" value="c" name="formAction">
						<input type="hidden" value="aseForm" name="formName">
					</TD>
				</TR>

			</TBODY>
		</TABLE>
	</form>

<%
	}
	else{
		out.println("Approval routing has not been configured. Please contact your campus administrator.");
	} // process page

	asePool.freeConnection(conn,"crsapprpndx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

