<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	rnmcanx.jsp
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.FACULTY, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String thisPage = "rnmcan";
	session.setAttribute("aseThisPage",thisPage);

	String formAction = website.getRequestParameter(request,"formAction");
	String formName = website.getRequestParameter(request,"formName");
	String fromAlpha = "";
	String fromNum = "";
	String toAlpha = "";
	String toNum = "";
	String type = "";
	String proposer = "";
	String justification = "";

	boolean showForm = true;

	String campus = website.getRequestParameter(request,"aseCampus","",true);
	String user = website.getRequestParameter(request,"aseUserName","",true);

	String message = "Do you wish to continue with cancel operation?";

	String kix = website.getRequestParameter(request,"kix");

	if (formName != null && formName.equals("aseForm") && formAction.equalsIgnoreCase("s")){

		showForm = false;

		proposer = courseDB.getCourseItem(conn,kix,"proposer");
		if(user.equals(proposer)){
			RenameDB renameDB = new RenameDB();
			renameDB.cancel(conn,campus,user,kix);
			renameDB = null;
			message = "Rename/renumber cancelled successfullly";
		}
		else{
			message = "Only the proposer ("+proposer+") may cancel this request.";
		}

	}
	else{
		// get rename information
		RenameDB renameDB = new RenameDB();
		Rename rename = renameDB.getRename(conn,kix);
		if(rename != null){
			fromAlpha = rename.getFromAlpha();
			fromNum = rename.getFromNum();
			toAlpha = rename.getToAlpha();
			toNum = rename.getToNum();
			justification = rename.getJustification();
			proposer = rename.getProposer();

			if(!user.equals(proposer)){
				message = "Only the proposer ("+proposer+") may cancel this request.";
				showForm = false;
			}
		} // rename

		renameDB = null;
		rename = null;
	} // valid form

	// GUI
	String chromeWidth = "60%";
	String pageTitle = "Cancel Rename/Renumber Request";
	fieldsetTitle = pageTitle;

	// reset error or other messages
	session.setAttribute("aseApplicationMessage","");

	asePool.freeConnection(conn,"rnmcanx",user);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/rnmcan.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />

<%

	if (processPage){
%>
		<p align="center"><%=message%></p>
<%
		if (showForm){
%>
			<form method="post" action="rnmcanx.jsp" name="aseForm">
				<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
					<TBODY>
						<TR>
							<TD align="center">
								<TABLE cellSpacing=2 cellPadding=4 width="80%" border=0>
										<TR>
											<TD class="textblackth" width="15%">From:&nbsp;</td>
											<td class="datacolumn" width="85%"><%=fromAlpha%>&nbsp;<%=fromNum%></td>
										</tr>
										<tr>
											<td class="textblackth" width="15%">To:&nbsp;</td>
											<td class="datacolumn" width="85%"><%=toAlpha%>&nbsp;<%=toNum%></td>
										</tr>
										<tr>
											<td class="textblackth" width="15%">Justification:&nbsp;</td>
											<td class="datacolumn" width="85%"><%=justification%></td>
										</tr>
								</table>
								<input type="hidden" value="<%=kix%>" name="kix">
							</TD>
						</TR>

						<TR><TD align="center"><br><br><% out.println(Skew.showInputScreen(request)); %></td></tr>
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
								<input id="cmdYes" type="submit" value=" Yes " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
								<input id="cmdNo" type="submit" value=" No  " class="inputsmallgray" onClick="return cancelForm()">
								<input type="hidden" value="c" name="formAction">
								<input type="hidden" value="aseForm" name="formName">
							</TD>
						</TR>
					</TBODY>
				</TABLE>
			</form>
<%
		}
	} // processPage
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>

