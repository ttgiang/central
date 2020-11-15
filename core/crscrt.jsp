<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	crscrt.jsp	create new outline.
	*	TODO: crscrt.js has code for checkData
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		response.sendRedirect("../exp/notauth.jsp");
		processPage = false;
	}

	session.setAttribute("aseThisPage","crscrt");

	// GUI
	String chromeWidth = "70%";
	String pageTitle = "screen 1 of 4";
	fieldsetTitle = "Create New Outline ";
	String sql = "";

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);
	String alpha = website.getRequestParameter(request,"alpha","",false);
	String alphas = UserDB.getUserDepartments(conn,user);

	// must be set to 30 as Banner dictates it.
	int maxTitleLength = 30;

	String continueDisabled = "";
	String continueClass = "";

	/*
		final catch for approval button
	*/
	if (DateUtility.isTodayInRangeWith(conn,campus,"ProposedOutlineBlockedDate")){
		continueClass = "off";
		continueDisabled = "disabled";
	}

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/crscrt.js"></script>
	<script language="JavaScript" type="text/javascript" src="js/textcounter.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<%
	if (processPage){
%>
	<form method="post" name="aseForm" action="crscrtx.jsp">
		<input type="hidden" name="campus" value="<%=campus%>">

		<table height="90" width="100%" cellspacing='1' cellpadding='2' align="center"  border="0">
			<tr height="30">
				 <td class="textblackTH" width="15%">Campus:&nbsp;</td>
				 <td class="dataColumn"><%=campus%></td>
			</tr>

			<tr height="30">
				 <td class="textblackTH" nowrap>Proposer:&nbsp;</td>
				 <td class="dataColumn"><%=user%></td>
			</tr>

			<tr height="30">
				 <td class="textblackTH" nowrap>&nbsp;</td>
				 <td class="dataColumn">
					 The first step for new courses is to check the most recent list of Active Courses in the UH System to determine which alphas and numbers are in use.
					 <br/><br/>If the new course you are proposing is the same as another course in the system, use that alpha and number.
					 <br/><br/>You may also search the entire list at UHCC Master Course List.
					 <br/><br/>
					 <ul>
						<li>UH Community College Master Course List<br/>
							<a href="http://www.hawaii.edu/offices/cc/docs/mastercourselist.pdf" class="linkcolumn" target="_blank">http://www.hawaii.edu/offices/cc/docs/mastercourselist.pdf</a><br/><br/>
						</li>
						<li>University of Hawaii Master Course List (Active courses in the UH system)<br/>
							<a href="https://www.sis.hawaii.edu/uhdad/bwckctlg.p_disp_dyn_ctlg" class="linkcolumn" target="_blank">https://www.sis.hawaii.edu/uhdad/bwckctlg.p_disp_dyn_ctlg</a>
						</li>
					 </ul>
				 </td>
			</tr>

			<tr>
				 <td class="textblackTHRight" colspan="2">
						<div class="hr"></div>
						<input type="hidden" name="formName" value="aseForm">
						<input type="hidden" name="formAction" value="c">
						<input type="hidden" name="textLen" value="0">
						<input type="hidden" name="badData" value="">
						<input title="continue" type="submit" name="aseSubmit" value="Continue" <%=continueDisabled%> class="inputsmallgray<%=continueClass%>" class="inputsmallgray" onClick="return checkForm('s')">
						<input title="abort selected operation" type="submit" name="aseCancel" value="Cancel" class="inputsmallgray" onClick="return cancelForm()">
						<br/><br/>

						<%
							if (continueDisabled.equals("disabled")){
								String[] listRange = Util.getINIKeyValues(conn,campus,"ProposedOutlineBlockedDate");
								if (listRange != null){
									out.println("Outline creation/approval is not permitted between " + listRange[0] + " and " + listRange[1] + ".");
								}
							}
						%>
				 </td>
			</tr>
		</table>
	</form>

<%
	}

	asePool.freeConnection(conn,"crscrt",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
