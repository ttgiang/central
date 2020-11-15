<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	apprrqst.jsp - approving requests
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	// course to work with
	String thisPage = "apprrqst";
	session.setAttribute("aseThisPage",thisPage);

	String kix = website.getRequestParameter(request,"kix","0");

	// GUI
	String chromeWidth = "80%";
	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");
	String pageTitle = "Approve Outline Request";
	fieldsetTitle = pageTitle;

%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/apprrqst.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>
<br />

<%
	String disabled = "";
	String off = "";
	boolean showButtons = true;

	if (!processPage){
		disabled = "disabled";
		off = "off";
	}

	if (processPage){
%>
		<form method="post" action="/central/servlet/pokey?src=apprrqst" name="aseForm">
			<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
				<TBODY>
					<tr>
						<td>
							<%
								if (processPage){
									String temp = RequisiteDB.listRequisitesToApprove(conn,kix,user);

									if (temp != null && temp.equals(Constant.BLANK)){
										out.println("There is nothing to approve.<br><br>If you believe this is an error, inquire with the proposer otherwise, the stray task will be removed the next time you login into the system.");
										showButtons = false;
									}
									else{
										out.println(temp);
									}
								}
								else{
									out.println("Unable to process your request");
								}
							%>
						</td>
					</tr>

					<TR>
						<TD align="center">
							<div style="visibility:hidden; border: 0px solid rgb(204, 204, 204); overflow: height: 400px; width: 100%;" id="spinner">
							<p align="center"><img src="../images/spinner.gif" alt="processing..." border="0"><br/>processing...</p>
							</div>
						</td>
					</tr>

<%
				if (showButtons){
%>
					<TR>
						<TD align="right">
							<br />
							<div class="hr"></div>
							<input id="cmdSubmit" name="cmdSubmit" <%=disabled%>  title="continue with request" type="submit" value="Submit" class="inputsmallgray<%=off%>">&nbsp;
							<input id="cmdCancel" name="cmdCancel" <%=disabled%>  title="end requested operation" type="submit" value="Cancel" class="inputsmallgray<%=off%>" onClick="return cancelForm()">
							<input type="hidden" value="<%=kix%>" name="kix">
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="aseForm" name="formName">
							&nbsp;&nbsp;&nbsp;
						</TD>
					</TR>
<%
				}
%>

				</TBODY>
			</TABLE>
		</form>

<%
	}

	asePool.freeConnection(conn,"apprrqst",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

