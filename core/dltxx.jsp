<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="ase.jsp" %>

<%
	/**
	*	ASE
	*	dltxx.jsp - totally delete a course from CC
	*	2007.09.01
	**/

	boolean processPage = true;

	if ( !aseUtil.checkSecurityLevel(aseUtil.CAMPADM, session, response, request).equals("") ){
		processPage = false;
		response.sendRedirect("../exp/notauth.jsp");
	}

	String campus = Util.getSessionMappedKey(session,"aseCampus");
	String user = Util.getSessionMappedKey(session,"aseUserName");

	// GUI
	String chromeWidth = "60%";

	String alpha = website.getRequestParameter(request,"alpha","");
	String num = website.getRequestParameter(request,"num","");
	String type = website.getRequestParameter(request,"type","");

	String pageTitle = courseDB.setPageTitle(conn,"",alpha,num,campus);

	if (pageTitle == null || pageTitle.trim().length() == 1){
		processPage = false;
	}

	if (!courseDB.courseExistByTypeCampus(conn,campus,alpha,num,type) && !type.equals("CAN")){
		processPage = false;
	}

	fieldsetTitle = "Permanently Delete Outline";

	String skewedImage = Skew.showInputScreen(request,true);
%>

<html>
<head>
	<%@ include file="ase2.jsp" %>
	<script language="JavaScript" src="js/dlt.js"></script>
</head>
<body topmargin="0" leftmargin="0">

<%@ include file="../inc/header.jsp" %>
<%@ include file="../inc/chromeheader.jsp" %>

<br />

<%
	if (processPage){
%>
	<form method="post" action="dltxy.jsp" name="aseForm">
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TBODY>
				<%
					if (skewedImage != null && skewedImage.length() > 0){
				%>
					<tr>
						<td width="15%">&nbsp;</td>
						<td>
							<br />
							Select 'Continue' to permanently delete <%=alpha%> <%=num%> from Curriculum Central.
							<br/><br/>
							This action is irreversible and is not available for data restoration from backups.
						</td>
					</tr>
					<TR><td width="15%">&nbsp;</td><TD><br><br>
						<%=skewedImage%>
					</td></tr>
					<tr>
						<td width="15%">&nbsp;</td>
						<td>
							<br />
							<input title="continue with request" type="submit" value=" Continue " class="inputsmallgray" onClick="return checkForm('s')">&nbsp;
							<input title="end requested operation" type="submit" value=" Cancel " class="inputsmallgray" onClick="return cancelForm()">
							<input type="hidden" value="c" name="formAction">
							<input type="hidden" value="<%=campus%>" name="campus">
							<input type="hidden" value="<%=alpha%>" name="alpha">
							<input type="hidden" value="<%=num%>" name="num">
							<input type="hidden" value="<%=type%>" name="type">
							<input type="hidden" value="aseForm" name="formName">
						</td>
					</tr>
				<%
					}
					else{
						out.println("Curriculum Central was unable to process your request.");
					}
				%>
			</TBODY>
		</TABLE>
	</form>
	<br>
<%
	}
	else{
%>
		<TABLE cellSpacing=0 cellPadding=0 width="100%" border=0>
			<TBODY>
				<tr>
					<td>
						Invalid course selection or course does not exist.
						<br/>
						<br/>
						<a href="dlt.jsp" class="linkcolumn">try again</a>
					</td>
				</tr>
			</TBODY>
		</TABLE>
<%
	}
%>

<%
	asePool.freeConnection(conn,"dltxx",user);
%>

<%@ include file="../inc/chromefooter.jsp" %>
<%@ include file="../inc/footer.jsp" %>
</body>
</html>
